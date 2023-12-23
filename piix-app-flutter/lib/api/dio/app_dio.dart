import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/auth_feature/data/repository/auth_repository.dart';
import 'package:piix_mobile/general_app_feature/api/local/app_shared_preferences.dart';
import 'package:piix_mobile/utils/endpoints.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/navigation_feature/navigation_utils_barrel_file.dart';
import 'package:piix_mobile/welcome_screen.dart';

abstract class AppDioBase {
  // ignore: unused_field
  late Dio _initialDio;
  late Dio _dio;
  Dio get dio => _dio;

  ///Sets the dio with a universal secure configuration.
  void configure(Dio dio) {
    ///Configures the options for the Http requests
    ///and inyects the [InterceptorWrapper]
    dio
      ..options.baseUrl = 'https://'
      ..options.connectTimeout = const Duration(seconds: 60000)
      ..options.receiveTimeout = const Duration(seconds: 60000)
      ..options.headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
      };
    dio.interceptors.add(_AppDioInterceptor(dio));
  }

  void set(Dio dio) {
    _dio = dio;
  }
}

///The singleton instance used to handle [Dio].
final class AppDio extends AppDioBase {
  static final _instance = AppDio._singleton();

  factory AppDio() => _instance;

  AppDio._singleton() {
    set(Dio());
    _initialDio = dio;
    configure(dio);
  }
}

///An app interceptor that handles [onRequest], [onResponse]
///and [onError].
final class _AppDioInterceptor extends InterceptorsWrapper
    with AppDioProcessor, AppDioLogger {
  _AppDioInterceptor(this.dio);
  final Dio dio;

  ///The internal variable that counts how many times
  ///the app has retried getting an auth token.
  int retryCount = 0;

  ///Maximum number of retries when an auth token is not valid
  ///to try and get a new auth token.
  int get _maxRetries => 2;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final pathWithUserId = await getPathWithUserId(options);
    if (pathWithUserId.isNotNullEmpty) {
      options.path = pathWithUserId!;
    }
    removeModelType(options);
    final bearer = await getBearer();
    if (bearer.isNotNullEmpty) {
      options.headers['authorization'] = bearer;
    }
    logRequest(options);
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (retryCount > 0) retryCount = 0;
    return handler.resolve(response);
  }

  void _onUnauthorized(
      DioException exception, ErrorInterceptorHandler handler) async {
    logUnauthorized(exception);
    //Rejects the request and prevents any other interceptor process from
    //executing.
    handler.reject(exception);
    retryCount = 0;
    NavigatorKeyState().getNavigator()?.pushNamedAndRemoveUntil(
          WelcomeScreen.routeName,
          ModalRoute.withName(WelcomeScreen.routeName),
        );
    AppSharedPreferences.clear();
    AuthRepository().signOut();
  }

  ///Handles when the user needs to refresh the [idToken] of the [user]
  ///inside the [FirebaseAuth] instance.
  void _onRefreshToken(
      DioException exception, ErrorInterceptorHandler handler) async {
    //If the number of retries has reached the maximum number of retries
    //the user is unauthorized.
    if (retryCount >= _maxRetries) return _onUnauthorized(exception, handler);
    //Add one to the retries.
    retryCount++;
    //Recover the stored user with the information for auto signin in.
    final authModel = (await AppSharedPreferences.recoverAuthUser())?.autoSign;
    //If there is no user stored, that means that there is no current active
    //app session and the user trying to enter is unauthorized.
    if (authModel == null) return _onUnauthorized(exception, handler);
    //Calls for a custom access token for the user which returns the current
    //user with a new custom access token.
    final user = await AuthRepository().getCustomTokenForUser(authModel);
    final customAccessToken = user.customAccessToken;
    //If the user does not contain a token this means the service does
    //not authorize the user.
    if (customAccessToken == null) return _onUnauthorized(exception, handler);
    final userCredential =
        await AuthRepository().signInWithCustomToken(customAccessToken);
    final idToken = await userCredential.user?.getIdToken();
    //If there is no token it means that the app [FirebaseAuth]
    //instance does not authorize the user.
    if (idToken == null) return _onUnauthorized(exception, handler);
    //Store both the token of [FirebaseAuth] and the new user.
    await AppSharedPreferences.saveAuthoken(idToken);
    await AppSharedPreferences.storeUser(user: user);
    //Add the new authorization bearer to the [RequestOptions] headers.
    dio.options.headers['authorization'] = await getBearer();
    //Try again to make the same request that throwed the error in the first
    //place.
    final newResponse = await dio.request(exception.requestOptions.path);
    //If successful reset any other retries.
    retryCount = 0;
    //Resolves the response and stops any other interceptor from
    //executing.
    return handler.resolve(newResponse);
  }

  @override
  void onError(DioException exception, ErrorInterceptorHandler handler) async {
    final statusCode = exception.response?.statusCode ?? 500;
    if (statusCode == HttpStatus.unauthorized) {
      return _onUnauthorized(exception, handler);
    }
    if (statusCode == HttpStatus.notAcceptable ||
        statusCode == HttpStatus.forbidden) {
      return _onRefreshToken(exception, handler);
    }
    logRequestError(exception);
    return handler.reject(exception);
  }
}

///A separate mixin class that processess the [RequestOptions] and
///modifies it inside its methods.
mixin AppDioProcessor {
  ///To avoid any issues while sending any request any
  ///modelType property is deleted from the Json model.
  void removeModelType(RequestOptions options) {
    if (options.data is Map) {
      (options.data as Map).remove('modelType');
    }
  }

  ///Obtains the [authToken] from [AppSharedPreferences] and
  ///returns a 'Bearer {token}' or null if there is no [authToken]
  ///stored.
  Future<String?> getBearer() async {
    final token = await AppSharedPreferences.recoverAuthToken();
    if (token.isNullOrEmpty) return null;
    return 'Bearer ${token ?? ''}';
  }

  ///Checks if the path is registered as an endpoint that needs
  ///a userId parameter.
  bool _shouldAddUserId(String path) {
    final rawPath = path.split('?').first;
    //First iterates the endpoints to see if the path matches
    //with any of the endpoints that need a userId parameter.
    return EndPoints.needUserId.any((element) {
      final rawElement = element.split('?').first;
      return rawElement == rawPath;
    });
  }

  ///By readign the path property of the [options] it checks if
  ///the path needs to add the 'userId' parameter to it and whether
  ///it is the only parameter or one of many parameters.
  Future<String?> getPathWithUserId(RequestOptions options) async {
    final path = options.path;
    //Recover the current id of the user.
    final userId = (await AppSharedPreferences.recoverAuthUser())?.userId;
    //If no id is found return null meaning the user has not
    //signed in to the app.
    if (userId.isNullOrEmpty) return null;
    //Checks if a userId should be added if not then returns null
    //the path does not need to add a userId parameter.
    if (!_shouldAddUserId(path) ||
        //This check is just to make sure an endpoint managed
        //inside a repository or api class does not contain already
        //the userId parameter
        path.contains('userId')) return null;
    //Assign the userId as either the first or next parameter.
    final symbol = path.contains('?') ? '&' : '?';
    //Return the path with the userId parameter
    return '$path${symbol}userId=$userId';
  }
}

///A separate mixin class that uses a [PiixLogger] to
///requests and errors.
mixin AppDioLogger {
  PiixLogger get logger => PiixLogger.instance;

  ///Logs all request methods and paths locally for debugging purposes.
  void logRequest(RequestOptions options) async {
    logger
      ..log(
        level: Level.debug,
        logMessage: 'Request[${options.method}]: '
            'Endpoint: ${AppConfig.instance.getEndpoint(options.path)}\n'
            'Service called - ${options.path}\n'
            'Token: ${options.headers['authorization']}\n'
            'Body ${options.data}',
      );
  }

  ///Logs any error that is detected that occurs
  ///due to an error by the server.
  void logRequestError(DioException exception) {
    final logMessage = logger.errorMessage(
      messageName: 'The request returned an Error',
      message: exception.toString(),
      isLoggable: true,
    );
    logger.log(
      logMessage: logMessage.toString(),
      error: exception,
      level: Level.error,
      sendToCrashlytics: true,
    );
  }

  ///Logs the specific case when a user is not
  ///authorized to access either the service requested
  ///or the account.
  void logUnauthorized(DioException exception) {
    final logMessage = logger.errorMessage(
      messageName: 'The auth token was unauthorized',
      message: exception.toString(),
      isLoggable: false,
    );
    logger.log(
      logMessage: logMessage.toString(),
      error: exception,
      level: Level.error,
      sendToCrashlytics: true,
    );
  }
}
