import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/store_feature/data/repository/payments/payments_impl.dart';
import 'package:piix_mobile/store_feature/data/repository/payments/payments_use_case_test.dart';
import 'package:piix_mobile/store_feature/data/service/payments_api.dart';
import 'package:piix_mobile/store_feature/domain/model/cancel_payment_request_model.dart';
import 'package:piix_mobile/store_feature/domain/model/user_payment_request_model_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/app_use_case_test.dart';

@Deprecated('Will be removed in 4.0')
enum PaymentStateDeprecated {
  idle,
  getting,
  accomplished,
  empty,
  error,
  unexpectedError,
  badRequest,
  conflict,
  notFound
}

@Deprecated('Will be removed in 4.0')
enum PaymentResponseTypesDeprecated {
  success,
  empty,
  error,
  unexpectedError,
  badRequest,
  conflict,
  notFound
}

@Deprecated('Will be removed in 4.0')

///This class return a type response depends a service call.
///Manage exception form DioError.
///these _appTest flag to choice test or impl calls
///
class PaymentsRepositoryDeprecated {
  PaymentsRepositoryDeprecated(this.paymentsApi);
  final PaymentsApi paymentsApi;
  //get a test flag
  final _appTest = getIt<AppUseCaseTestFlag>().test;

  ///Gets payments methods
  ///
  Future<dynamic> getPaymentsMethods() async {
    if (_appTest) {
      return getPaymentsMethodsTest(
          type: PaymentResponseTypesDeprecated.success);
    }
    return getPaymentsMethodsImpl();
  }

  ///Make user payment
  ///
  Future<dynamic> makeUserPayment(
      {required UserPaymentRequestModel userPaymentRequest}) async {
    if (_appTest) {
      return makeUserPaymentTest(type: PaymentResponseTypesDeprecated.success);
    }
    return makeUserPaymentImpl(userPaymentRequest: userPaymentRequest);
  }

  ///Cancel user payment
  ///
  Future<dynamic> cancelUserPayment(
      {required CancelPaymentRequestModel cancelPaymentRequest}) async {
    if (_appTest) {
      return cancelUserPaymentTest(
          type: PaymentResponseTypesDeprecated.success);
    }
    return cancelUserPaymentImpl(cancelPaymentRequest: cancelPaymentRequest);
  }
}
