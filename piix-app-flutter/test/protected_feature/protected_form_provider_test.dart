// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:piix_mobile/app_config.dart';
// import 'package:piix_mobile/general_app_feature/api/piix_api.dart';
// import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
// import 'package:piix_mobile/protected_feature_deprecated/data/repository/protected_form_repository.dart';
// import 'package:piix_mobile/protected_feature_deprecated/data/repository/protected_form_repository_test.dart';
// import 'package:piix_mobile/protected_feature_deprecated/domain/bloc/protected_form_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../general_app_feature/api/mock_dio.mocks.dart';
// import '../general_app_feature/api/test_endpoints.dart';

// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences.setMockInitialValues({});
//   setupGetIt();
//   setEndpoints();
//   final appConfig = AppConfig.instance;
//   final mockDio = MockDio();
//   PiixApi.setDio(mockDio);
//   final protectedFormProvider = getIt<ProtectedFormNotifier>();
//   final protectedFormRepository = getIt<ProtectedFormRepository>();
//   final fakeProtectedRegisterForm =
//       protectedFormRepository.fakeProtectedRegisterForm();
//   var path = '';

//   group('user retrieves protected register form', () {
//     setUpAll(() {
//       path =
//           '${appConfig.backendEndpoint}/mainUserForms?mainUserInfoFormId=basicProtectedForm';
//     });

//     setUp(() {
//       protectedFormProvider.clearProvider();
//     });

//     test(
//       'user retrives the protected register form successfuly',
//       () async {
//         expect(
//             protectedFormProvider.protectedFormState, ProtectedFormState.idle);
//         when(mockDio.get(path)).thenAnswer(
//           (_) async => Response(
//             requestOptions: RequestOptions(
//               path: path,
//             ),
//             statusCode: HttpStatus.ok,
//             data: fakeProtectedRegisterForm,
//           ),
//         );
//         await protectedFormProvider.getProtectedRegisterForm(
//           useFirebase: false,
//           membershipId: '',
//         );
//         expect(protectedFormProvider.protectedFormState,
//             ProtectedFormState.retrieved);
//         expect(protectedFormProvider.protectedRegisterForm, isNotNull);
//         expect(protectedFormProvider.protectedRegisterForm!.formId,
//             fakeProtectedRegisterForm['formId']);
//       },
//     );

//     test(
//       'user retrieves no data when requesting the protected register form',
//       () async {
//         expect(
//             protectedFormProvider.protectedFormState, ProtectedFormState.idle);
//         when(mockDio.get(path)).thenAnswer(
//           (_) async => Response(
//             requestOptions: RequestOptions(
//               path: path,
//             ),
//             statusCode: HttpStatus.ok,
//             data: null,
//           ),
//         );
//         await protectedFormProvider.getProtectedRegisterForm(
//           useFirebase: false,
//           membershipId: '',
//         );
//         expect(protectedFormProvider.protectedFormState,
//             ProtectedFormState.retrievedError);
//         expect(protectedFormProvider.protectedRegisterForm, isNull);
//       },
//     );
//   });

//   group('user can\'t retrieve protected register form', () {
//     setUpAll(() {
//       path =
//           '${appConfig.backendEndpoint}/mainUserForms?mainUserInfoFormId=basicProtectedForm';
//     });

//     setUp(() {
//       protectedFormProvider.clearProvider();
//     });

//     test(
//       'the service responds with a 404',
//       () async {
//         expect(
//             protectedFormProvider.protectedFormState, ProtectedFormState.idle);
//         when(mockDio.get(path)).thenThrow(
//           DioError(
//             requestOptions: RequestOptions(
//               path: path,
//             ),
//             response: Response(
//               requestOptions: RequestOptions(
//                 path: path,
//               ),
//               statusCode: HttpStatus.notFound,
//               data: <String, dynamic>{
//                 'errorName': 'Piix Error Resource not Found',
//                 'errorMessage': 'There was an error with the '
//                     'protected register form you wanted to retrieve',
//                 'errorMessages': '["Form Id is not found"]',
//               },
//             ),
//             type: DioErrorType.badResponse,
//           ),
//         );

//         await protectedFormProvider.getProtectedRegisterForm(
//           useFirebase: false,
//           membershipId: '',
//         );
//         expect(protectedFormProvider.protectedFormState,
//             ProtectedFormState.retrievedError);
//         expect(protectedFormProvider.protectedRegisterForm, isNull);
//       },
//     );

//     test(
//       'the app throws a DioError connection timeout or other',
//       () async {
//         expect(
//             protectedFormProvider.protectedFormState, ProtectedFormState.idle);
//         when(mockDio.get(path)).thenThrow(
//           DioError(
//             requestOptions: RequestOptions(
//               path: path,
//             ),
//             type: DioErrorType.connectionTimeout,
//           ),
//         );

//         await protectedFormProvider.getProtectedRegisterForm(
//             useFirebase: false, membershipId: '');
//         expect(protectedFormProvider.protectedFormState,
//             ProtectedFormState.retrievedError);
//         expect(protectedFormProvider.protectedRegisterForm, isNull);
//       },
//     );
//   });
// }
