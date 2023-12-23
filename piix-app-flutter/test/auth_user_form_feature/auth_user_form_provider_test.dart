// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:piix_mobile/app_config.dart';
// import 'package:piix_mobile/auth_user_feature_deprecated/domain/model/user_app_model.dart';
// import 'package:piix_mobile/auth_user_feature_deprecated/utils/auth_user_copies.dart';
// import 'package:piix_mobile/auth_user_form_feature_deprecated/data/repository/auth_user_form_repository.dart';
// import 'package:piix_mobile/auth_user_form_feature_deprecated/data/repository/auth_user_form_repository_test.dart';
// import 'package:piix_mobile/auth_user_form_feature_deprecated/domain/model/auth_user_form_model.dart';
// import 'package:piix_mobile/auth_user_form_feature_deprecated/domain/provider/auth_user_form_provider.dart';
// import 'package:piix_mobile/general_app_feature/api/piix_api.dart';
// import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
// import 'package:piix_mobile/input_form_feature_deprecated/domain/bloc/form_field_bloc.dart';
// import 'package:piix_mobile/input_form_feature_deprecated/domain/model/piix_form_model.dart';
// import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/answer_request_item_model.dart';
// import 'package:piix_mobile/auth_user_form_feature_deprecated/domain/model/basic_form_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../general_app_feature/api/mock_dio.mocks.dart';
// import '../general_app_feature/api/test_endpoints.dart';
// import 'form_answers/auth_user_fake_form_responses.dart';

// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences.setMockInitialValues({});
//   setupGetIt();
//   setEndpoints();
//   final appConfig = AppConfig.instance;
//   final mockDio = MockDio();
//   PiixApi.setDio(mockDio);
//   final authUserFormProvider = getIt<AuthUserFormProvider>();
//   final authUserFormRepository = getIt<AuthUserFormRepository>();
//   final formFieldBLoc = getIt<FormFieldBLoC>();
//   final fakePersonalInformationForm =
//       authUserFormRepository.fakePersonalInformationForm();
//   final fakeDocumentationForm = authUserFormRepository.fakeDocumentationForm();
//   const userId = 'ah6jsfhu8374984hj';
//   var mainUserInfoFormId = '';
//   var path = '';
//   late AuthUserFormModel formModel;
//   late List<AnswerRequestItemModel> answers;
//   late List<AnswerRequestItemModel> legalAnswers;
//   late BasicFormAnswerModel answerModel;
//   group('user requests personal information form', () {
//     setUpAll(() {
//       mainUserInfoFormId = 'basicInsuredForm';
//       formModel = AuthUserFormModel(
//         userId: userId,
//         mainUserInfoFormId: mainUserInfoFormId,
//       );
//       path =
//           '${appConfig.catalogEndpoint}/mainUserForms?mainUserInfoFormId=${formModel.mainUserInfoFormId}'
//           '&userId=${formModel.userId}';
//     });

//     setUp(() {
//       authUserFormProvider.clearProvider();
//     });

//     test(
//       'User succesfully requests personal information form',
//       () async {
//         when(mockDio.get(path)).thenAnswer(
//           (_) async => Response(
//             requestOptions: RequestOptions(
//               path: path,
//             ),
//             statusCode: HttpStatus.ok,
//             data: fakePersonalInformationForm,
//           ),
//         );
//         await authUserFormProvider.getPersonalInformationForm(
//           userId: userId,
//           formId: mainUserInfoFormId,
//         );
//         final personalInformationForm = authUserFormProvider.authUserForm;
//         expect(authUserFormProvider.authUserFormState,
//             AuthUserFormState.retrieved);
//         expect(personalInformationForm, isNotNull);
//         expect(personalInformationForm!.formFields, isNotEmpty);
//         expect(personalInformationForm.formId,
//             fakePersonalInformationForm['formId']);
//       },
//     );

//     test('User has an error when requesting the personal information form',
//         () async {
//       when(mockDio.get(path)).thenThrow(
//         DioError(
//           requestOptions: RequestOptions(
//             path: path,
//           ),
//           type: DioErrorType.badResponse,
//           response: Response(
//             requestOptions: RequestOptions(
//               path: path,
//             ),
//             statusCode: HttpStatus.notFound,
//             data: <String, dynamic>{
//               'errorName': 'Piix Error Resource not found',
//               'errorMessage': 'There was an error with the form requested',
//               'errorMessages': '["Form id does not belong to any form"]',
//             },
//           ),
//         ),
//       );
//       await authUserFormProvider.getPersonalInformationForm(
//         userId: userId,
//         formId: mainUserInfoFormId,
//       );
//       final authUserForm = authUserFormProvider.authUserForm;
//       expect(authUserFormProvider.authUserFormState,
//           AuthUserFormState.retrieveError);
//       expect(authUserForm, isNull);
//     });
//   });

//   group('user sends personal information form', () {
//     setUpAll(() {
//       answers =
//           formFieldBLoc.responsesToAnswers(personalInformationFakeFormResponse);

//       mainUserInfoFormId = 'basicInsuredForm';
//       legalAnswers = fakeLegalAnswers;
//       answerModel = BasicFormAnswerModel(
//         userId: userId,
//         mainUserInfoFormId: mainUserInfoFormId,
//         answers: [
//           ...answers,
//           ...legalAnswers,
//         ],
//       );
//       path = '${appConfig.backendEndpoint}/user/mainForms/basicInformation';
//     });

//     setUp(() {
//       authUserFormProvider.clearProvider();
//       formFieldBLoc.piixFormModel =
//           PiixFormModel.fromJson(fakePersonalInformationForm);
//     });

//     test('user successully sends personal information form', () async {
//       when(mockDio.put(path, data: answerModel.toJson())).thenAnswer(
//         (_) async => Response(
//           requestOptions: RequestOptions(
//             path: path,
//           ),
//           statusCode: HttpStatus.created,
//           data: AuthUserFormState.sent,
//         ),
//       );
//       await authUserFormProvider.sendPersonalInformationForm(
//         userId: userId,
//         mainUserInfoFormId: mainUserInfoFormId,
//         answers: answers,
//         legalAnswers: legalAnswers,
//       );
//       expect(authUserFormProvider.authUserFormState, AuthUserFormState.sent);
//     });

//     test('user receives an error of email already used', () async {
//       when(mockDio.put(path, data: answerModel.toJson())).thenThrow(
//         DioError(
//           requestOptions: RequestOptions(
//             path: path,
//           ),
//           type: DioErrorType.badResponse,
//           response: Response(
//             requestOptions: RequestOptions(
//               path: path,
//             ),
//             statusCode: HttpStatus.conflict,
//             data: <String, dynamic>{
//               'errorName': 'Piix Error Conflict Resource',
//               'errorMessage': 'There was an error with the email provided',
//               'errorMessages': ['Email is already in use'],
//               'errorCodes': ['EMAIL_ALREADY_USED']
//             },
//           ),
//         ),
//       );
//       await authUserFormProvider.sendPersonalInformationForm(
//         userId: userId,
//         mainUserInfoFormId: mainUserInfoFormId,
//         answers: answers,
//         legalAnswers: legalAnswers,
//       );
//       expect(authUserFormProvider.authUserFormState,
//           AuthUserFormState.emailAlreadyUsed);
//       final emailFormField = formFieldBLoc.piixFormModel?.formFieldBy('email');
//       expect(emailFormField, isNotNull);
//       expect(
//           emailFormField!.responseErrorText, AuthUserCopies.alreadyUsedEmail);
//     });

//     test('user receives an error of phone already used', () async {
//       when(mockDio.put(path, data: answerModel.toJson())).thenThrow(
//         DioError(
//           requestOptions: RequestOptions(
//             path: path,
//           ),
//           type: DioErrorType.badResponse,
//           response: Response(
//             requestOptions: RequestOptions(
//               path: path,
//             ),
//             statusCode: HttpStatus.conflict,
//             data: <String, dynamic>{
//               'errorName': 'Piix Error Conflict Resource',
//               'errorMessage':
//                   'There was an error with the phone number provided',
//               'errorMessages': ['Phone number is already in use'],
//               'errorCodes': ['PHONE_NUMBER_ALREADY_USED']
//             },
//           ),
//         ),
//       );
//       await authUserFormProvider.sendPersonalInformationForm(
//         userId: userId,
//         mainUserInfoFormId: mainUserInfoFormId,
//         answers: answers,
//         legalAnswers: legalAnswers,
//       );
//       expect(authUserFormProvider.authUserFormState,
//           AuthUserFormState.phoneAlreadyUsed);
//       final phoneFormField =
//           formFieldBLoc.piixFormModel?.formFieldBy('phoneNumber');
//       expect(phoneFormField, isNotNull);
//       expect(
//           phoneFormField!.responseErrorText, AuthUserCopies.alreadyUsedPhone);
//     });

//     test('User receives an error after sending the personal information form',
//         () async {
//       when(mockDio.put(path, data: answerModel.toJson())).thenThrow(
//         DioError(
//           requestOptions: RequestOptions(
//             path: path,
//           ),
//           type: DioErrorType.badResponse,
//           response: Response(
//             requestOptions: RequestOptions(
//               path: path,
//             ),
//             statusCode: HttpStatus.conflict,
//             data: <String, dynamic>{
//               'errorName': 'Piix Error Conflict Resource',
//               'errorMessage': 'There was an error with some fields provided',
//               'errorMessages': ['The field time is not part of the form'],
//               'errorCodes': ['FIELD_UNKNOWN'],
//               'detailedErrorCodes': <Map<String, dynamic>>[
//                 {
//                   'errorCode': 'NOT_VALID_DATA_TYPE_ID',
//                   'key': 'formFieldId',
//                   'value': 'time'
//                 },
//               ],
//             },
//           ),
//         ),
//       );
//       await authUserFormProvider.sendPersonalInformationForm(
//         userId: userId,
//         mainUserInfoFormId: mainUserInfoFormId,
//         answers: answers,
//         legalAnswers: legalAnswers,
//       );
//       expect(
//           authUserFormProvider.authUserFormState, AuthUserFormState.sentError);
//     });
//   });

//   group('user requests documentation form', () {
//     setUpAll(() {
//       mainUserInfoFormId = 'userDocumentationForm';
//       formModel = AuthUserFormModel(
//         userId: userId,
//         mainUserInfoFormId: mainUserInfoFormId,
//       );
//       path =
//           '${appConfig.catalogEndpoint}/mainUserForms?mainUserInfoFormId=${formModel.mainUserInfoFormId}'
//           '&userId=${formModel.userId}';
//     });

//     setUp(() {
//       authUserFormProvider.clearProvider();
//     });

//     test('user succesfully requests documentation form', () async {
//       when(mockDio.get(path)).thenAnswer(
//         (_) async => Response(
//           requestOptions: RequestOptions(
//             path: path,
//           ),
//           statusCode: HttpStatus.ok,
//           data: fakeDocumentationForm,
//         ),
//       );

//       await authUserFormProvider.getDocumentationForm(
//         userId: userId,
//         mainUserInfoFormId: mainUserInfoFormId,
//       );
//       final personalInformationForm = authUserFormProvider.authUserForm;
//       expect(
//           authUserFormProvider.authUserFormState, AuthUserFormState.retrieved);
//       expect(personalInformationForm, isNotNull);
//       expect(personalInformationForm!.formFields, isNotEmpty);
//       expect(personalInformationForm.formId, fakeDocumentationForm['formId']);
//     });

//     test('user has an error when requesting the documentation form', () async {
//       when(mockDio.get(path)).thenThrow(
//         DioError(
//           requestOptions: RequestOptions(
//             path: path,
//           ),
//           type: DioErrorType.badResponse,
//           response: Response(
//             requestOptions: RequestOptions(
//               path: path,
//             ),
//             statusCode: HttpStatus.notFound,
//             data: <String, dynamic>{
//               'errorName': 'Piix Error Resource not found',
//               'errorMessage': 'There was an error with the form requested',
//               'errorMessages': '["Form id does not belong to any form"]',
//             },
//           ),
//         ),
//       );
//       await authUserFormProvider.getDocumentationForm(
//         userId: userId,
//         mainUserInfoFormId: mainUserInfoFormId,
//       );
//       final authUserForm = authUserFormProvider.authUserForm;
//       expect(authUserFormProvider.authUserFormState,
//           AuthUserFormState.retrieveError);
//       expect(authUserForm, isNull);
//     });
//   });

//   group('user sends documentation form', () {
//     setUpAll(() {
//       answers = formFieldBLoc.responsesToAnswers(documentationFakeFormResponse);
//       mainUserInfoFormId = 'userDocumentationForm';
//       legalAnswers = fakeLegalAnswers;
//       answerModel = BasicFormAnswerModel(
//         userId: userId,
//         mainUserInfoFormId: mainUserInfoFormId,
//         answers: [
//           ...answers,
//           ...legalAnswers,
//         ],
//       );
//       path = '${appConfig.backendEndpoint}/user/mainForms/basicInformation';
//     });

//     setUp(() {
//       authUserFormProvider.clearProvider();
//       formFieldBLoc.piixFormModel =
//           PiixFormModel.fromJson(fakeDocumentationForm);
//     });

//     test('user successfully sends documentation form', () async {
//       when(mockDio.put(path, data: answerModel.toJson())).thenAnswer(
//         (_) async => Response(
//           requestOptions: RequestOptions(
//             path: path,
//           ),
//           statusCode: HttpStatus.created,
//           data: AuthUserFormState.sent,
//         ),
//       );
//       await authUserFormProvider.sendDocumentationForm(
//         userId: userId,
//         mainUserInfoFormId: mainUserInfoFormId,
//         answers: answers,
//         legalAnswers: legalAnswers,
//       );
//       expect(authUserFormProvider.authUserFormState, AuthUserFormState.sent);
//     });

//     test('User receives an error after sending the documentation form',
//         () async {
//       when(mockDio.put(path, data: answerModel.toJson())).thenThrow(
//         DioError(
//           requestOptions: RequestOptions(
//             path: path,
//           ),
//           type: DioErrorType.badResponse,
//           response: Response(
//             requestOptions: RequestOptions(
//               path: path,
//             ),
//             statusCode: HttpStatus.conflict,
//             data: <String, dynamic>{
//               'errorName': 'Piix Error Conflict Resource',
//               'errorMessage': 'There was an error with some fields provided',
//               'errorMessages': ['The field time is not part of the form'],
//               'errorCodes': ['FIELD_UNKNOWN'],
//               'detailedErrorCodes': <Map<String, dynamic>>[
//                 {
//                   'errorCode': 'NOT_VALID_DATA_TYPE_ID',
//                   'key': 'formFieldId',
//                   'value': 'time'
//                 },
//               ],
//             },
//           ),
//         ),
//       );
//       await authUserFormProvider.sendDocumentationForm(
//         userId: userId,
//         mainUserInfoFormId: mainUserInfoFormId,
//         answers: answers,
//         legalAnswers: legalAnswers,
//       );
//       expect(
//           authUserFormProvider.authUserFormState, AuthUserFormState.sentError);
//     });
//   });

//   group('user starts membership verification', () {
//     setUpAll(() {
//       path = '${appConfig.backendEndpoint}/user/mainForms/confirm';
//     });

//     setUp(() {
//       authUserFormProvider.clearProvider();
//     });

//     test('user successfully starts membership verification', () async {
//       when(mockDio.post(path, data: {})).thenAnswer(
//         (_) async => Response(
//           requestOptions: RequestOptions(
//             path: path,
//           ),
//           statusCode: HttpStatus.ok,
//         ),
//       );
//       await authUserFormProvider.startMembershipVerification(
//         status: UserAuthenticationStatus.IN_REVISION,
//       );
//       expect(
//         authUserFormProvider.authUserFormState,
//         AuthUserFormState.sent,
//       );
//     });

//     test('user is unable to start membership verification', () async {
//       when(mockDio.post(path, data: {})).thenThrow(
//         DioError(
//           requestOptions: RequestOptions(
//             path: path,
//           ),
//           response: Response(
//             requestOptions: RequestOptions(
//               path: path,
//             ),
//             statusCode: HttpStatus.badRequest,
//             data: <String, dynamic>{
//               'errorName': 'Piix Error Bad Request',
//               'errorMessage': 'The service you tried to reach is not accesible',
//               'errorMessages': ['Body is not recognized'],
//               'errorCodes': ['UNKNOWN_BODY']
//             },
//           ),
//           type: DioErrorType.badResponse,
//         ),
//       );
//       await authUserFormProvider.startMembershipVerification(
//         status: UserAuthenticationStatus.IN_REVISION,
//       );
//       expect(
//         authUserFormProvider.authUserFormState,
//         AuthUserFormState.sentError,
//       );
//     });
//   });
// }
