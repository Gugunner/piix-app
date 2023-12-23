import 'package:dio/dio.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/utils/endpoints.dart';
import 'package:piix_mobile/store_feature/domain/model/cancel_payment_request_model.dart';
import 'package:piix_mobile/store_feature/domain/model/user_payment_request_model_deprecated.dart';

///This class contains all payments api calls
///
class PaymentsApi {
  ///Gets payments methods
  ///
  Future<Response> getPaymentsMethods() async {
    try {
      final path = EndPoints.paymentsMethods;
      final response = await PiixApiDeprecated.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  ///Make user payment
  ///
  Future<Response> makeUserPayment(
      {required UserPaymentRequestModel userPaymentRequest}) async {
    try {
      final path = EndPoints.makeUserPayment;
      final response = await PiixApiDeprecated.post(
          data: userPaymentRequest.toJson(), path: path);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  ///cancel user payment
  ///
  Future<Response> cancelUserPayment(
      {required CancelPaymentRequestModel cancelPaymentRequest}) async {
    try {
      final path = EndPoints.cancelUserPayment;
      final response = await PiixApiDeprecated.put(
          data: cancelPaymentRequest.toJson(), path: path);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
