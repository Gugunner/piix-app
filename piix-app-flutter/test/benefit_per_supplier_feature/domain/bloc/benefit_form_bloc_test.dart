// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:piix_mobile/app_config.dart';
// import 'package:piix_mobile/auth_user_feature_deprecated/domain/model/user_app_model.dart';
// import 'package:piix_mobile/benefit_per_supplier_feature/data/repository/benefit_form_repository.dart';
// import 'package:piix_mobile/benefit_per_supplier_feature/data/repository/benefit_form_repository_use_case_test.dart';
// import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_form_provider.dart';
// import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_form_model.dart';
// import 'package:piix_mobile/env/dev.env.dart';
// import 'package:piix_mobile/general_app_feature/api/piix_api.dart';
// import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
// import 'package:piix_mobile/input_form_feature_deprecated/domain/model/piix_form_model.dart';
// import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/answer_request_item_model.dart';

// import '../../../general_app_feature/api/mock_dio.mocks.dart';
// import '../../form_answers/benefit_fake_form_response.dart';

// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();
//   setupGetIt();
//   final appConfig = AppConfig.instance;
//   appConfig
//     ..setBackendEndPoint(DevEnv.backendEndpoint)
//     ..setCatalogSQLURL(DevEnv.catalogEndpoint)
//     ..setSignUpEndpoint(DevEnv.signUpEndpoint)
//     ..setPaymentEndpoint(DevEnv.paymentEndpoint);
//   final mockDio = MockDio();
//   final benefitFormBLoC = BenefitFormNotifier();
//   PiixApi.setDio(mockDio);
//   var path = '';
//   late List<AnswerRequestItemModel> answerList;
//   late String packageId;
//   late UserAppModel user;
//   late PiixFormModel benefitForm;
//   late BenefitFormAnswerModel sendBenefitForm;
//   const benefitFormId = 'CNOC-2022-Indemnizatorio';
//   final requestModel = RequestBenefitFormModel(benefitFormId: benefitFormId);
//   final fakeBenefitForm = getIt<BenefitFormRepository>().fakeBenefitFormJson();
//   final fakeSendBenefitForm =
//       getIt<BenefitFormRepository>().fakeSendBenefitFormResponse();

//   group('get benefit form', () {
//     setUpAll(() {
//       path =
//           'https://${appConfig.backendEndpoint}/benefitForms?benefitFormId=${requestModel.benefitFormId}';
//       benefitFormBLoC.currentBenefitFormId = benefitFormId;
//     });

//     setUp(() {
//       benefitFormBLoC.benefitFormState = BenefitFormState.idle;
//       benefitFormBLoC.benefitForm = null;
//     });
//     //TODO: Refactor once the final implementation is agreed
//     test(
//         'when the service http code response is 200 and includes data '
//         'to store a BenefitFormModel, the BenefitFormState is retrieved',
//         () async {
//       expect(benefitFormBLoC.benefitFormState, BenefitFormState.idle);
//       expect(benefitFormBLoC.benefitForm == null, true);
//       when(mockDio.get(path)).thenAnswer((_) async => Response(
//           requestOptions: RequestOptions(path: path),
//           statusCode: HttpStatus.ok,
//           data: fakeBenefitForm));
//       await benefitFormBLoC.getBenefitForm();
//       expect(benefitFormBLoC.benefitForm!.formId,
//           fakeBenefitForm['benefitFormId']);
//       expect(benefitFormBLoC.benefitForm!.formFields.isNotEmpty, true);
//       expect(benefitFormBLoC.benefitForm!.formFields.first.formFieldId,
//           fakeBenefitForm['formFields'][0]['formFieldId']);
//       expect(benefitFormBLoC.benefitFormState, BenefitFormState.retrieved);
//     });

//     test(
//         'when the service http code response is 404, the BenefitFormState is notFound',
//         () async {
//       expect(benefitFormBLoC.benefitFormState, BenefitFormState.idle);
//       expect(benefitFormBLoC.benefitForm == null, true);
//       when(mockDio.get(path)).thenThrow(DioError(
//           requestOptions: RequestOptions(path: path),
//           response: Response(
//             requestOptions: RequestOptions(path: path),
//             statusCode: HttpStatus.notFound,
//             data: <String, dynamic>{
//               'errorName': 'Piix Error Resource not found',
//               'errorMessage':
//                   'There was an error finding the some information in our server',
//               'errorMessages': '[]'
//             },
//           ),
//           type: DioErrorType.badResponse));
//       await benefitFormBLoC.getBenefitForm();
//       expect(benefitFormBLoC.benefitForm == null, true);
//       expect(benefitFormBLoC.benefitFormState, BenefitFormState.notFound);
//     });
//   });

//   group('get benefit form exceptions', () {
//     setUpAll(() {
//       path =
//           'https://${appConfig.backendEndpoint}/benefitForms?benefitFormId=${requestModel.benefitFormId}';
//       benefitFormBLoC.currentBenefitFormId = benefitFormId;
//     });

//     setUp(() {
//       benefitFormBLoC.benefitFormState = BenefitFormState.idle;
//       benefitFormBLoC.benefitForm = null;
//     });

//     test(
//         'when the service http code response is 200 and does not include data for a valid '
//         'BenefitFormModel, the BenefitFormState is retrievedError', () async {
//       expect(benefitFormBLoC.benefitFormState, BenefitFormState.idle);
//       expect(benefitFormBLoC.benefitForm == null, true);
//       when(mockDio.get(path)).thenAnswer((_) async => Response(
//           requestOptions: RequestOptions(path: path),
//           statusCode: HttpStatus.ok,
//           data: null));
//       await benefitFormBLoC.getBenefitForm();
//       expect(benefitFormBLoC.benefitForm == null, true);
//       expect(benefitFormBLoC.benefitFormState, BenefitFormState.retrievedError);
//     });

//     test(
//         'when the service http code response is 400+, the BenefitFormState is retrievedError',
//         () async {
//       expect(benefitFormBLoC.benefitFormState, BenefitFormState.idle);
//       expect(benefitFormBLoC.benefitForm == null, true);
//       when(mockDio.get(path)).thenThrow(DioError(
//           requestOptions: RequestOptions(path: path),
//           response: Response(
//             requestOptions: RequestOptions(path: path),
//             statusCode: HttpStatus.internalServerError,
//             data: <String, dynamic>{
//               'errorName': 'Piix Error Internal Server Error',
//               'errorMessage': 'There was an unknown error',
//               'errorMessages': '[]'
//             },
//           ),
//           type: DioErrorType.badResponse));
//       await benefitFormBLoC.getBenefitForm();
//       expect(benefitFormBLoC.benefitForm == null, true);
//       expect(benefitFormBLoC.benefitFormState, BenefitFormState.retrievedError);
//     });

//     test(
//         'when the app throws a DioErrorType connection timeout or other, the BenefitFormState is retrievedError',
//         () async {
//       expect(benefitFormBLoC.benefitFormState, BenefitFormState.idle);
//       expect(benefitFormBLoC.benefitForm == null, true);
//       when(mockDio.get(path)).thenThrow(DioError(
//           requestOptions: RequestOptions(path: path),
//           type: DioErrorType.connectionTimeout));
//       await benefitFormBLoC.getBenefitForm();
//       expect(benefitFormBLoC.benefitForm == null, true);
//       expect(benefitFormBLoC.benefitFormState, BenefitFormState.retrievedError);
//     });
//   });

//   group('send benefit form', () {
//     setUpAll(() {
//       path = 'https://${appConfig.backendEndpoint}/user/benefitForms';
//       benefitForm = PiixFormModel(
//           formId: 'benefitForm_CNC2021-S010101000-000_CNC2021',
//           name: 'Formulario para Accidentes Personales',
//           formFields: [],
//           jsonId: 'fds');
//       packageId = 'CNOC-2022-01';
//       user = UserAppModel(
//           customAccessToken: '',
//           userId: '180f430b70b2c4ad85f058a6',
//           email: 'lingus009@gmail.com',
//           processingStatus: UserAuthenticationStatus.APPROVED);
//       sendBenefitForm = BenefitFormAnswerModel(
//           answers: benefitFormFakeAnswers,
//           benefitFormId: benefitForm.formId,
//           packageId: packageId,
//           userId: user.userId);
//     });

//     setUp(() {
//       benefitFormBLoC.benefitFormState = BenefitFormState.idle;
//     });
//     test(
//         'when the service http code response is 200 and includes data '
//         'the BenefitFormState is sent', () async {
//       expect(benefitFormBLoC.benefitFormState, BenefitFormState.idle);
//       expect(benefitFormBLoC.benefitForm == null, true);
//       when(mockDio.post(path, data: sendBenefitForm.toJson())).thenAnswer(
//           (_) async => Response(
//               requestOptions: RequestOptions(path: path),
//               statusCode: HttpStatus.ok,
//               data: fakeSendBenefitForm));
//       await benefitFormBLoC.sendBenefitForm(
//         user: user,
//         packageId: packageId,
//         benefitForm: benefitForm,
//         answers: benefitFormFakeAnswers,
//         benefitPerSupplierId: null,
//         cobenefitPerSupplierId: null,
//         additionalBenefitPerSupplierId: null,
//       );
//       expect(benefitFormBLoC.benefitFormState, BenefitFormState.sent);
//     });

//     test(
//         'when the service http code response is 404, the BenefitFormState is sendError',
//         () async {
//       expect(benefitFormBLoC.benefitFormState, BenefitFormState.idle);
//       expect(benefitFormBLoC.benefitForm == null, true);
//       when(mockDio.post(path, data: sendBenefitForm.toJson()))
//           .thenThrow(DioError(
//               requestOptions: RequestOptions(path: path),
//               response: Response(
//                 requestOptions: RequestOptions(path: path),
//                 statusCode: HttpStatus.notFound,
//                 data: <String, dynamic>{
//                   'errorName': 'Piix Error Resource not found',
//                   'errorMessage':
//                       'There was an error finding the some information in our server',
//                   'errorMessages': '[]'
//                 },
//               ),
//               type: DioErrorType.badResponse));
//       await benefitFormBLoC.sendBenefitForm(
//         user: user,
//         packageId: packageId,
//         benefitForm: benefitForm,
//         answers: benefitFormFakeAnswers,
//         benefitPerSupplierId: null,
//         cobenefitPerSupplierId: null,
//         additionalBenefitPerSupplierId: null,
//       );
//       expect(benefitFormBLoC.benefitFormState, BenefitFormState.notFound);
//     });
//   });

//   group('send benefit form exceptions', () {
//     setUpAll(() {
//       path = 'https://${appConfig.backendEndpoint}/user/benefitForms';
//       benefitForm = PiixFormModel(
//           formId: 'benefitForm_CNC2021-S010101000-000_CNC2021',
//           name: 'Formulario para Accidentes Personales',
//           formFields: [],
//           jsonId: 'fds');
//       packageId = 'CNOC-2022-01';
//       user = UserAppModel(
//           customAccessToken: '',
//           userId: '180f430b70b2c4ad85f058a6',
//           email: 'lingus009@gmail.com',
//           processingStatus: UserAuthenticationStatus.APPROVED);
//       sendBenefitForm = BenefitFormAnswerModel(
//           answers: benefitFormFakeAnswers,
//           benefitFormId: benefitForm.formId,
//           packageId: packageId,
//           userId: user.userId);
//     });

//     setUp(() {
//       benefitFormBLoC.benefitFormState = BenefitFormState.idle;
//     });

//     test(
//         'when the service http code response is 400+, the BenefitFormState is '
//         'sendError', () async {
//       expect(benefitFormBLoC.benefitFormState, BenefitFormState.idle);
//       expect(benefitFormBLoC.benefitForm == null, true);
//       when(mockDio.post(path, data: sendBenefitForm.toJson()))
//           .thenThrow(DioError(
//               requestOptions: RequestOptions(path: path),
//               response: Response(
//                 requestOptions: RequestOptions(path: path),
//                 statusCode: HttpStatus.internalServerError,
//                 data: <String, dynamic>{
//                   'errorName': 'Piix Error Internal Server Error',
//                   'errorMessage': 'There was an unknown error',
//                   'errorMessages': '[]'
//                 },
//               ),
//               type: DioErrorType.badResponse));
//       await benefitFormBLoC.sendBenefitForm(
//         user: user,
//         packageId: packageId,
//         benefitForm: benefitForm,
//         answers: benefitFormFakeAnswers,
//         benefitPerSupplierId: null,
//         cobenefitPerSupplierId: null,
//         additionalBenefitPerSupplierId: null,
//       );

//       expect(benefitFormBLoC.benefitFormState, BenefitFormState.sendError);
//     });

//     test(
//         'when the app throws a DioErrorType connection timeout or other, the '
//         'BenefitFormState is sendError', () async {
//       expect(benefitFormBLoC.benefitFormState, BenefitFormState.idle);
//       expect(benefitFormBLoC.benefitForm == null, true);
//       when(mockDio.post(path, data: sendBenefitForm.toJson())).thenThrow(
//           DioError(
//               requestOptions: RequestOptions(path: path),
//               type: DioErrorType.connectionTimeout));
//       await benefitFormBLoC.sendBenefitForm(
//         user: user,
//         packageId: packageId,
//         benefitForm: benefitForm,
//         answers: benefitFormFakeAnswers,
//         benefitPerSupplierId: null,
//         cobenefitPerSupplierId: null,
//         additionalBenefitPerSupplierId: null,
//       );

//       expect(benefitFormBLoC.benefitFormState, BenefitFormState.sendError);
//     });
//   });
// }
