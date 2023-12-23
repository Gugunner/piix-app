import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/basic_form_repository_impl.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/basic_form_respository_use_case_test.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/service/basic_form_api.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/domain/model/basic_form_model.dart';
import 'package:piix_mobile/general_app_feature/utils/app_use_case_test.dart';

enum BasicFormState {
  idle,
  retrieving,
  retrieved,
  sending,
  sent,
  ready,
  notFound,
  retrieveError,
  sendError,
}

///Handles all fake and real request implementation calls regarding a basic form.
@Deprecated('Use PersonalInformationForRepository')
class BasicFormRepository {
  BasicFormRepository(this.formApi);

  final BasicFormApi formApi;
  final _appTest = getIt<AppUseCaseTestFlag>().test;

  Future<dynamic> getBasicFormRequested(
      RequestBasicFormModel requestModel) async {
    if (_appTest) {
      return getBasicFormRequestedTest(requestModel);
    }
    return getBasicFormRequestedImpl(requestModel);
  }

  Future<BasicFormState> sendBasicFormRequested(
      BasicFormProtectedAnswerModel answerModel) async {
    if (_appTest) {
      return sendBasicFormRequestedTest(answerModel);
    }
    return sendBasicFormRequestedImpl(answerModel);
  }
}
