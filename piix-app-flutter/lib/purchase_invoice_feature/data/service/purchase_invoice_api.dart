import 'package:dio/dio.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/utils/endpoints.dart';

///This class contains all purchase invoices api calls
///
class PurchaseInvoiceApi {
  ///Get all purchase invoice
  ///
  Future<Response> getPurchaseInvoicesByMembershipApi(
      {required String membershipId, bool onlyActiveInvoices = false}) async {
    try {
      final path = '${EndPoints.getPurchaseInvoicesByMembership}'
          'membershipId=$membershipId&onlyActiveInvoices=$onlyActiveInvoices';
      final response = await PiixApiDeprecated.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  ///Get Additional Benefit Purchase Invoice By Id
  ///
  Future<Response> getAdditionalBenefitPurchaseInvoiceApi(
      {required String membershipId, required String purchaseInvoiceId}) async {
    try {
      final path = '${EndPoints.getAdditionalBenefitPurchaseInvoiceById}'
          'membershipId=$membershipId&purchaseInvoiceId=$purchaseInvoiceId';
      final response = await PiixApiDeprecated.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  ///Get Package Combo Purchase Invoice By Id
  ///
  Future<Response> getPackageComboPurchaseInvoiceById(
      {required String membershipId, required String purchaseInvoiceId}) async {
    try {
      final path = '${EndPoints.getPackageComboPurchaseInvoiceById}'
          'membershipId=$membershipId&purchaseInvoiceId=$purchaseInvoiceId';
      final response = await PiixApiDeprecated.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  ///Get Level Purchase Invoice By Id
  ///
  Future<Response> getLevelPurchaseInvoiceById(
      {required String membershipId, required String purchaseInvoiceId}) async {
    try {
      final path = '${EndPoints.getLevelPurchaseInvoiceById}'
          'membershipId=$membershipId&purchaseInvoiceId=$purchaseInvoiceId';
      final response = await PiixApiDeprecated.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  ///Get Plan Purchase Invoice By Id
  ///
  Future<Response> getPlanPurchaseInvoiceById(
      {required String membershipId, required String purchaseInvoiceId}) async {
    try {
      final path = '${EndPoints.getPlanPurchaseInvoiceById}'
          'membershipId=$membershipId&purchaseInvoiceId=$purchaseInvoiceId';
      final response = await PiixApiDeprecated.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
