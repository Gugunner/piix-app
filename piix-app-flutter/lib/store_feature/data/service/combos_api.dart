import 'package:dio/dio.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/utils/endpoints.dart';
import 'package:piix_mobile/store_feature/domain/model/quote_price_request_model/combo_quote_price_request_model.dart';

///This class contains all combo api calls
///
class PackageCombosApi {
  ///Gets package combos by membership id
  ///
  Future<Response> getPackageCombosByMembership(
      {required String membershipId}) async {
    try {
      final path =
          '${EndPoints.packageCombosByMembership}membershipId=$membershipId';
      final response = await PiixApiDeprecated.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  ///Get package combos with details and prices by packagecomboId and
  ///membership id
  ///
  Future<Response> getPackageCombosWithDetailsAndPriceByMembership(
      {required ComboQuotePriceRequestModel requestModel}) async {
    try {
      final path = '${EndPoints.packageComboQuotationByMembership}'
          'membershipId=${requestModel.membershipId}&'
          'packageComboId=${requestModel.packageComboId}&'
          'isPartialPurchase=${requestModel.isPartialPurchase}';
      final response = await PiixApiDeprecated.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
