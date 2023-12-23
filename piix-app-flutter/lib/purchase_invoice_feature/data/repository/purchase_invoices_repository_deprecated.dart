import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/purchase_invoice_feature/data/repository/purchase_invoices_impl.dart';
import 'package:piix_mobile/purchase_invoice_feature/data/repository/purchase_invoices_use_case_test.dart';
import 'package:piix_mobile/purchase_invoice_feature/data/service/purchase_invoice_api.dart';
import 'package:piix_mobile/general_app_feature/utils/app_use_case_test.dart';

@Deprecated('Will be removed in 4.0')
enum InvoiceStateDeprecated {
  idle,
  getting,
  accomplished,
  empty,
  notFound,
  conflict,
  error,
  unexpectedError,
}

enum InvoiceResponseTypes { success, empty, error, conflict, unexpectedError }

@Deprecated('Will be removed in 4.0')

///This class return a type response depends a service call.
///Manage exception form DioError.
///these _appTest flag to choice test or impl calls
///
class PurchaseInvoiceRepositoryDeprecated {
  PurchaseInvoiceRepositoryDeprecated(this.purchaseInvoiceApi);
  final PurchaseInvoiceApi purchaseInvoiceApi;
  //get a test flag
  final _appTest = getIt<AppUseCaseTestFlag>().test;

  ///Gets purchase invoice by membership id
  ///
  Future<dynamic> getPurchaseInvoiceByMembershipRequested(
      {required String membershipId, bool onlyActiveInvoices = false}) async {
    if (_appTest) {
      return getPurchaseInvoiceByMembershipRequestedTest(
          type: InvoiceResponseTypes.success);
    }
    return getPurchaseInvoiceByMembershipRequestedImpl(
        membershipId: membershipId, onlyActiveInvoices: onlyActiveInvoices);
  }

  ///Get Additional Benefit Purchase Invoice By Id
  ///
  Future<dynamic> getAdditionalBenefitPurchaseInvoiceRequested(
      {required String membershipId, required String purchaseInvoiceId}) async {
    if (_appTest) {
      return getAdditionalBenefitPurchaseInvoiceRequestedTest(
        type: InvoiceResponseTypes.success,
      );
    }
    return getAdditionalBenefitPurchaseInvoiceRequestedImpl(
      membershipId: membershipId,
      purchaseInvoiceId: purchaseInvoiceId,
    );
  }

  ///Get Package Combo Purchase Invoice By Id
  ///
  Future<dynamic> getPackageComboPurchaseInvoiceById(
      {required String membershipId, required String purchaseInvoiceId}) async {
    if (_appTest) {
      return getPackageComboPurchaseInvoiceByIdTest(
          type: InvoiceResponseTypes.success);
    }
    return getPackageComboPurchaseInvoiceByIdImpl(
        membershipId: membershipId, purchaseInvoiceId: purchaseInvoiceId);
  }

  ///Get Level Purchase Invoice By Id
  ///
  Future<dynamic> getLevelPurchaseInvoiceById(
      {required String membershipId, required String purchaseInvoiceId}) async {
    if (_appTest) {
      return getLevelPurchaseInvoiceByIdTest(
          type: InvoiceResponseTypes.success);
    }
    return getLevelPurchaseInvoiceByIdImpl(
        membershipId: membershipId, purchaseInvoiceId: purchaseInvoiceId);
  }

  ///Get Plan Purchase Invoice By Id
  ///
  Future<dynamic> getPlanPurchaseInvoiceById(
      {required String membershipId, required String purchaseInvoiceId}) async {
    if (_appTest) {
      return getPlanPurchaseInvoiceByIdTest(type: InvoiceResponseTypes.success);
    }
    return getPlanPurchaseInvoiceByIdImpl(
        membershipId: membershipId, purchaseInvoiceId: purchaseInvoiceId);
  }
}
