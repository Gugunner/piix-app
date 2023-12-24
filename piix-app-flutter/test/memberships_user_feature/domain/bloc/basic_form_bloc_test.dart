// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:piix_mobile/app_config.dart';
// import 'package:piix_mobile/auth_user_feature_deprecated/domain/model/user_app_model.dart';
// import 'package:piix_mobile/env/dev.env.dart';
// import 'package:piix_mobile/general_app_feature/api/piix_api.dart';
// import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
// import 'package:piix_mobile/input_form_feature_deprecated/domain/bloc/form_field_bloc.dart';
// import 'package:piix_mobile/input_form_feature_deprecated/domain/model/piix_form_model.dart';
// import 'package:piix_mobile/input_form_feature_deprecated/domain/model/piix_form_field_model.dart';
// import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/basic_form_repository.dart';
// import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/basic_form_respository_use_case_test.dart';
// import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/user_repository.dart';
// import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/user_repository_use_case_test.dart';
// import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/basic_form_bloc.dart';
// import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider.dart';
// import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc.dart';
// import 'package:piix_mobile/auth_user_form_feature_deprecated/domain/model/basic_form_model.dart';

// import '../../../general_app_feature/api/mock_dio.mocks.dart';

// void main() {
//   setupGetIt();
//   final appConfig = AppConfig.instance;
//   appConfig
//     ..setBackendEndPoint(DevEnv.backendEndpoint)
//     ..setCatalogSQLURL(DevEnv.catalogEndpoint)
//     ..setSignUpEndpoint(DevEnv.signUpEndpoint)
//     ..setPaymentEndpoint(DevEnv.paymentEndpoint);
//   final mockDio = MockDio();
//   final basicFormBLoC = BasicFormBLoC();
//   final formFieldBLoC = getIt<FormFieldBLoC>();
//   final userBLoC = getIt<UserBLoC>();
//   final membershipBLoC = getIt<MembershipProvider>();
//   PiixApi.setDio(mockDio);

//   var path = '';
//   const userId = 'cbb3c0b45ccf0871d8bf101c';
//   const packageId = 'CNOC-2022-01';
//   const mainUserInfoFormId = '';
//   final fakeNewBasicForm = getIt<BasicFormRepository>().fakeNewBasicFormJson();
//   final fakeUser = getIt<UserRepository>().fakeJsonUser();
//   late RequestBasicFormModel requestModel;
//   late BasicFormAnswerModel answerModel;
//   late String formId;

//   List<PiixFormFieldModel> fakeResponses(List<PiixFormFieldModel> formFields) {
//     const formFieldIds = ['kinshipId', 'genderId', 'countryId', 'stateId'];
//     return formFields.map((formField) {
//       String? idResponse;
//       String? stringResponse;
//       String? otherResponse;
//       if (formFieldIds.contains(formField.formFieldId)) {
//         idResponse = formField.idResponse ?? formField.values!.first.id;
//         stringResponse =
//             formField.stringResponse ?? formField.values!.first.name;
//       } else {
//         stringResponse = formField.stringResponse ?? '100';
//       }
//       return formField.copyWith(
//         idResponse: idResponse,
//         stringResponse: stringResponse,
//         otherResponse: otherResponse,
//       );
//     }).toList();
//   }

//   group('get basic form', () {
//     setUpAll(() {
//       requestModel = RequestBasicFormModel(
//           userId: userId, mainUserInfoFormId: mainUserInfoFormId);
//       path =
//           '${appConfig.catalogEndpoint}/mainUserForms?mainUserInfoFormId=basicInsuredForm'
//           '&userId=${requestModel.userId}';
//     });

//     setUp(() {
//       basicFormBLoC
//         ..basicFormState = BasicFormState.idle
//         ..basicForm = null;
//     });

//     test(
//         'when the service http code response is 200 and includes '
//         'valid data to store a BasicFormModel, the BasicFormState is retrieved',
//         () async {
//       expect(basicFormBLoC.basicFormState, BasicFormState.idle);
//       expect(basicFormBLoC.basicForm == null, true);
//       when(mockDio.get(path)).thenAnswer((_) async => Response(
//             requestOptions: RequestOptions(path: path),
//             statusCode: HttpStatus.ok,
//             data: fakeNewBasicForm,
//           ));
//       await basicFormBLoC.getBasicForm(
//           userId: userId,
//           packageId: packageId,
//           mainUserInfoFormId: mainUserInfoFormId);
//       expect(basicFormBLoC.basicForm != null, true);
//       expect(basicFormBLoC.basicForm!.formFields.isNotEmpty, true);
//       expect(basicFormBLoC.basicForm!.formFields.first.formFieldId,
//           fakeNewBasicForm['formFields'][0]['formFieldId']);
//       expect(basicFormBLoC.basicFormState, BasicFormState.retrieved);
//     });

//     test(
//         'when the service http code response is 404, the BasicFormState is notFound',
//         () async {
//       expect(basicFormBLoC.basicFormState, BasicFormState.idle);
//       expect(basicFormBLoC.basicForm == null, true);
//       when(mockDio.get(path)).thenThrow(DioError(
//         requestOptions: RequestOptions(path: path),
//         response: Response(
//           requestOptions: RequestOptions(path: path),
//           statusCode: HttpStatus.notFound,
//           data: <String, dynamic>{
//             'errorName': 'Piix Error Resource not found',
//             'errorMessage':
//                 'There was an error finding the basic form information',
//             'errorMessages': '[]'
//           },
//         ),
//         type: DioErrorType.badResponse,
//       ));
//       await basicFormBLoC.getBasicForm(
//           userId: userId,
//           packageId: packageId,
//           mainUserInfoFormId: mainUserInfoFormId);
//       expect(basicFormBLoC.basicForm == null, true);
//       expect(basicFormBLoC.basicFormState, BasicFormState.notFound);
//     });
//   });

//   group('get basic form exceptions', () {
//     setUpAll(() {
//       requestModel = RequestBasicFormModel(
//           userId: userId, mainUserInfoFormId: mainUserInfoFormId);
//       path =
//           '${appConfig.catalogEndpoint}/mainUserForms?mainUserInfoFormId=basicInsuredForm'
//           '&userId=${requestModel.userId}';
//     });

//     setUp(() {
//       basicFormBLoC
//         ..basicFormState = BasicFormState.idle
//         ..basicForm = null;
//     });

//     test(
//         'when the service http code response is 400+, the the BasicFormState is error',
//         () async {
//       expect(basicFormBLoC.basicFormState, BasicFormState.idle);
//       expect(basicFormBLoC.basicForm == null, true);
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
//       await basicFormBLoC.getBasicForm(
//           userId: userId,
//           packageId: packageId,
//           mainUserInfoFormId: mainUserInfoFormId);
//       expect(basicFormBLoC.basicForm == null, true);
//       expect(basicFormBLoC.basicFormState, BasicFormState.retrieveError);
//     });

//     test(
//         'when the app throws a DioErrorType connection timeout or other, the the BasicFormState is error',
//         () async {
//       expect(basicFormBLoC.basicFormState, BasicFormState.idle);
//       expect(basicFormBLoC.basicForm == null, true);
//       when(mockDio.get(path)).thenThrow(DioError(
//         requestOptions: RequestOptions(path: path),
//         type: DioErrorType.connectionTimeout,
//       ));
//       await basicFormBLoC.getBasicForm(
//           userId: userId,
//           packageId: packageId,
//           mainUserInfoFormId: mainUserInfoFormId);
//       expect(basicFormBLoC.basicForm == null, true);
//       expect(basicFormBLoC.basicFormState, BasicFormState.retrieveError);
//     });
//   });

//   group('send basic form', () {
//     setUpAll(() {
//       final user = UserAppModel.fromJson(fakeUser);
//       final basicForm = PiixFormModel.fromJson(fakeNewBasicForm);
//       formId = basicForm.formId;
//       userBLoC.user = user;
//       membershipBLoC.setSelectedMembership(user.memberships!.first);
//       formFieldBLoC.piixFormModel = PiixFormModel.fromJson(fakeNewBasicForm);
//       formFieldBLoC.piixFormModel = formFieldBLoC.piixFormModel
//           ?.setFormFields(fakeResponses(formFieldBLoC.formFields));
//       var answers = formFieldBLoC.responsesToAnswers(formFieldBLoC.formFields);
//       answers = [
//         ...answers,
//         ...basicFormBLoC.basicFormAdditionalAnswers(
//           isProtectedUser: false,
//           packageId: packageId,
//         )
//       ];
//       answerModel = BasicFormAnswerModel(
//         userId: userId,
//         mainUserInfoFormId: formId,
//         answers: answers,
//       );
//       path = '${appConfig.backendEndpoint}/user/mainForms/basicInformation';
//     });

//     setUp(() {
//       basicFormBLoC.basicFormState = BasicFormState.idle;
//     });

//     test(
//         'when the service http code response is 201 when creating, the BasicFormState is sent',
//         () async {
//       expect(basicFormBLoC.basicFormState, BasicFormState.idle);
//       when(mockDio.put(path, data: answerModel.toJson()))
//           .thenAnswer((_) async => Response(
//                 requestOptions: RequestOptions(path: path),
//                 statusCode: HttpStatus.created,
//               ));
//       await basicFormBLoC.sendBasicForm(mainUserInfoFormId: mainUserInfoFormId);
//       expect(basicFormBLoC.basicFormState, BasicFormState.sent);
//     });

//     test(
//         'when the service http code response is 200 when updating, the BasicFormState is sent',
//         () async {
//       expect(basicFormBLoC.basicFormState, BasicFormState.idle);
//       answerModel = answerModel.copyWith(
//         userMainFormId: '${userId}_$formId',
//       );
//       when(mockDio.put(path, data: answerModel.toJson()))
//           .thenAnswer((_) async => Response(
//                 requestOptions: RequestOptions(path: path),
//                 statusCode: HttpStatus.ok,
//               ));
//       await basicFormBLoC.sendBasicForm(
//           update: true, mainUserInfoFormId: mainUserInfoFormId);
//       expect(basicFormBLoC.basicFormState, BasicFormState.sent);
//     });

//     test(
//         'when the service http code response is 404, the BasicFormState is notFound',
//         () async {
//       expect(basicFormBLoC.basicFormState, BasicFormState.idle);
//       when(mockDio.put(path, data: answerModel.toJson())).thenThrow(
//         DioError(
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
//           type: DioErrorType.badResponse,
//         ),
//       );
//       await basicFormBLoC.sendBasicForm(
//           update: true, mainUserInfoFormId: mainUserInfoFormId);
//       expect(basicFormBLoC.basicFormState, BasicFormState.notFound);
//     });
//   });
//   //
//   group('send basic form exceptions', () {
//     setUpAll(() {
//       final user = UserAppModel.fromJson(fakeUser);
//       final basicForm = PiixFormModel.fromJson(fakeNewBasicForm);
//       formId = basicForm.formId;
//       userBLoC.user = user;
//       membershipBLoC.setSelectedMembership(user.memberships!.first);
//       formFieldBLoC.piixFormModel = PiixFormModel.fromJson(fakeNewBasicForm);
//       formFieldBLoC.piixFormModel = formFieldBLoC.piixFormModel
//           ?.setFormFields(fakeResponses(formFieldBLoC.formFields));
//       final answers =
//           formFieldBLoC.responsesToAnswers(formFieldBLoC.formFields);
//       answers.addAll(basicFormBLoC.basicFormAdditionalAnswers(
//           isProtectedUser: false, packageId: packageId));
//       answerModel = BasicFormAnswerModel(
//         userId: userId,
//         mainUserInfoFormId: formId,
//         answers: answers,
//       );
//       path = '${appConfig.backendEndpoint}/user/mainForms/basicInformation';
//     });

//     setUp(() {
//       basicFormBLoC.basicFormState = BasicFormState.idle;
//     });

//     test(
//         'when the service returns a 400+ http response code, the BasicFormState is error',
//         () async {
//       expect(basicFormBLoC.basicFormState, BasicFormState.idle);
//       when(mockDio.put(path, data: answerModel.toJson())).thenThrow(
//         DioError(
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
//           type: DioErrorType.badResponse,
//         ),
//       );
//       await basicFormBLoC.sendBasicForm(mainUserInfoFormId: mainUserInfoFormId);
//       expect(basicFormBLoC.basicFormState, BasicFormState.sendError);
//     });

//     test(
//         'when the app throws a DioErrorType connection timeout or other, the the BasicFormState is error',
//         () async {
//       expect(basicFormBLoC.basicFormState, BasicFormState.idle);
//       when(mockDio.put(path, data: answerModel.toJson())).thenThrow(
//         DioError(
//           requestOptions: RequestOptions(path: path),
//           type: DioErrorType.connectionTimeout,
//         ),
//       );
//       await basicFormBLoC.sendBasicForm(mainUserInfoFormId: mainUserInfoFormId);
//       expect(basicFormBLoC.basicFormState, BasicFormState.sendError);
//     });
//   });
// }
