import 'package:dio/dio.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/utils/endpoints.dart';
import 'package:piix_mobile/store_feature/domain/model/quote_price_request_model/additional_benefit_per_supplier_quote_price_request_model_deprecated.dart';

///This class contains all additional benefits per supplier api calls
///
class AdditionalBenefitsPerSupplierApi {
  ///Gets additional benefits per supplier by membership id
  ///
  Future<Response> getAdditionalBenefitsPerSupplierByMembershipApi(
      {required String membershipId}) async {
    try {
      final path = '${EndPoints.additionalBenefitsPerSupplierByMembership}'
          'membershipId=$membershipId';
      final response = await PiixApiDeprecated.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  ///Gets additional benefits per supplier whit details and prices by additional
  /// benefit per supplier id and membership id
  ///
  Future<Response> getAdditionalBenefitPerSupplierDetailsAndPriceApi(
      {required AdditionalBenefitPerSupplierQuotePriceRequestModel
          requestModel}) async {
    try {
      final path = '${EndPoints.addittionalBenefitsPerSupplierQuotation}'
          'membershipId=${requestModel.membershipId}&'
          'additionalBenefitPerSupplierId='
          '${requestModel.additionalBenefitPerSupplierId}&'
          'isPartialPurchase=${requestModel.isPartialPurchase}';
      final response = await PiixApiDeprecated.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
