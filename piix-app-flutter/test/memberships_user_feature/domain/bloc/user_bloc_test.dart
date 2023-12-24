// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:piix_mobile/app_config.dart';
// import 'package:piix_mobile/auth_feature/domain/model/user_app_model.dart';
// import 'package:piix_mobile/auth_feature/utils/auth_method_enum.dart';
// import 'package:piix_mobile/file_feature/domain/model/request_file_model.dart';
// import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/user_credential_model.dart';
// import 'package:piix_mobile/env/dev.env.dart';
// import 'package:piix_mobile/general_app_feature/api/piix_api.dart';
// import 'package:piix_mobile/general_app_feature/data/repository/file_system_repository.dart';
// import 'package:piix_mobile/general_app_feature/data/repository/file_system_repository_app_use_test.dart';
// import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
// import 'package:piix_mobile/general_app_feature/utils/constants/endpoints.dart';
// import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/user_repository.dart';
// import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/user_repository_use_case_test.dart';
// import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc.dart';
// import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/membership_model/membership_model.dart';
// import 'package:piix_mobile/user_profile_feature/domain/model/update_credential_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../../general_app_feature/api/mock_dio.mocks.dart';

// @Deprecated('when implement new log in and this test will changed')
// void main() {
//   setupGetIt();
//   final appConfig = AppConfig.instance;
//   appConfig
//     ..setBackendEndPoint(DevEnv.backendEndpoint)
//     ..setCatalogSQLURL(DevEnv.catalogEndpoint)
//     ..setSignUpEndpoint(DevEnv.signUpEndpoint)
//     ..setPaymentEndpoint(DevEnv.paymentEndpoint);
//   final mockDio = MockDio();
//   final userBLoC = UserBLoC();
//   final userRepository = getIt<UserRepository>();
//   final fakeUser = userRepository.fakeJsonUser();
//   final fakeUserLevelsAndPlans = userRepository.fakeJsonUserLevelsAndPlans();
//   PiixApi.setDio(mockDio);
//   var path = '';
//   var usernameCredential = '';
//   late UserCredentialModel credentialModel;
//   var currentCredential = '';
//   var newCredential = '';
//   var userId = '';
//   late UpdateEmailRequestModel updateEmailRequestModel;
//   late UpdatePhoneNumberRequestModel updatePhoneNumberRequestModel;
//   SharedPreferences.setMockInitialValues({});
//   var authMethod = AuthMethod.phoneSignIn;

//   group('get user by email username credential', () {
//     setUpAll(() {
//       usernameCredential = 'mich.bubbla@g.com';
//       credentialModel =
//           UserCredentialModel(usernameCredential: usernameCredential);
//       path =
//           '${appConfig.backendEndpoint}/users/email?email=${credentialModel.usernameCredential}';
//       authMethod = AuthMethod.emailSignIn;
//     });

//     setUp(() {
//       userBLoC.userActionState = UserActionState.idle;
//       userBLoC.user = null;
//     });

//     test(
//         'when the service http code response is 200 and includes data '
//         'that is a valid UserAppModel, the UserActionState is retrieved',
//         () async {
//       expect(userBLoC.user, null);
//       when(mockDio.get(path)).thenAnswer((_) async => Response(
//             requestOptions: RequestOptions(path: path),
//             statusCode: HttpStatus.ok,
//             data: fakeUser,
//           ));
//       await userBLoC.getUserByUsernameCredential(
//         usernameCredential: usernameCredential,
//         isPhoneNumber: authMethod.isPhoneNumber,
//       );
//       expect(userBLoC.user!.displayName, fakeUser['names']);
//       expect(userBLoC.userActionState, UserActionState.retrieved);
//     });

//     test(
//         'when the service http code response is 200 but does not include data '
//         'that is a valid UserAppModel, the UserActionState is error', () async {
//       expect(userBLoC.user, null);
//       when(mockDio.get(path)).thenAnswer((_) async => Response(
//             requestOptions: RequestOptions(path: path),
//             statusCode: HttpStatus.ok,
//             data: null,
//           ));
//       await userBLoC.getUserByUsernameCredential(
//         usernameCredential: usernameCredential,
//         isPhoneNumber: authMethod.isPhoneNumber,
//       );
//       expect(userBLoC.user, null);
//       expect(userBLoC.userActionState, UserActionState.error);
//     });

//     test(
//         'when the service http code response is 404, '
//         'the UserActionState is notFound', () async {
//       expect(userBLoC.user, null);
//       when(mockDio.get(path)).thenThrow(DioError(
//         requestOptions: RequestOptions(path: path),
//         response: Response(
//           requestOptions: RequestOptions(path: path),
//           statusCode: HttpStatus.notFound,
//           data: <String, dynamic>{
//             'errorName': 'Piix Error Resource not found',
//             'errorMessage': 'There was an error finding the user information',
//             'errorMessages': '[]'
//           },
//         ),
//         type: DioErrorType.badResponse,
//       ));
//       await userBLoC.getUserByUsernameCredential(
//         usernameCredential: usernameCredential,
//         isPhoneNumber: authMethod.isPhoneNumber,
//       );
//       expect(userBLoC.user, null);
//       expect(userBLoC.userActionState, UserActionState.notFound);
//     });

//     test(
//         'when the service http code response is 400, '
//         'the UserActionState is error', () async {
//       expect(userBLoC.user, null);
//       when(mockDio.get(path)).thenThrow(DioError(
//         requestOptions: RequestOptions(path: path),
//         response: Response(
//           requestOptions: RequestOptions(path: path),
//           statusCode: HttpStatus.badRequest,
//           data: <String, dynamic>{
//             'errorName': 'Piix Error Bad Request',
//             'errorMessage': "The server can't send a response",
//             'errorMessages': '[]'
//           },
//         ),
//         type: DioErrorType.badResponse,
//       ));
//       await userBLoC.getUserByUsernameCredential(
//         usernameCredential: usernameCredential,
//         isPhoneNumber: authMethod.isPhoneNumber,
//       );
//       expect(userBLoC.user, null);
//       expect(userBLoC.userActionState, UserActionState.error);
//     });
//   });

//   group('get user by phone username credential', () {
//     setUpAll(() {
//       usernameCredential = '5555555555';
//       credentialModel =
//           UserCredentialModel(usernameCredential: usernameCredential);
//       path =
//           '${appConfig.backendEndpoint}/users/phone?phone=${credentialModel.usernameCredential}';
//       authMethod = AuthMethod.phoneSignIn;
//     });

//     setUp(() {
//       userBLoC.userActionState = UserActionState.idle;
//       userBLoC.user = null;
//     });

//     test(
//         'when the service http code response is 200 and includes data '
//         'that is a valid UserAppModel, the UserActionState is retrieved',
//         () async {
//       expect(userBLoC.user, null);
//       when(mockDio.get(path)).thenAnswer((_) async => Response(
//             requestOptions: RequestOptions(path: path),
//             statusCode: HttpStatus.ok,
//             data: fakeUser,
//           ));
//       await userBLoC.getUserByUsernameCredential(
//         usernameCredential: usernameCredential,
//         isPhoneNumber: authMethod.isPhoneNumber,
//       );
//       expect(userBLoC.user!.displayNames, fakeUser['names']);
//       expect(userBLoC.userActionState, UserActionState.retrieved);
//     });

//     test(
//         'when the service http code response is 200 but does not include data '
//         'that is a valid UserAppModel, the UserActionState is error', () async {
//       expect(userBLoC.user, null);
//       when(mockDio.get(path)).thenAnswer((_) async => Response(
//             requestOptions: RequestOptions(path: path),
//             statusCode: HttpStatus.ok,
//             data: null,
//           ));
//       await userBLoC.getUserByUsernameCredential(
//         usernameCredential: usernameCredential,
//         isPhoneNumber: authMethod.isPhoneNumber,
//       );
//       expect(userBLoC.user, null);
//       expect(userBLoC.userActionState, UserActionState.error);
//     });

//     test(
//         'when the service http code response is 404, '
//         'the UserActionState is notFound', () async {
//       expect(userBLoC.user, null);
//       when(mockDio.get(path)).thenThrow(DioError(
//         requestOptions: RequestOptions(path: path),
//         response: Response(
//           requestOptions: RequestOptions(path: path),
//           statusCode: HttpStatus.notFound,
//           data: <String, dynamic>{
//             'errorName': 'Piix Error Resource not found',
//             'errorMessage': 'There was an error finding the user information',
//             'errorMessages': '[]'
//           },
//         ),
//         type: DioErrorType.badResponse,
//       ));
//       await userBLoC.getUserByUsernameCredential(
//         usernameCredential: usernameCredential,
//         isPhoneNumber: authMethod.isPhoneNumber,
//       );
//       expect(userBLoC.user, null);
//       expect(userBLoC.userActionState, UserActionState.notFound);
//     });

//     test(
//         'when the service http code response is 400, '
//         'the UserActionState is error', () async {
//       expect(userBLoC.user, null);
//       when(mockDio.get(path)).thenThrow(DioError(
//         requestOptions: RequestOptions(path: path),
//         response: Response(
//           requestOptions: RequestOptions(path: path),
//           statusCode: HttpStatus.badRequest,
//           data: <String, dynamic>{
//             'errorName': 'Piix Error Bad Request',
//             'errorMessage': "The server can't send a response",
//             'errorMessages': '[]'
//           },
//         ),
//         type: DioErrorType.badResponse,
//       ));
//       await userBLoC.getUserByUsernameCredential(
//         usernameCredential: usernameCredential,
//         isPhoneNumber: authMethod.isPhoneNumber,
//       );
//       expect(userBLoC.user, null);
//       expect(userBLoC.userActionState, UserActionState.error);
//     });
//   });

//   group('get user by username credential exceptions', () {
//     setUp(() {
//       userBLoC.userActionState = UserActionState.idle;
//       userBLoC.user = null;
//     });

//     test(
//         'when the app throws a DioErrorType ConnectionTimeout or other'
//         ' getting a user by email, the UserActionState is error', () async {
//       usernameCredential = 'mich.bubbla@g.com';
//       credentialModel =
//           UserCredentialModel(usernameCredential: usernameCredential);
//       path =
//           '${appConfig.backendEndpoint}/users/email?email=${credentialModel.usernameCredential}';
//       authMethod = AuthMethod.emailSignIn;
//       expect(userBLoC.user, null);
//       when(mockDio.get(path)).thenThrow(DioError(
//         requestOptions: RequestOptions(path: path),
//         type: DioErrorType.connectionTimeout,
//       ));
//       await userBLoC.getUserByUsernameCredential(
//         usernameCredential: usernameCredential,
//         isPhoneNumber: authMethod.isPhoneNumber,
//       );
//       expect(userBLoC.user, null);
//       expect(userBLoC.userActionState, UserActionState.error);
//     });

//     test(
//         'when the app throws a DioErrorType ConnectionTimeout or other'
//         ' getting a user by phone, the UserActionState is error', () async {
//       usernameCredential = '5555555555';
//       credentialModel =
//           UserCredentialModel(usernameCredential: usernameCredential);
//       path =
//           '${appConfig.backendEndpoint}/users/phone?phone=${credentialModel.usernameCredential}';
//       authMethod = AuthMethod.phoneSignIn;
//       expect(userBLoC.user, null);
//       when(mockDio.get(path)).thenThrow(DioError(
//         requestOptions: RequestOptions(path: path),
//         type: DioErrorType.connectionTimeout,
//       ));
//       await userBLoC.getUserByUsernameCredential(
//         usernameCredential: usernameCredential,
//         isPhoneNumber: authMethod.isPhoneNumber,
//       );
//       expect(userBLoC.user, null);
//       expect(userBLoC.userActionState, UserActionState.error);
//     });
//   });

//   group('get user levels and plans', () {
//     setUpAll(() async {
//       usernameCredential = 'mich.bubbla@g.com';
//       credentialModel =
//           UserCredentialModel(usernameCredential: usernameCredential);
//       path =
//           '${appConfig.backendEndpoint}/users/email?email=${credentialModel.usernameCredential}';
//       authMethod = AuthMethod.emailSignIn;
//       when(mockDio.get(path)).thenAnswer(
//         (_) async => Response(
//           requestOptions: RequestOptions(path: path),
//           statusCode: HttpStatus.ok,
//           data: fakeUser,
//         ),
//       );
//       final fakeMemberships =
//           (fakeUserLevelsAndPlans['memberships'] as List<Map<String, dynamic>>)
//               .map((membership) => MembershipModel.fromJson(membership))
//               .toList();

//       path = '${appConfig.backendEndpoint}/files/get/fromPath';
//       for (final membership in fakeMemberships) {
//         if (membership.usersMembershipLevel.cardImage != null) {
//           final filePath = membership.usersMembershipLevel.cardImage!;
//           final propertyName = '${membership.membershipId}/cardImage';
//           final requestFileModel = RequestFileModel(
//             userId: fakeUser['userId'],
//             filePath: filePath,
//             propertyName: propertyName,
//           );
//           final fakeFile =
//               getIt<FileSystemRepository>().fakeJsonFile(propertyName);
//           when(mockDio.post(path, data: requestFileModel.toJson())).thenAnswer(
//             (_) async => Response(
//               requestOptions: RequestOptions(
//                 path: path,
//               ),
//               statusCode: HttpStatus.ok,
//               data: fakeFile,
//             ),
//           );
//         }
//       }
//     });

//     setUp(() {
//       userBLoC.userActionState = UserActionState.idle;
//       userBLoC.user = null;
//     });

//     test(
//         'when the service http code response is 200 and includes data '
//         'that is a valid list of MembershipModel, the UserActionState is retrieved',
//         () async {
//       await userBLoC.getUserByUsernameCredential(
//         usernameCredential: usernameCredential,
//         isPhoneNumber: authMethod.isPhoneNumber,
//       );
//       expect(userBLoC.user, isNotNull);
//       expect(userBLoC.user!.memberships, isNotEmpty);
//       path = '${appConfig.backendEndpoint}/users/getPlanAndLevelForMemberships';
//       when(mockDio.get(path)).thenAnswer(
//         (_) async => Response(
//           requestOptions: RequestOptions(
//             path: path,
//           ),
//           statusCode: HttpStatus.ok,
//           data: fakeUserLevelsAndPlans,
//         ),
//       );
//       await userBLoC.getUserLevelsAndPlans();
//       expect(userBLoC.memberships.first.usersMembershipLevel, isNotNull);
//       expect(
//           userBLoC.memberships.first.usersMembershipLevel.cardImage,
//           fakeUserLevelsAndPlans['memberships'][0]['usersMembershipLevel']
//               ['membershipLevelImage']);
//       expect(userBLoC.memberships.first.usersMembershipPlans, isNotNull);
//       expect(
//           userBLoC
//               .memberships.first.usersMembershipPlans.first.kinship.kinshipId,
//           fakeUserLevelsAndPlans['memberships'][0]['usersMembershipPlans'][0]
//               ['kinship']['kinshipId']);
//       expect(userBLoC.userActionState, UserActionState.retrieved);
//     });

//     test(
//         'when the service http code response is 200 and does not include data '
//         'that is a valid list of MembershipModel, the UserActionState is error',
//         () async {
//       await userBLoC.getUserByUsernameCredential(
//         usernameCredential: usernameCredential,
//         isPhoneNumber: authMethod.isPhoneNumber,
//       );
//       expect(userBLoC.user, isNotNull);
//       expect(userBLoC.user!.memberships, isNotEmpty);
//       path = '${appConfig.backendEndpoint}/users/getPlanAndLevelForMemberships';
//       when(mockDio.get(path)).thenAnswer(
//         (_) async => Response(
//           requestOptions: RequestOptions(
//             path: path,
//           ),
//           statusCode: HttpStatus.ok,
//           data: null,
//         ),
//       );
//       await userBLoC.getUserLevelsAndPlans();
//       expect(userBLoC.memberships.first.usersMembershipLevel, isNotNull);
//       final membershipLevelImage = fakeUserLevelsAndPlans['memberships'][0]
//           ['usersMembershipLevel']['membershipLevelImage'];
//       expect(
//           userBLoC.memberships.first.usersMembershipLevel.cardImage ==
//               membershipLevelImage,
//           false);
//       expect(userBLoC.memberships.first.usersMembershipPlans, isNotNull);
//       final kinshipId = fakeUserLevelsAndPlans['memberships'][0]
//           ['usersMembershipPlans'][0]['kinship']['kinshipId'];
//       expect(
//           userBLoC.memberships.first.usersMembershipPlans.first.kinship
//                   .kinshipId ==
//               kinshipId,
//           true);
//       expect(userBLoC.userActionState, UserActionState.error);
//     });

//     test(
//         'when the service http code response is 404, the UserActionState is notFound',
//         () async {
//       await userBLoC.getUserByUsernameCredential(
//         usernameCredential: usernameCredential,
//         isPhoneNumber: authMethod.isPhoneNumber,
//       );
//       expect(userBLoC.user, isNotNull);
//       expect(userBLoC.user!.memberships, isNotEmpty);
//       path = '${appConfig.backendEndpoint}/users/getPlanAndLevelForMemberships';
//       when(mockDio.get(path)).thenThrow(
//         DioError(
//           requestOptions: RequestOptions(
//             path: path,
//           ),
//           response: Response(
//             requestOptions: RequestOptions(
//               path: path,
//             ),
//             data: <String, dynamic>{
//               'errorName': 'Piix Error Not Found',
//               'errorMessage': 'The user was not found',
//               'errorMessages': '[]'
//             },
//             statusCode: HttpStatus.notFound,
//           ),
//           type: DioErrorType.badResponse,
//         ),
//       );
//       await userBLoC.getUserLevelsAndPlans();
//       expect(userBLoC.memberships.first.usersMembershipLevel, isNotNull);
//       final membershipLevelImage = fakeUserLevelsAndPlans['memberships'][0]
//           ['usersMembershipLevel']['membershipLevelImage'];
//       expect(
//           userBLoC.memberships.first.usersMembershipLevel.cardImage ==
//               membershipLevelImage,
//           false);
//       expect(userBLoC.memberships.first.usersMembershipPlans, isNotNull);
//       final kinshipId = fakeUserLevelsAndPlans['memberships'][0]
//           ['usersMembershipPlans'][0]['kinship']['kinshipId'];
//       expect(
//         userBLoC.memberships.first.usersMembershipPlans.first.kinship
//                 .kinshipId ==
//             kinshipId,
//         true,
//       );
//       expect(
//         userBLoC.userActionState,
//         UserActionState.notFound,
//       );
//     });
//   });

//   group(
//     'get user levels and plans exceptions',
//     () {
//       setUpAll(() async {
//         usernameCredential = 'mich.bubbla@g.com';
//         credentialModel =
//             UserCredentialModel(usernameCredential: usernameCredential);
//         path =
//             '${appConfig.backendEndpoint}/users/email?email=${credentialModel.usernameCredential}';
//         authMethod = AuthMethod.emailSignIn;
//         when(mockDio.get(path)).thenAnswer(
//           (_) async => Response(
//             requestOptions: RequestOptions(path: path),
//             statusCode: HttpStatus.ok,
//             data: fakeUser,
//           ),
//         );
//         final fakeMemberships = (fakeUserLevelsAndPlans['memberships']
//                 as List<Map<String, dynamic>>)
//             .map((membership) => MembershipModel.fromJson(membership))
//             .toList();

//         path = '${appConfig.backendEndpoint}/files/get/fromPath';
//         for (final membership in fakeMemberships) {
//           if (membership.usersMembershipLevel.cardImage != null) {
//             final filePath = membership.usersMembershipLevel.cardImage!;
//             final propertyName = '${membership.membershipId}/cardImage';
//             final requestFileModel = RequestFileModel(
//               userId: fakeUser['userId'],
//               filePath: filePath,
//               propertyName: propertyName,
//             );
//             final fakeFile =
//                 getIt<FileSystemRepository>().fakeJsonFile(propertyName);
//             when(mockDio.post(path, data: requestFileModel.toJson()))
//                 .thenAnswer(
//               (_) async => Response(
//                 requestOptions: RequestOptions(
//                   path: path,
//                 ),
//                 statusCode: HttpStatus.ok,
//                 data: fakeFile,
//               ),
//             );
//           }
//         }
//       });

//       setUp(() {
//         userBLoC.userActionState = UserActionState.idle;
//         userBLoC.user = null;
//       });

//       test(
//         'when the service http code response is 400+, the UserActionState is error',
//         () async {
//           await userBLoC.getUserByUsernameCredential(
//             usernameCredential: usernameCredential,
//             isPhoneNumber: authMethod.isPhoneNumber,
//           );
//           expect(userBLoC.user, isNotNull);
//           expect(userBLoC.user!.memberships, isNotEmpty);
//           path =
//               '${appConfig.backendEndpoint}/users/getPlanAndLevelForMemberships';
//           when(mockDio.get(path)).thenThrow(
//             DioError(
//               requestOptions: RequestOptions(
//                 path: path,
//               ),
//               response: Response(
//                 requestOptions: RequestOptions(
//                   path: path,
//                 ),
//                 data: <String, dynamic>{
//                   'errorName': 'Piix Error Internal Server Error',
//                   'errorMessage': 'The server could not respond',
//                   'errorMessages': '[]'
//                 },
//                 statusCode: HttpStatus.internalServerError,
//               ),
//               type: DioErrorType.badResponse,
//             ),
//           );
//           await userBLoC.getUserLevelsAndPlans();
//           expect(userBLoC.memberships.first.usersMembershipLevel, isNotNull);
//           final membershipLevelImage = fakeUserLevelsAndPlans['memberships'][0]
//               ['usersMembershipLevel']['membershipLevelImage'];
//           expect(
//               userBLoC.memberships.first.usersMembershipLevel.cardImage ==
//                   membershipLevelImage,
//               false);
//           expect(userBLoC.memberships.first.usersMembershipPlans, isNotNull);
//           final kinshipId = fakeUserLevelsAndPlans['memberships'][0]
//               ['usersMembershipPlans'][0]['kinship']['kinshipId'];
//           expect(
//             userBLoC.memberships.first.usersMembershipPlans.first.kinship
//                     .kinshipId ==
//                 kinshipId,
//             true,
//           );
//           expect(
//             userBLoC.userActionState,
//             UserActionState.error,
//           );
//         },
//       );

//       test(
//         'when the app throws a DioErrorType connection timeout or other, the UserActionState is error',
//         () async {
//           await userBLoC.getUserByUsernameCredential(
//             usernameCredential: usernameCredential,
//             isPhoneNumber: authMethod.isPhoneNumber,
//           );
//           expect(userBLoC.user, isNotNull);
//           expect(userBLoC.user!.memberships, isNotEmpty);
//           path =
//               '${appConfig.backendEndpoint}/users/getPlanAndLevelForMemberships';
//           when(mockDio.get(path)).thenThrow(
//             DioError(
//               requestOptions: RequestOptions(
//                 path: path,
//               ),
//               type: DioErrorType.connectionTimeout,
//             ),
//           );
//           await userBLoC.getUserLevelsAndPlans();
//           expect(userBLoC.memberships.first.usersMembershipLevel, isNotNull);
//           final membershipLevelImage = fakeUserLevelsAndPlans['memberships'][0]
//               ['usersMembershipLevel']['membershipLevelImage'];
//           expect(
//               userBLoC.memberships.first.usersMembershipLevel.cardImage ==
//                   membershipLevelImage,
//               false);
//           expect(userBLoC.memberships.first.usersMembershipPlans, isNotNull);
//           final kinshipId = fakeUserLevelsAndPlans['memberships'][0]
//               ['usersMembershipPlans'][0]['kinship']['kinshipId'];
//           expect(
//             userBLoC.memberships.first.usersMembershipPlans.first.kinship
//                     .kinshipId ==
//                 kinshipId,
//             true,
//           );
//           expect(
//             userBLoC.userActionState,
//             UserActionState.error,
//           );
//         },
//       );
//     },
//   );

//   group('update user email', () {
//     setUpAll(() async {
//       currentCredential = 'current@yopmail.com';
//       newCredential = 'next@yopmail.com';
//       userId = 'PIIXINT-00';
//       updateEmailRequestModel = UpdateEmailRequestModel(
//         userId: userId,
//         newEmail: newCredential,
//         currentEmail: currentCredential,
//       );
//       path = PiixAppEndpoints.updateUserEmailEndpoint;
//     });

//     setUp(() {
//       userBLoC.userActionState = UserActionState.idle;
//       userBLoC.user = null;
//     });

//     test(
//         'when the service http code response is 200 , '
//         'the UserActionState is updated', () async {
//       when(mockDio.put(path, data: updateEmailRequestModel.toJson()))
//           .thenAnswer(
//         (_) async => Response(
//           requestOptions: RequestOptions(path: path),
//           statusCode: HttpStatus.ok,
//         ),
//       );
//       await userBLoC.updateUserEmail(
//         userId: userId,
//         currentEmail: currentCredential,
//         newEmail: newCredential,
//       );
//       expect(userBLoC.userActionState, UserActionState.updated);
//     });

//     test(
//         'when the service http code response is 404 , '
//         'the UserActionState is notFound', () async {
//       when(mockDio.put(path, data: updateEmailRequestModel.toJson()))
//           .thenThrow(DioError(
//         requestOptions: RequestOptions(path: path),
//         response: Response(
//           requestOptions: RequestOptions(path: path),
//           statusCode: HttpStatus.notFound,
//           data: <String, dynamic>{
//             'errorName': 'Piix Error Not Found',
//             'errorMessage': 'The user was not found',
//             'errorMessages': '[]'
//           },
//         ),
//         type: DioErrorType.badResponse,
//       ));
//       await userBLoC.updateUserEmail(
//         userId: userId,
//         currentEmail: currentCredential,
//         newEmail: newCredential,
//       );
//       expect(userBLoC.userActionState, UserActionState.notFound);
//     });

//     test(
//         'when the service http code response is 409 , '
//         'the UserActionState is alreadyExists', () async {
//       when(mockDio.put(path, data: updateEmailRequestModel.toJson()))
//           .thenThrow(DioError(
//         requestOptions: RequestOptions(path: path),
//         response: Response(
//           requestOptions: RequestOptions(path: path),
//           statusCode: HttpStatus.conflict,
//           data: <String, dynamic>{
//             'errorName': 'Piix Error Not Found',
//             'errorMessage': 'The user was not found',
//             'errorMessages': '[]'
//           },
//         ),
//         type: DioErrorType.badResponse,
//       ));
//       await userBLoC.updateUserEmail(
//         userId: userId,
//         currentEmail: currentCredential,
//         newEmail: newCredential,
//       );
//       expect(userBLoC.userActionState, UserActionState.alreadyExists);
//     });
//   });

//   group('update user email exception', () {
//     setUpAll(() async {
//       currentCredential = 'current@yopmail.com';
//       newCredential = 'next@yopmail.com';
//       userId = 'PIIXINT-00';
//       updateEmailRequestModel = UpdateEmailRequestModel(
//         userId: userId,
//         newEmail: newCredential,
//         currentEmail: currentCredential,
//       );
//       path = PiixAppEndpoints.updateUserEmailEndpoint;
//     });

//     setUp(() {
//       userBLoC.userActionState = UserActionState.idle;
//       userBLoC.user = null;
//     });

//     test(
//         'when the service http code response is 400+ , '
//         'the UserActionState is errorUpdating', () async {
//       when(mockDio.put(path, data: updateEmailRequestModel.toJson()))
//           .thenThrow(DioError(
//         requestOptions: RequestOptions(path: path),
//         response: Response(
//           requestOptions: RequestOptions(path: path),
//           statusCode: HttpStatus.internalServerError,
//           data: <String, dynamic>{
//             'errorName': 'Piix Error Internal Server Error',
//             'errorMessage': 'The server could not respond',
//             'errorMessages': '[]'
//           },
//         ),
//         type: DioErrorType.badResponse,
//       ));
//       await userBLoC.updateUserEmail(
//         userId: userId,
//         currentEmail: currentCredential,
//         newEmail: newCredential,
//       );
//       expect(userBLoC.userActionState, UserActionState.errorUpdating);
//     });

//     test(
//         'when the app throw a DioErrorType connection time out or other , '
//         'the UserActionState is errorUpdating', () async {
//       when(mockDio.put(path, data: updateEmailRequestModel.toJson()))
//           .thenThrow(DioError(
//         requestOptions: RequestOptions(path: path),
//         type: DioErrorType.connectionTimeout,
//       ));
//       await userBLoC.updateUserEmail(
//         userId: userId,
//         currentEmail: currentCredential,
//         newEmail: newCredential,
//       );
//       expect(userBLoC.userActionState, UserActionState.errorUpdating);
//     });
//   });

//   group('update user phoneNumber', () {
//     setUpAll(() async {
//       usernameCredential = 'mich.bubbla@g.com';
//       credentialModel =
//           UserCredentialModel(usernameCredential: usernameCredential);
//       path =
//           '${appConfig.backendEndpoint}/users/email?email=${credentialModel.usernameCredential}';
//       authMethod = AuthMethod.emailSignIn;
//       when(mockDio.get(path)).thenAnswer(
//         (_) async => Response(
//           requestOptions: RequestOptions(path: path),
//           statusCode: HttpStatus.ok,
//           data: fakeUser,
//         ),
//       );
//       currentCredential =
//           '${fakeUser['internationalPhoneCode']}${fakeUser['phoneNumber']}';
//       newCredential = '44444444';
//       userId = 'PIIXINT-00';
//       updatePhoneNumberRequestModel = UpdatePhoneNumberRequestModel(
//         userId: userId,
//         newPhoneNumber: '${fakeUser['internationalPhoneCode']}$newCredential',
//         currentPhoneNumber: currentCredential,
//       );
//       path = PiixAppEndpoints.updateUserPhoneNumberEndpoint;
//     });

//     setUp(() {
//       userBLoC.userActionState = UserActionState.idle;
//       userBLoC.user = null;
//     });

//     test(
//         'when the service http code response is 200 , '
//         'the UserActionState is updated', () async {
//       expect(userBLoC.user, isNull);
//       await userBLoC.getUserByUsernameCredential(
//         usernameCredential: usernameCredential,
//         isPhoneNumber: authMethod.isPhoneNumber,
//       );
//       expect(userBLoC.user, isNotNull);
//       when(mockDio.put(path, data: updatePhoneNumberRequestModel.toJson()))
//           .thenAnswer(
//         (_) async => Response(
//           requestOptions: RequestOptions(path: path),
//           statusCode: HttpStatus.ok,
//         ),
//       );
//       await userBLoC.updateUserPhoneNumber(
//         userId: userId,
//         newPhoneNumber: newCredential,
//       );
//       expect(userBLoC.userActionState, UserActionState.updated);
//     });

//     test(
//         'when the service http code response is 404 , '
//         'the UserActionState is notFound', () async {
//       expect(userBLoC.user, isNull);
//       await userBLoC.getUserByUsernameCredential(
//         usernameCredential: usernameCredential,
//         isPhoneNumber: authMethod.isPhoneNumber,
//       );
//       expect(userBLoC.user, isNotNull);
//       when(mockDio.put(path, data: updatePhoneNumberRequestModel.toJson()))
//           .thenThrow(DioError(
//         requestOptions: RequestOptions(path: path),
//         response: Response(
//           requestOptions: RequestOptions(path: path),
//           statusCode: HttpStatus.notFound,
//           data: <String, dynamic>{
//             'errorName': 'Piix Error Not Found',
//             'errorMessage': 'The user was not found',
//             'errorMessages': '[]'
//           },
//         ),
//         type: DioErrorType.badResponse,
//       ));
//       await userBLoC.updateUserPhoneNumber(
//         userId: userId,
//         newPhoneNumber: newCredential,
//       );
//       expect(userBLoC.userActionState, UserActionState.notFound);
//     });

//     test(
//         'when the service http code response is 409 , '
//         'the UserActionState is alreadyExists', () async {
//       expect(userBLoC.user, isNull);
//       await userBLoC.getUserByUsernameCredential(
//         usernameCredential: usernameCredential,
//         isPhoneNumber: authMethod.isPhoneNumber,
//       );
//       expect(userBLoC.user, isNotNull);
//       when(mockDio.put(path, data: updatePhoneNumberRequestModel.toJson()))
//           .thenThrow(DioError(
//         requestOptions: RequestOptions(path: path),
//         response: Response(
//           requestOptions: RequestOptions(path: path),
//           statusCode: HttpStatus.conflict,
//           data: <String, dynamic>{
//             'errorName': 'Piix Error Not Found',
//             'errorMessage': 'The user was not found',
//             'errorMessages': '[]'
//           },
//         ),
//         type: DioErrorType.badResponse,
//       ));
//       await userBLoC.updateUserPhoneNumber(
//         userId: userId,
//         newPhoneNumber: newCredential,
//       );
//       expect(userBLoC.userActionState, UserActionState.alreadyExists);
//     });
//   });

//   group('update user phoneNumber exceptions', () {
//     setUpAll(() async {
//       usernameCredential = 'mich.bubbla@g.com';
//       credentialModel =
//           UserCredentialModel(usernameCredential: usernameCredential);
//       path =
//           '${appConfig.backendEndpoint}/users/email?email=${credentialModel.usernameCredential}';
//       authMethod = AuthMethod.emailSignIn;
//       when(mockDio.get(path)).thenAnswer(
//         (_) async => Response(
//           requestOptions: RequestOptions(path: path),
//           statusCode: HttpStatus.ok,
//           data: fakeUser,
//         ),
//       );
//       currentCredential =
//           '${fakeUser['internationalPhoneCode']}${fakeUser['phoneNumber']}';
//       newCredential = '44444444';
//       userId = 'PIIXINT-00';
//       updatePhoneNumberRequestModel = UpdatePhoneNumberRequestModel(
//         userId: userId,
//         newPhoneNumber: '${fakeUser['internationalPhoneCode']}$newCredential',
//         currentPhoneNumber: currentCredential,
//       );
//       path = PiixAppEndpoints.updateUserPhoneNumberEndpoint;
//     });

//     setUp(() {
//       userBLoC.userActionState = UserActionState.idle;
//       userBLoC.user = null;
//     });

//     test(
//         'when the service http code response is 400+ , '
//         'the UserActionState is errorUpdating', () async {
//       expect(userBLoC.user, isNull);
//       await userBLoC.getUserByUsernameCredential(
//         usernameCredential: usernameCredential,
//         isPhoneNumber: authMethod.isPhoneNumber,
//       );
//       expect(userBLoC.user, isNotNull);
//       when(mockDio.put(path, data: updatePhoneNumberRequestModel.toJson()))
//           .thenThrow(DioError(
//         requestOptions: RequestOptions(path: path),
//         response: Response(
//           requestOptions: RequestOptions(path: path),
//           statusCode: HttpStatus.internalServerError,
//           data: <String, dynamic>{
//             'errorName': 'Piix Error Internal Server Error',
//             'errorMessage': 'The server could not respond',
//             'errorMessages': '[]'
//           },
//         ),
//         type: DioErrorType.badResponse,
//       ));
//       await userBLoC.updateUserPhoneNumber(
//         userId: userId,
//         newPhoneNumber: newCredential,
//       );
//       expect(userBLoC.userActionState, UserActionState.errorUpdating);
//     });

//     test(
//         'when the app throw a DioErrorType connection time out or other , '
//         'the UserActionState is errorUpdating', () async {
//       expect(userBLoC.user, isNull);
//       await userBLoC.getUserByUsernameCredential(
//         usernameCredential: usernameCredential,
//         isPhoneNumber: authMethod.isPhoneNumber,
//       );
//       expect(userBLoC.user, isNotNull);
//       when(mockDio.put(path, data: updatePhoneNumberRequestModel.toJson()))
//           .thenThrow(DioError(
//         requestOptions: RequestOptions(path: path),
//         type: DioErrorType.connectionTimeout,
//       ));
//       await userBLoC.updateUserPhoneNumber(
//         userId: userId,
//         newPhoneNumber: newCredential,
//       );
//       expect(userBLoC.userActionState, UserActionState.errorUpdating);
//     });

//     test(
//         'when the service http code response is 409 , '
//         'the UserActionState is alreadyExists', () async {
//       expect(userBLoC.user, isNull);
//       await userBLoC.getUserByUsernameCredential(
//         usernameCredential: usernameCredential,
//         isPhoneNumber: authMethod.isPhoneNumber,
//       );
//       expect(userBLoC.user, isNotNull);
//       when(mockDio.put(path, data: updatePhoneNumberRequestModel.toJson()))
//           .thenThrow(DioError(
//         requestOptions: RequestOptions(path: path),
//         response: Response(
//           requestOptions: RequestOptions(path: path),
//           statusCode: HttpStatus.conflict,
//           data: <String, dynamic>{
//             'errorName': 'Piix Error Not Found',
//             'errorMessage': 'The user was not found',
//             'errorMessages': '[]'
//           },
//         ),
//         type: DioErrorType.badResponse,
//       ));
//       await userBLoC.updateUserPhoneNumber(
//         userId: userId,
//         newPhoneNumber: newCredential,
//       );
//       expect(userBLoC.userActionState, UserActionState.alreadyExists);
//     });
//   });
// }
