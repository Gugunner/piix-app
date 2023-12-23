
//TODO: Change all tests to instead work with riverpod
// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:piix_mobile/app_config.dart';
// import 'package:piix_mobile/auth_user_feature_deprecated/data/repository/auth_service_repository_test.dart';
// import 'package:piix_mobile/general_app_feature/api/local/app_shared_preferences.dart';
// import 'package:piix_mobile/general_app_feature/api/piix_api.dart';
// import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
// import 'package:piix_mobile/general_app_feature/utils/constants/constants.dart';
// import 'package:piix_mobile/auth_user_feature_deprecated/data/repository/auth_service_repository.dart';
// import 'package:piix_mobile/auth_feature/domain/model/auth_user_model.dart';
// import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_service_provider.dart';
// import 'package:piix_mobile/auth_user_feature_deprecated/utils/auth_method_enum.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../general_app_feature/api/mock_dio.mocks.dart';
// import '../general_app_feature/api/test_endpoints.dart';

// void main() async {
//   TestWidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences.setMockInitialValues({});
//   setupGetIt();
//   setEndpoints();
//   final appConfig = AppConfig.instance;
//   final mockDio = MockDio();
//   PiixApi.setDio(mockDio);
//   final authServiceProvider = getIt<AuthServiceProvider>();
//   final authServiceRepository = getIt<AuthServiceRepository>();
//   late AuthUserModel authModel;
//   var email = '';
//   var phone = '';
//   var path = '';
//   var verificationCode = '';
//   const userId =
//       '0e13314ed9a5018f369072c44ce241ed0975cd8057367369aef5b6e9f405807a';
//   const hashableCustomAuthToken =
//       '0e13314ed9a5018f369072c44ce241ed0975cd8057367369aef5b6e9f405807a';
//   final hashableUnixTime = DateTime.now().millisecondsSinceEpoch;
//   group('user sends email', () {
//     setUpAll(() {
//       email = 'test@yop.com';
//       path = '${appConfig.backendEndpoint}/users/checkCredentials';
//       authModel = AuthUserModel.credential(
//         usernameCredential: email,
//         authMethod: AuthMethod.emailSignIn,
//       );
//     });

//     setUp(() {
//       authServiceProvider.clearProvider();
//     });

//     test('user sends email succesfully', () async {
//       when(mockDio.post(path, data: authModel.toJson())).thenAnswer(
//         (_) async => Response(
//           requestOptions: RequestOptions(path: path),
//           statusCode: HttpStatus.ok,
//           data: null,
//         ),
//       );
//       await authServiceProvider.sendCredential(
//         credential: email,
//         authMethod: AuthMethod.emailSignIn,
//       );
//       expect(
//         authServiceProvider.credentialState,
//         CredentialState.sent,
//       );
//     });

//     test('user sends already registered email or not registered email',
//         () async {
//       when(mockDio.post(path, data: authModel.toJson())).thenThrow(
//         DioError(
//           requestOptions: RequestOptions(path: path),
//           response: Response(
//             requestOptions: RequestOptions(path: path),
//             statusCode: HttpStatus.conflict,
//             data: <String, dynamic>{
//               'errorName': 'Piix Error Resource has conflict',
//               'errorMessage':
//                   'There was an error with the user you wanted to register',
//               'errorMessages':
//                   '["User found already registered with the email provided"]',
//             },
//           ),
//           type: DioErrorType.badResponse,
//         ),
//       );
//       await authServiceProvider.sendCredential(
//         credential: email,
//         authMethod: AuthMethod.emailSignIn,
//       );
//       expect(
//         authServiceProvider.credentialState,
//         CredentialState.conflict,
//       );
//     });

//     test('App throws a connection time out error to handle request', () async {
//       when(mockDio.post(path, data: authModel.toJson())).thenThrow(
//         DioError(
//           requestOptions: RequestOptions(path: path),
//           type: DioErrorType.connectionTimeout,
//         ),
//       );
//       await authServiceProvider.sendCredential(
//         credential: email,
//         authMethod: AuthMethod.emailSignIn,
//       );
//       expect(
//         authServiceProvider.credentialState,
//         CredentialState.error,
//       );
//     });
//   });

//   group('user sends phone number', () {
//     setUpAll(() {
//       phone = '${Constants.mexicanLada}7854785478';
//       path = '${appConfig.backendEndpoint}/users/checkCredentials';
//       authModel = AuthUserModel.credential(
//         usernameCredential: phone,
//         authMethod: AuthMethod.phoneSignIn,
//       );
//     });

//     setUp(() {
//       authServiceProvider.clearProvider();
//     });

//     test('user sends phone succesfully', () async {
//       when(mockDio.post(path, data: authModel.toJson())).thenAnswer(
//         (_) async => Response(
//           requestOptions: RequestOptions(path: path),
//           statusCode: HttpStatus.ok,
//           data: null,
//         ),
//       );
//       await authServiceProvider.sendCredential(
//         credential: phone,
//         authMethod: AuthMethod.phoneSignIn,
//       );
//       expect(
//         authServiceProvider.credentialState,
//         CredentialState.sent,
//       );
//     });

//     test('user sends already registered email or not registered email',
//         () async {
//       when(mockDio.post(path, data: authModel.toJson())).thenThrow(
//         DioError(
//           requestOptions: RequestOptions(path: path),
//           response: Response(
//             requestOptions: RequestOptions(path: path),
//             statusCode: HttpStatus.conflict,
//             data: <String, dynamic>{
//               'errorName': 'Piix Error Resource has conflict',
//               'errorMessage':
//                   'There was an error with the user you wanted to register',
//               'errorMessages':
//                   '["User found already registered with the email provided"]',
//             },
//           ),
//           type: DioErrorType.badResponse,
//         ),
//       );
//       await authServiceProvider.sendCredential(
//         credential: phone,
//         authMethod: AuthMethod.phoneSignIn,
//       );
//       expect(
//         authServiceProvider.credentialState,
//         CredentialState.conflict,
//       );
//     });

//     test('App throws a connection time out error to handle request', () async {
//       when(mockDio.post(path, data: authModel.toJson())).thenThrow(
//         DioError(
//           requestOptions: RequestOptions(path: path),
//           type: DioErrorType.connectionTimeout,
//         ),
//       );
//       await authServiceProvider.sendCredential(
//         credential: phone,
//         authMethod: AuthMethod.phoneSignIn,
//       );
//       expect(
//         authServiceProvider.credentialState,
//         CredentialState.error,
//       );
//     });
//   });

//   group('user sends verification code with email credential', () {
//     setUpAll(() {
//       email = 'test@yop.com';
//       path = '${appConfig.backendEndpoint}/users/checkVerificationCode';
//       verificationCode = '123456';
//       authModel = AuthUserModel.verification(
//         usernameCredential: email,
//         authMethod: AuthMethod.emailSignUp,
//         verificationCode: verificationCode,
//         hashableUnixTime: hashableUnixTime,
//       );
//     });

//     setUp(() {
//       authServiceProvider.clearProvider();
//     });

//     test(
//         'user sends verification code succesfully to finish email sign up, '
//         'and the user receives an inactive UserAppModel', () async {
//       when(mockDio.post(path, data: authModel.toJson())).thenAnswer(
//         (_) async => Response(
//           requestOptions: RequestOptions(path: path),
//           statusCode: HttpStatus.created,
//           data: authServiceRepository.fakeInactiveUserAppModel(),
//         ),
//       );
//       await authServiceProvider.sendVerificationCode(
//         credential: email,
//         authMethod: AuthMethod.emailSignUp,
//         verificationCode: verificationCode,
//         hashableUnixTime: hashableUnixTime,
//       );
//       expect(
//         authServiceProvider.verificationCodeState,
//         VerificationCodeState.verified,
//       );
//       expect(authServiceProvider.user, isNotNull);

//       expect(
//           authServiceProvider.user!.customAccessToken,
//           authServiceRepository
//               .fakeInactiveUserAppModel()['customAccessToken']);
//       expect(authServiceProvider.user!.completePersonalInformation, false);
//       expect(authServiceProvider.user!.completeDocumentation, false);
//       //Authorized User checks if the user has memberships which
//       //happens when the user is authorized to get an inactive membership
//       expect(authServiceProvider.user!.authorizedUser, false);
//     });

//     test(
//         'user sends verification code succesfully to finish email sign in, '
//         'and the user receives an inactive UserAppModel', () async {
//       authModel = authModel.copyWith(authMethod: AuthMethod.emailSignIn);
//       when(mockDio.post(path, data: authModel.toJson())).thenAnswer(
//         (_) async => Response(
//           requestOptions: RequestOptions(path: path),
//           statusCode: HttpStatus.ok,
//           data: authServiceRepository.fakeInactiveUserAppModel(),
//         ),
//       );
//       await authServiceProvider.sendVerificationCode(
//         credential: email,
//         authMethod: AuthMethod.emailSignIn,
//         verificationCode: verificationCode,
//         hashableUnixTime: hashableUnixTime,
//       );
//       expect(
//         authServiceProvider.verificationCodeState,
//         VerificationCodeState.verified,
//       );
//       expect(authServiceProvider.user, isNotNull);
//       expect(authServiceProvider.user!.completePersonalInformation, false);
//       expect(authServiceProvider.user!.completeDocumentation, false);
//       //Authorized User checks if the user has memberships which
//       //happens when the user is authorized to get an inactive membership
//       expect(authServiceProvider.user!.authorizedUser, false);
//     });

//     test(
//         'user sends wrong verification code email sign up, '
//         'and the user does not receives an inactive UserAppModel', () async {
//       authModel = authModel.copyWith(authMethod: AuthMethod.emailSignUp);
//       when(mockDio.post(path, data: authModel.toJson())).thenThrow(
//         DioError(
//           requestOptions: RequestOptions(
//             path: path,
//           ),
//           response: Response(
//             requestOptions: RequestOptions(path: path),
//             statusCode: HttpStatus.conflict,
//             data: <String, dynamic>{
//               'errorName': 'Piix Error Resource has conflict',
//               'errorMessage': 'There was an error with code sent',
//               'errorMessages':
//                   '["User found already registered with the email provided"]',
//             },
//           ),
//           type: DioErrorType.badResponse,
//         ),
//       );
//       await authServiceProvider.sendVerificationCode(
//         credential: email,
//         authMethod: AuthMethod.emailSignUp,
//         verificationCode: verificationCode,
//         hashableUnixTime: hashableUnixTime,
//       );
//       expect(
//         authServiceProvider.verificationCodeState,
//         VerificationCodeState.conflict,
//       );
//       expect(authServiceProvider.user, isNull);
//     });

//     test(
//         'app receives a connection timeout when sending a '
//         'verification code email sign up, and the user does not receives '
//         'an inactive UserAppModel', () async {
//       when(mockDio.post(path, data: authModel.toJson())).thenThrow(
//         DioError(
//           requestOptions: RequestOptions(
//             path: path,
//           ),
//           type: DioErrorType.connectionTimeout,
//         ),
//       );
//       await authServiceProvider.sendVerificationCode(
//         credential: email,
//         authMethod: AuthMethod.emailSignUp,
//         verificationCode: verificationCode,
//         hashableUnixTime: hashableUnixTime,
//       );
//       expect(
//         authServiceProvider.verificationCodeState,
//         VerificationCodeState.error,
//       );
//       expect(authServiceProvider.user, isNull);
//     });
//   });

//   group('user sends verification code with phone credential', () {
//     setUpAll(() {
//       phone = '${Constants.mexicanLada}7854785478';
//       path = '${appConfig.backendEndpoint}/users/checkVerificationCode';
//       verificationCode = '123456';
//       authModel = AuthUserModel.verification(
//         usernameCredential: phone,
//         authMethod: AuthMethod.phoneSignUp,
//         verificationCode: verificationCode,
//         hashableUnixTime: hashableUnixTime,
//       );
//     });

//     setUp(() {
//       authServiceProvider.clearProvider();
//       AppSharedPreferences.clear();
//     });

//     test(
//         'user sends verification code succesfully to finish phone sign up, '
//         'and the user receives an inactive UserAppModel', () async {
//       when(mockDio.post(path, data: authModel.toJson())).thenAnswer(
//         (_) async => Response(
//           requestOptions: RequestOptions(path: path),
//           statusCode: HttpStatus.created,
//           data: authServiceRepository.fakeInactiveUserAppModel(),
//         ),
//       );
//       await authServiceProvider.sendVerificationCode(
//         credential: phone,
//         authMethod: AuthMethod.phoneSignUp,
//         verificationCode: verificationCode,
//         hashableUnixTime: hashableUnixTime,
//       );
//       expect(
//         authServiceProvider.verificationCodeState,
//         VerificationCodeState.verified,
//       );
//       expect(authServiceProvider.user, isNotNull);
//       expect(
//           authServiceProvider.user!.customAccessToken,
//           authServiceRepository
//               .fakeInactiveUserAppModel()['customAccessToken']);
//       expect(authServiceProvider.user!.completePersonalInformation, false);
//       expect(authServiceProvider.user!.completeDocumentation, false);
//       //Authorized User checks if the user has memberships which
//       //happens when the user is authorized to get an inactive membership
//       expect(authServiceProvider.user!.authorizedUser, false);
//     });

//     test(
//         'user sends verification code succesfully to finish phone sign in, '
//         'and the user receives an inactive UserAppModel', () async {
//       authModel = authModel.copyWith(authMethod: AuthMethod.phoneSignIn);
//       when(mockDio.post(path, data: authModel.toJson())).thenAnswer(
//         (_) async => Response(
//           requestOptions: RequestOptions(path: path),
//           statusCode: HttpStatus.ok,
//           data: authServiceRepository.fakeInactiveUserAppModel(),
//         ),
//       );
//       await authServiceProvider.sendVerificationCode(
//         credential: phone,
//         authMethod: AuthMethod.phoneSignIn,
//         verificationCode: verificationCode,
//         hashableUnixTime: hashableUnixTime,
//       );
//       expect(
//         authServiceProvider.verificationCodeState,
//         VerificationCodeState.verified,
//       );
//       expect(authServiceProvider.user, isNotNull);
//       expect(authServiceProvider.user!.completePersonalInformation, false);
//       expect(authServiceProvider.user!.completeDocumentation, false);
//       //Authorized User checks if the user has memberships which
//       //happens when the user is authorized to get an inactive membership
//       expect(authServiceProvider.user!.authorizedUser, false);
//     });

//     test(
//         'user sends verification code succesfully '
//         'and the app stores auth information', () async {
//       authModel = authModel.copyWith(authMethod: AuthMethod.phoneSignIn);
//       var authUser = await AppSharedPreferences.recoverAuthUser();
//       expect(authUser, isNull);
//       when(mockDio.post(path, data: authModel.toJson())).thenAnswer(
//         (_) async => Response(
//           requestOptions: RequestOptions(path: path),
//           statusCode: HttpStatus.ok,
//           data: authServiceRepository.fakeInactiveUserAppModel(),
//         ),
//       );
//       await authServiceProvider.sendVerificationCode(
//         credential: phone,
//         authMethod: AuthMethod.phoneSignIn,
//         verificationCode: verificationCode,
//         hashableUnixTime: hashableUnixTime,
//       );
//       expect(
//         authServiceProvider.verificationCodeState,
//         VerificationCodeState.verified,
//       );
//       authUser = await AppSharedPreferences.recoverAuthUser();
//       expect(authUser, isNotNull);
//       expect(authUser!.userId, authServiceProvider.user!.customAccessToken);
//       expect(authUser.usernameCredential, phone);
//       expect(authUser.authMethod, AuthMethod.phoneSignIn);
//       expect(authUser.customAccessToken,
//           authServiceProvider.user!.customAccessToken);
//       expect(authUser.hashableUnixTime, hashableUnixTime);
//       expect(authUser.authorizedUser, authServiceProvider.user!.authorizedUser);
//     });

//     test(
//         'user sends wrong verification code phone sign up, '
//         'and the user does not receives an inactive UserAppModel', () async {
//       authModel = authModel.copyWith(authMethod: AuthMethod.phoneSignUp);
//       when(mockDio.post(path, data: authModel.toJson())).thenThrow(
//         DioError(
//           requestOptions: RequestOptions(
//             path: path,
//           ),
//           response: Response(
//             requestOptions: RequestOptions(path: path),
//             statusCode: HttpStatus.conflict,
//             data: <String, dynamic>{
//               'errorName': 'Piix Error Resource has conflict',
//               'errorMessage': 'There was an error with code sent',
//               'errorMessages':
//                   '["User found already registered with the email provided"]',
//             },
//           ),
//           type: DioErrorType.badResponse,
//         ),
//       );
//       await authServiceProvider.sendVerificationCode(
//         credential: phone,
//         authMethod: AuthMethod.phoneSignUp,
//         verificationCode: verificationCode,
//         hashableUnixTime: hashableUnixTime,
//       );
//       expect(
//         authServiceProvider.verificationCodeState,
//         VerificationCodeState.conflict,
//       );
//       expect(authServiceProvider.user, isNull);
//     });

//     test(
//         'app receives a connection timeout when sending a '
//         'verification code phone sign up, and the user does not receives '
//         'an inactive UserAppModel', () async {
//       when(mockDio.post(path, data: authModel.toJson())).thenThrow(
//         DioError(
//           requestOptions: RequestOptions(
//             path: path,
//           ),
//           type: DioErrorType.connectionTimeout,
//         ),
//       );
//       await authServiceProvider.sendVerificationCode(
//         credential: phone,
//         authMethod: AuthMethod.phoneSignUp,
//         verificationCode: verificationCode,
//         hashableUnixTime: hashableUnixTime,
//       );
//       expect(
//         authServiceProvider.verificationCodeState,
//         VerificationCodeState.error,
//       );
//       expect(authServiceProvider.user, isNull);
//     });
//   });

//   group('user sends hashable auth values', () {
//     setUpAll(() {
//       path = '${appConfig.backendEndpoint}/users/customToken';
//       authModel = AuthUserModel.autoSignIn(
//         userId: userId,
//         customAccessToken: hashableCustomAuthToken,
//         hashableUnixTime: hashableUnixTime,
//       );
//     });
//     setUp(() {
//       authServiceProvider.clearProvider();
//     });

//     test(
//         'user sends auth values succesfully and receives data, '
//         'for a valid UserAppModel', () async {
//       when(mockDio.post(path, data: authModel.toJson())).thenAnswer(
//         (_) async => Response(
//           requestOptions: RequestOptions(path: path),
//           statusCode: HttpStatus.ok,
//           data: authServiceRepository.fakeActiveUserAppModel(),
//         ),
//       );
//       await authServiceProvider.sendHashableAuthValues(
//         userId: userId,
//         hashableCustomAuthToken: hashableCustomAuthToken,
//         hashableUnixTime: hashableUnixTime,
//         useFirebase: false,
//       );
//       expect(authServiceProvider.authState, AuthState.authorized);
//       expect(authServiceProvider.user, isNotNull);
//     });

//     test('App receives a 400+ response after sending hashable auth values',
//         () async {
//       when(mockDio.post(path, data: authModel.toJson())).thenThrow(
//         DioError(
//           requestOptions: RequestOptions(
//             path: path,
//           ),
//           response: Response(
//             requestOptions: RequestOptions(path: path),
//             statusCode: HttpStatus.badRequest,
//             data: <String, dynamic>{
//               'errorName': 'Piix Error Bad Request',
//               'errorMessage':
//                   'There was an error with the hashable auth values',
//               'errorMessages':
//                   '["User hashable auth custom token could not be recognized "]',
//             },
//           ),
//           type: DioErrorType.badResponse,
//         ),
//       );
//       await authServiceProvider.sendHashableAuthValues(
//         userId: userId,
//         hashableCustomAuthToken: hashableCustomAuthToken,
//         hashableUnixTime: hashableUnixTime,
//         useFirebase: false,
//       );
//       expect(authServiceProvider.authState, AuthState.unauthorized);
//       expect(authServiceProvider.user, isNull);
//     });

//     test(
//         'App receives a connection timeour or other '
//         'after sending hashable auth values', () async {
//       when(mockDio.post(path, data: authModel.toJson())).thenThrow(
//         DioError(
//           requestOptions: RequestOptions(
//             path: path,
//           ),
//           type: DioErrorType.connectionTimeout,
//         ),
//       );
//       await authServiceProvider.sendHashableAuthValues(
//         userId: userId,
//         hashableCustomAuthToken: hashableCustomAuthToken,
//         hashableUnixTime: hashableUnixTime,
//         useFirebase: false,
//       );
//       expect(authServiceProvider.authState, AuthState.unauthorized);
//       expect(authServiceProvider.user, isNull);
//     });
//   });
// }
