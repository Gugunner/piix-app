import 'package:dio/dio.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/utils/endpoints.dart';
import 'package:piix_mobile/store_feature/domain/model/quote_price_request_model/level_quote_price_request_model_deprecated.dart';

///This class contains all level api calls
///
class LevelsApi {
  ///Gets levels by membership id
  ///
  Future<Response> getLevelsByMembership({required String membershipId}) async {
    try {
      final path = '${EndPoints.levelsByMembership}membershipId=$membershipId';
      final response = await PiixApiDeprecated.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  ///Get levels quotation by levelId
  ///
  Future<Response> getLevelQuotationByMembership(
      {required LevelQuotePriceRequestModel requestModel}) async {
    try {
      final path = '${EndPoints.levelsQuotationByMembership}'
          'membershipId=${requestModel.membershipId}&'
          'levelId=${requestModel.levelId}&'
          'isPartialPurchase=${requestModel.isPartialPurchase}';
      final response = await PiixApiDeprecated.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
