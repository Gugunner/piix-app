import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/store_feature/data/repository/plans/plans_impl.dart';
import 'package:piix_mobile/store_feature/data/repository/plans/plans_use_case_test.dart';
import 'package:piix_mobile/store_feature/data/service/plans_api.dart';
import 'package:piix_mobile/store_feature/domain/model/quote_price_request_model/plans_quote_price_request_model_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/app_use_case_test.dart';

@Deprecated('Will be removed in 4.0')
enum PlanStateDeprecated {
  idle,
  getting,
  accomplished,
  empty,
  notFound,
  conflict,
  error,
  unexpectedError,
}

@Deprecated('Will be removed in 4.0')
enum PlanResponseTypesDeprecated {
  success,
  empty,
  error,
  conflict,
  unexpectedError
}

@Deprecated('Will be removed in 4.0')

///This class return a type response depends a service call.
///Manage exception form DioError.
///ese _appTest flag to choice test or impl calls
///
class PlansRepositoryDeprecated {
  PlansRepositoryDeprecated(this.plansApi);
  final PlansApi plansApi;
  //get a test flag
  final _appTest = getIt<AppUseCaseTestFlag>().test;

  ///Gets plans by membership id
  ///
  Future<dynamic> getPlansByMembershipRequested(
      {required String membershipId}) async {
    if (_appTest) {
      return getPlansByMembershipRequestedTest(
          type: PlanResponseTypesDeprecated.success);
    }
    return getPlansByMembershipRequestedImpl(membershipId: membershipId);
  }

  ///Gets plans quotation by plans ids and membership id
  ///
  Future<dynamic> getPlansQuotationByMembership(
      {required PlansQuotePriceRequestModel requestModel}) async {
    if (_appTest) {
      return await getPlansQuotationByMembershipTest(
          type: PlanResponseTypesDeprecated.success);
    }
    return await getPlansQuotationByMembershipImpl(requestModel: requestModel);
  }
}
