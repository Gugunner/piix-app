import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/auth_feature/domain/provider/auth_service_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/api/local/app_shared_preferences.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/app_bloc.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_values.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:piix_mobile/utils/log_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:piix_mobile/utils/endpoints.dart';

part 'piix_dio_provider_deprecated.g.dart';

//TODO: Remove any getIt call and replace with Riverpod providers

@Deprecated('Will be removed in 4.0')

///A Riverpod class that is initialized as soon as the app
///launches to handle Http Requests with a single
///[Dio] instance
@Riverpod(keepAlive: true)
class PiixDio extends _$PiixDio {
  @override
  Dio build() => _PiixDioDeprecated(ref).dio;
}

@Deprecated('Will be removed in 4.0')
class _PiixDioDeprecated with _PiixDioProviders, _PiixDioLogger, LogAppCall {
  final Dio dio;
  final NotifierProviderRef ref;
  _PiixDioDeprecated(this.ref)
      : dio = Dio()

          ///Configures the options for the Http requests
          ///and inyects the [InterceptorWrapper]
          ..interceptors.add(_PiixDioInterceptor(ref))
          ..options.baseUrl = 'https://'
          ..options.connectTimeout = const Duration(seconds: 60000)
          ..options.receiveTimeout = const Duration(seconds: 60000)
          ..options.headers = {
            HttpHeaders.contentTypeHeader: 'application/json',
          };
}

///Handles all the interceptions that occur when
///doing an Http request.
///
///Signs out the user if the [authToken] is not
///authorized, refreshes the [authToken] when
///it is no longer acceptable.
class _PiixDioInterceptor extends InterceptorsWrapper
    with _PiixDioProviders, _PiixDioLogger, LogAppCall {
  //Initializes with [ref] to access all riverpod providers
  //so it can replace get It service locators
  _PiixDioInterceptor(this.ref);

  final NotifierProviderRef ref;
  bool refresh = true;

  ///Used for all models that are sent as Json to the server and
  ///do not allow 'modelType' property.
  void _removeModelType(RequestOptions options) {
    if (options.data is Map) {
      (options.data as Map).remove('modelType');
      return;
    }
  }

  ///Prepares the request [options] and handles the authorization
  ///of the request.
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    ///Reads the idToken and either calls on the complete request
    ///or executes the parent onRequest call.
    _logRequest(options);
    _addUserId(options, handler);
    _removeModelType(options);
    final token = await AppSharedPreferences.recoverAuthToken();
    if (token.isNotNullEmpty)
      options.headers['authorization'] = 'Bearer ${token ?? ''}';
    PiixLogger.instance.log(
      logMessage: 'With authorization - ${options.headers['authorization']}',
      level: Level.debug,
    );
    return;
  }

  ///Resets the [refresh] to true if a successful response is returned.
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    //Resets retry as onResponse only executes if succesful request
    if (!refresh) refresh = true;
    return handler.resolve(response);
  }

  ///Signs out the user and ends the request with an error.
  void _handleUnauthorized(
      DioException dioError, ErrorInterceptorHandler handler) async {
    final appBLoC = getIt<AppBLoC>();
    appBLoC.signInState = SignInState.revokedToken;
    _logUnauthorized(dioError);
    handler.reject(dioError);
    return await appBLoC.signOut(
      trigger: PiixAnalyticsValues.invalidFirebaseToken,
    );
  }

  ///Handles refreshing the token once before signing the use out
  ///if the token is still not acceptable after refreshing it.
  void _handleRefreshToken(
      DioException dioError, ErrorInterceptorHandler handler) async {
    //Avoids infinite loop of refreshing token
    if (refresh == false) {
      return _handleUnauthorized(dioError, handler);
    }
    //Error is handled inside the called method to obtain new customAccessToken
    await ref.read(customTokenServiceProvider.notifier).getCustomToken();

    ///Catch the error that is already logged
    final authState = ref.read(authStatePodProvider);

    ///Checks if sending the hashable values was unsuccesful
    if (authState == AuthState.idle || authState == AuthState.unauthorized)
      return handler.reject(dioError);
    final token = await AppSharedPreferences.recoverAuthToken();

    ///Gets the same Dio instance that was used to call the first request
    final appDio = ref.read(piixDioProvider);

    ///Reads the new token and either tries again the request or
    ///if the token can't be retrieved it rejects the request.
    //Updates the token for the header
    appDio.options.headers['authorization'] = 'Bearer ${token ?? ''}';

    ///Blocks any future refresh unless a succesful response is returned
    refresh = false;
    final options = dioError.requestOptions;

    ///Tries again the request
    final response = await appDio.request(options.path);
    return handler.resolve(response);
  }

  ///Handles signing out the user, refreshing the token or
  ///simply returning the [dioError].
  @override
  void onError(DioException dioError, ErrorInterceptorHandler handler) async {
    final statusCode = dioError.response?.statusCode ?? 500;
    if (statusCode == HttpStatus.unauthorized)
      return _handleUnauthorized(dioError, handler);
    final notAcceptable = statusCode == HttpStatus.notAcceptable ||
        statusCode == HttpStatus.forbidden;
    if (notAcceptable) return _handleRefreshToken(dioError, handler);
    _logError(dioError);
    return handler.reject(dioError);
  }
}

///A simple mixin to centralize Dio Log methods.
mixin _PiixDioLogger {
  void _logRequest(RequestOptions options) async {
    // final authToken = await AppSharedPreferences.recoverAuthToken();
    final loggerInstance = PiixLogger.instance;
    loggerInstance
      ..log(
        level: Level.debug,
        logMessage: 'Request[${options.method}]: '
            'Service called - ${options.path}',
      );
  }

  void _logUnauthorized(DioException dioError) {
    final loggerInstance = PiixLogger.instance;
    final logMessage = loggerInstance.errorMessage(
      messageName: 'The auth token was unauthorized',
      message: dioError.toString(),
      isLoggable: false,
    );
    loggerInstance.log(
      logMessage: logMessage.toString(),
      error: dioError,
      level: Level.error,
      sendToCrashlytics: true,
    );
  }

  void _logError(DioException dioError) {
    final loggerInstance = PiixLogger.instance;
    final logMessage = loggerInstance.errorMessage(
      messageName: 'The request returned an Error',
      message: dioError.toString(),
      isLoggable: true,
    );
    loggerInstance.log(
      logMessage: logMessage.toString(),
      error: dioError,
      level: Level.error,
      sendToCrashlytics: true,
    );
  }
}

//Using a mixin to separate providers that will be
//replaced with riverpod providers
mixin _PiixDioProviders {
  UserBLoCDeprecated get userBLoC => getIt<UserBLoCDeprecated>();

  ///Checks if the current path used for the endpoint
  ///needs to add the [userId] in the parameters
  bool _needsUserId(String path) {
    final cleanPath = path.split('?').first;
    return EndPoints.needUserId
        .any((element) => element.replaceAll('?', '') == cleanPath);
  }

  ///Adds the [userId] parameter to the [path]
  void _addUserId(RequestOptions options, RequestInterceptorHandler handler) {
    final path = options.path;
    final userId = userBLoC.user?.userId;
    if (!_needsUserId(path) || path.contains('userId')) {
      return handler.next(options);
    }
    final symbol = path.contains('?') ? '&' : '?';
    options.path = '$path$symbol' + 'userId=$userId';
  }
}
