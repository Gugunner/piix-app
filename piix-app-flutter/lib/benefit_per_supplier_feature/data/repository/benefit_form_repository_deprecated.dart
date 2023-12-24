import 'package:piix_mobile/benefit_per_supplier_feature/data/repository/benefit_form_repository_impl.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/data/repository/benefit_form_repository_use_case_test.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/data/service/benefit_form_api.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_form_model.dart';

@Deprecated('Will be removed in 4.0')
enum BenefitFormStateDeprecated {
  idle,
  retrieving,
  retrieved,
  sending,
  sent,
  notFound,
  retrievedError,
  sendError,
}

@Deprecated('Will be removed in 4.0')

///Handles all fake and real request implementation calls regarding a
/// benefit form.
class BenefitFormRepositoryDeprecated {
  const BenefitFormRepositoryDeprecated(this.formApi);
  final BenefitFormApi formApi;

  Future<dynamic> getBenefitFormRequested(RequestBenefitFormModel requestModel,
      {bool test = false}) async {
    if (test) {
      return getBenefitFormRequestedTest(requestModel);
    }
    return getBenefitFormRequestedImpl(requestModel);
  }

  Future<dynamic> sendBenefitFormRequested(BenefitFormAnswerModel answerModel,
      {bool test = false}) async {
    if (test) {
      return sendBenefitFormRequestedTest();
    }
    return sendBenefitFormRequestedImpl(answerModel);
  }
}
