import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/answer_request_item_model.dart';

final benefitFormFakeAnswers = [
  const AnswerRequestItemModel(
      formFieldId: 'secondLastName',
      dataTypeId: 'string',
      name: 'Segundo Apellido del asegurado',
      isOtherOption: false,
      answer: 'Dejar el campo sin llenar'),
  const AnswerRequestItemModel(
      formFieldId: 'signedIP',
      dataTypeId: 'string',
      name: 'IP',
      isOtherOption: false,
      answer: 'lingus009@gmail.com'),
  const AnswerRequestItemModel(
      formFieldId: 'signedScreenshot',
      dataTypeId: 'string',
      name: 'Screenshot',
      isOtherOption: false,
      answer:
          'packages/CNOC-2022-01/userBenefitForms/benefitForm_CNC2021-S010101000-000_CNC2021/180f430b70b2c4ad85f058a6/2022-12-13/legally-screen-shot/.png'),
  const AnswerRequestItemModel(
      formFieldId: 'signedGeolocalization',
      dataTypeId: 'location',
      name: 'Ubicación',
      isOtherOption: false,
      answer: '19.3215204, -99.078228'),
  const AnswerRequestItemModel(
      formFieldId: 'signedHour',
      dataTypeId: 'time',
      name: 'Hora',
      isOtherOption: false,
      answer: '14:08:54'),
  const AnswerRequestItemModel(
      formFieldId: 'signedDate',
      dataTypeId: 'date',
      name: 'Fecha',
      isOtherOption: false,
      answer: '2022-12-13T14:08:54.290624')
];
