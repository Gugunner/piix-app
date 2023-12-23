import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/store_feature/data/repository/additional_benefits_per_supplier/additional_benefits_per_supplier_impl.dart';
import 'package:piix_mobile/store_feature/data/repository/additional_benefits_per_supplier/additional_benefits_per_supplier_use_case_test.dart';
import 'package:piix_mobile/store_feature/data/service/additional_benefits_per_supplier_api.dart';
import 'package:piix_mobile/store_feature/domain/model/quote_price_request_model/additional_benefit_per_supplier_quote_price_request_model_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/app_use_case_test.dart';

@Deprecated('Will be removed in 4.0')
enum AdditionalBenefitsPerSupplierStateDeprecated {
  idle,
  getting,
  accomplished,
  empty,
  notFound,
  userNotMatchError,
  error,
  unexpectedError,
}

@Deprecated('Will be removed in 4.0')
enum AdditionalBenefitsPerSupplierResponseTypesDeprecated {
  success,
  empty,
  error,
  unexpectedError
}

@Deprecated('Will be removed in 4.0')

///This class return a type response depends a service call.
///Manage exception from DioError.
///use _appTest flag to choice test or impl calls
///
class AdditionalBenefitsPerSupplierRepositoryDeprecated {
  AdditionalBenefitsPerSupplierRepositoryDeprecated(this.additionalBenefitsApi);
  final AdditionalBenefitsPerSupplierApi additionalBenefitsApi;
  final _appTest = getIt<AppUseCaseTestFlag>().test;

  ///Gets additional benefits per supplier by membership id
  ///
  Future<dynamic> getAdditionalBenefitsPerSupplierByMembershipRequested(
      {required String membershipId}) async {
    if (_appTest) {
      return getAdditionalBenefitsPerSupplierByMembershipRequestedTest(
        type: AdditionalBenefitsPerSupplierResponseTypesDeprecated.success,
      );
    }
    return getAdditionalBenefitsPerSupplierByMembershipRequestedImpl(
      membershipId: membershipId,
    );
  }

  ///Gets additional benefits per supplier whit details and prices by additional
  /// benefit per supplier id and membership id
  ///
  Future<dynamic> getAdditionalBenefitPerSupplierDetailsAndPriceRequested(
      {required AdditionalBenefitPerSupplierQuotePriceRequestModel
          requestModel}) async {
    if (_appTest) {
      return getAdditionalBenefitPerSupplierDetailsAndPriceRequestedTest(
        type: AdditionalBenefitsPerSupplierResponseTypesDeprecated.success,
      );
    }
    return getAdditionalBenefitPerSupplierDetailsAndPriceRequestedImpl(
      requestModel: requestModel,
    );
  }
}
