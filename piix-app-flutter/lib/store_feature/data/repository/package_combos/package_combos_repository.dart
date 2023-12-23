import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/store_feature/data/repository/package_combos/package_combos_impl.dart';
import 'package:piix_mobile/store_feature/data/repository/package_combos/package_combos_use_case_test.dart';
import 'package:piix_mobile/store_feature/data/service/combos_api.dart';
import 'package:piix_mobile/store_feature/domain/model/quote_price_request_model/combo_quote_price_request_model.dart';
import 'package:piix_mobile/general_app_feature/utils/app_use_case_test.dart';

enum PackageCombosState {
  idle,
  getting,
  accomplished,
  empty,
  notFound,
  conflict,
  error,
  unexpectedError,
}

enum PackageCombosResponseTypes {
  success,
  empty,
  error,
  conflict,
  unexpectedError
}

///This class return a type response depends a service call.
///Manage exception form DioError.
///ese _appTest flag to choice test or impl calls
///
class PackageCombosRepository {
  PackageCombosRepository(this.packageCombosApi);
  final PackageCombosApi packageCombosApi;
  //get a test flag
  final _appTest = getIt<AppUseCaseTestFlag>().test;

  ///Gets package combos by membership id
  ///
  Future<dynamic> getPackageCombosByMembership(
      {required String membershipId}) async {
    if (_appTest) {
      return getPackageCombosByMembershipTest(
          type: PackageCombosResponseTypes.success);
    }
    return getPackageCombosByMembershipImpl(membershipId: membershipId);
  }

  ///Gets package combos whit details and prices by package combo id and
  /// membership id
  ///
  Future<dynamic> getPackageCombosWithDetailsAndPriceByMembership(
      {required ComboQuotePriceRequestModel requestModel}) async {
    if (_appTest) {
      return getPackageCombosWithDetailsAndPriceByMembershipTest(
          type: PackageCombosResponseTypes.success);
    }
    return getPackageCombosWithDetailsAndPriceByMembershipImpl(
        requestModel: requestModel);
  }
}
