import 'package:piix_mobile/benefit_per_supplier_feature/data/repository/benefit_per_supplier_impl.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/data/repository/benefit_per_supplier_use_case_test.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/data/service/benefit_per_supplier_api.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/request_benefit_per_supplier_model.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/general_app_feature/utils/app_use_case_test.dart';

@Deprecated('Will be removed in 4.0')
enum BenefitPerSupplierStateDeprecated {
  idle,
  retrieving,
  retrieved,
  notFound,
  unauthorized,
  error
}

@Deprecated('Will be removed in 4.0')
class BenefitPerSupplierRepositoryDeprecated {
  BenefitPerSupplierRepositoryDeprecated(this.benefitPerSupplierApi);

  final BenefitPerSupplierApi benefitPerSupplierApi;
  final _appTest = getIt<AppUseCaseTestFlag>().test;

  Future<dynamic> getBenefitPerSupplierRequested(
      RequestBenefitPerSupplierModel requestModel) async {
    if (_appTest) {
      return getBenefitPerSupplierRequestedTest(requestModel);
    }
    return getBenefitPerSupplierRequestedImpl(requestModel);
  }
}
