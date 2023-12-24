import 'package:dio/dio.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/utils/endpoints.dart';
import 'package:piix_mobile/store_feature/domain/model/quote_price_request_model/plans_quote_price_request_model_deprecated.dart';

///This class contains all plans api calls
///
class PlansApi {
  //TODO: Add a DI for PiixApi to call use case tests

  ///Gets plans by membership id
  ///
  Future<Response> getPlansByMembershipApi(
      {required String membershipId}) async {
    try {
      final path = '${EndPoints.plansByMembership}membershipId=$membershipId';
      final response = await PiixApiDeprecated.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  ///Get plans quotation by plansIds
  ///
  Future<Response> getPlansQuotationByMembership(
      {required PlansQuotePriceRequestModel requestModel}) async {
    try {
      final path = '${EndPoints.plansQuotationByMembership}'
          'membershipId=${requestModel.membershipId}&'
          'planIds=${requestModel.planIds}';
      final response = await PiixApiDeprecated.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
