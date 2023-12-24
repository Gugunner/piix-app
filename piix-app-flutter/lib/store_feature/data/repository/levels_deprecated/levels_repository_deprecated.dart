import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/store_feature/data/repository/levels_deprecated/levels_impl.dart';
import 'package:piix_mobile/store_feature/data/repository/levels_deprecated/levels_use_case_test.dart';
import 'package:piix_mobile/store_feature/data/service/levels_api.dart';
import 'package:piix_mobile/store_feature/domain/model/quote_price_request_model/level_quote_price_request_model_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/app_use_case_test.dart';

@Deprecated('Will be removed in 4.0')
enum LevelStateDeprecated {
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
enum LevelResponseTypesDeprecated {
  success,
  empty,
  error,
  conflict,
  unexpectedError
}

@Deprecated('Will be removed in 4.0')

///This class return a type response depends a service call.
///Manage exception form DioError.
///these _appTest flag to choice test or impl calls
///
class LevelsRepositoryDeprecated {
  LevelsRepositoryDeprecated(this.levelsApi);
  final LevelsApi levelsApi;
  //get a test flag
  final _appTest = getIt<AppUseCaseTestFlag>().test;

  ///Gets levels by membership id
  ///
  Future<dynamic> getLevelsByMembership({required String membershipId}) async {
    if (_appTest) {
      return getLevelsByMembershipTest(
          type: LevelResponseTypesDeprecated.success);
    }
    return getLevelsByMembershipImpl(membershipId: membershipId);
  }

  ///Gets level quotation by level id and membership id
  ///
  Future<dynamic> getLevelQuotationByMembership(
      {required LevelQuotePriceRequestModel requestModel}) async {
    if (_appTest) {
      return getLevelQuotationByMembershipTest(
          type: LevelResponseTypesDeprecated.success);
    }
    return getLevelQuotationByMembershipImpl(requestModel: requestModel);
  }
}
