import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/data/repository/auth_service_repository.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_service_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/api/local/app_shared_preferences.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/app_bloc.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/endpoints.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_values.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_interceptors_deprecated.dart';

@Deprecated('Will be removed in 4.0')

/// PiixApi contains all http request methods and dio configurations.
class PiixApiDeprecated extends Interceptor {
  static Dio _dio = Dio();

  static bool _appTest = false;

  static void setDio(Dio dio) {
    _dio = dio;
    _appTest = true;
  }

  /// Set all configurations in dio.
  static Future<void> configureDio() async {
    _dio
      ..options.baseUrl = 'https://'
      ..options.connectTimeout = const Duration(seconds: 60000)
      ..options.receiveTimeout = const Duration(seconds: 60000)
      ..options.headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
      };
    _dio.interceptors.add(
      PiixApiInterceptorsDeprecated(),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (onRequestInterceptor),
        onError: (onErrorInterceptor),
      ),
    );
  }

  ///Simple interceptor that is executed each time this [_dio] requests are made
  ///
  ///Adds the stored id token into the header of the request
  ///Receives the [options] from the original request as a map
  ///Receives a [handler] from the [Interceptor] to control calling another
  ///interceptor or to launch the request depending whether another interceptor
  ///is in queue.
  ///Uses return to indicate the method it has finished and can exit.
  static void onRequestInterceptor(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final userBLoC = getIt<UserBLoCDeprecated>();
    if (options.path == PiixAppEndpoints.getLevelsAndPlansEndpoint) {
      final userId = userBLoC.user?.userId;
      options.path += '?userId=$userId';
    }
    final authToken = await AppSharedPreferences.recoverAuthToken();
    final loggerInstance = PiixLogger.instance;
    loggerInstance.log(
      level: Level.debug,
      logMessage: 'Service called - ${options.path}',
    );
    loggerInstance.log(
      level: Level.debug,
      logMessage: 'Current AuthToken - $authToken',
    );
    options.headers['authorization'] = 'Bearer ${authToken ?? ''}';
    if (options.data is Map) {
      (options.data as Map).remove('modelType');
    }
    return handler.next(options);
  }

  ///Complex interceptor that is executed each time this [_dio] requests returns a [DioError]\
  ///
  ///Checks for specific [HttpStatus] values such as unauthorized, forbidden
  /// or notAcceptable to manage an automatic sign out of the app or an update
  /// to an expired [FirebaseAuth] id token and retry the request.
  ///
  /// Receives a [dioError] which contains the original [RequestOptions] to
  /// either send the final error to the original caller or to obtain the
  /// information for a new retry request.
  /// Receives a [handler] from the [Interceptor] to controll the rejection of
  /// the request and avoid calling any other queued interceptor.
  /// Uses return to indicate the method it has finished and can exit.
  static void onErrorInterceptor(
    DioError dioError,
    ErrorInterceptorHandler handler,
  ) async {
    final appBLoC = getIt<AppBLoC>();
    final loggerInstance = PiixLogger.instance;
    //Checks auth and updates the token when the app is not in test mode
    if (!_appTest) {
      final errorMessages = AppApiLogException.fromDioException(dioError);
      final statusCode = errorMessages.statusCode;
      //Checks specific codes to know if the request has some
      //authentication issues
      if (statusCode == HttpStatus.unauthorized) {
        //TODO: Uncomment once it is safe to add 403
        // || statusCode == HttpStatus.forbidden) {
        //Assigns the state to revoked so the user can
        //get an alert of why it is being thrown off the app
        appBLoC.signInState = SignInState.revokedToken;
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
        //First it calls the rejection of the request so the error
        //is thrown to the original caller.
        handler.reject(dioError);
        //Finally it calls for a full state clean, signs out of the app
        //and returns to LoginScreen.
        await appBLoC.signOut(
          trigger: PiixAnalyticsValues.invalidFirebaseToken,
        );
        return;
      }
      //Reads for the 406 code to know if id token is expired
      if (statusCode == HttpStatus.notAcceptable ||
          statusCode == HttpStatus.forbidden) {
        //Gets the [RequestOptions] from the [dioError]
        final options = dioError.requestOptions;
        //Tries to update token and store it in [SharedPreferences] storage
        final path = options.path;
        //Recovers the newly stored id token
        final authServiceProvider = getIt<AuthServiceProvider>();

        if (statusCode == HttpStatus.forbidden) {
          final logMessage = loggerInstance.errorMessage(
            messageName: 'The auth token was revoked',
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
        final authUser = await AppSharedPreferences.recoverAuthUser();
        await authServiceProvider.sendHashableAuthValues(
          userId: authUser?.userId ?? '',
          hashableCustomAuthToken: authUser?.customAccessToken ?? '',
          hashableUnixTime: authUser?.hashableUnixTime ?? -1,
        );
        if (authServiceProvider.authState == AuthState.idle ||
            authServiceProvider.authState == AuthState.unauthorized) return;
        final authToken = await AppSharedPreferences.recoverAuthToken();
        //Builds the new options with the new id token
        options
          ..baseUrl = 'https://'
          ..connectTimeout = const Duration(seconds: 60000)
          ..receiveTimeout = const Duration(seconds: 60000)
          ..headers['authorization'] = 'Bearer ${authToken ?? ''}';
        final newOptions = Options(
          method: options.method,
          headers: options.headers,
        );
        //Makes a new request with a new instance of Dio that
        //is eliminated after the request is made again, this is
        //done to avoid looping the requests if the same error
        //is thrown from the server
        final newRequest = await _dio
            .request(
          path,
          data: options.data,
          options: newOptions,
          queryParameters: options.queryParameters,
        )
            .catchError((dioError) {
          final logMessage = loggerInstance.errorMessage(
            messageName: 'The request failed after token was refeshed',
            message: dioError.toString(),
            isLoggable: false,
          );
          loggerInstance.log(
            logMessage: logMessage.toString(),
            error: dioError,
            level: Level.error,
            sendToCrashlytics: true,
          );
          handler.reject(dioError);
          return dioError;
        }, test: (error) {
          return error is int && error >= 400;
        });
        //Finnaly if succesful, it returns the response to the
        //original caller
        return handler.resolve(newRequest);
      }
    }
    //If the code is not considered in the conditions
    //it throws the error back to the original caller
    return handler.reject(dioError);
  }

  /// Get function is a get http request
  static Future<Response> get(String path) async {
    final resp = await _dio.get(path);
    return resp;
  }

  /// Post function is a post http request
  static Future<Response> post(
      {required String path, required Map<String, dynamic> data}) async {
    final resp = await _dio.post(path, data: data);
    return resp;
  }

  /// Put function is a put http request
  static Future<Response> put(
      {required String path, required Map<String, dynamic> data}) async {
    final resp = await _dio.put(path, data: data);
    return resp;
  }

  /// Delete function is a delete http request
  static Future<Response> delete(
      {required String path, required Map<String, dynamic> data}) async {
    final resp = await _dio.delete(path, data: data);
    return resp;
  }

  /// checkStatusCode is function that check status code in all http requests.
  static bool checkStatusCode({required int statusCode}) {
    var successfulStatusCode = false;
    if (statusCode == 200 || statusCode == 201 || statusCode == 204) {
      successfulStatusCode = true;
    }
    return successfulStatusCode;
  }
}
