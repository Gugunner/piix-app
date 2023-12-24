import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/store_feature/utils/store_module_enum_deprecated.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_model.dart';
import 'package:piix_mobile/store_feature/data/repository/payments/payments_repository_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/cancel_payment_request_model.dart';
import 'package:piix_mobile/store_feature/domain/model/payment_method_model.dart';
import 'package:piix_mobile/store_feature/domain/model/user_payment_request_model_deprecated.dart';
import 'package:piix_mobile/store_feature/utils/payment_methods.dart';

@Deprecated('Will be removed in 4.0')

///This BLoC is where all the payments logic is located
///
class PaymentsBLoCDeprecated with ChangeNotifier {
  ///Stores the [PaymentStateDeprecated] and is used by all the
  ///methods that call an api inside [PaymentStateDeprecated]
  PaymentStateDeprecated _paymentState = PaymentStateDeprecated.idle;
  PaymentStateDeprecated get paymentState => _paymentState;
  set paymentState(PaymentStateDeprecated state) {
    _paymentState = state;
    notifyListeners();
  }

  ///Stores the [PaymentStateDeprecated] and is used by all the
  ///methods that call an api inside [PaymentStateDeprecated]
  PaymentStateDeprecated _userPaymentState = PaymentStateDeprecated.idle;
  PaymentStateDeprecated get userPaymentState => _userPaymentState;
  set userPaymentState(PaymentStateDeprecated state) {
    _userPaymentState = state;
    notifyListeners();
  }

  PaymentStateDeprecated _cancelPaymentState = PaymentStateDeprecated.idle;
  PaymentStateDeprecated get cancelPaymentState => _cancelPaymentState;
  set cancelPaymentState(PaymentStateDeprecated state) {
    _cancelPaymentState = state;
    notifyListeners();
  }

  ///Stores a payment methods list in [paymentMethods]
  List<PaymentMethodModel> _paymentMethods = [];
  List<PaymentMethodModel> get paymentMethods => _paymentMethods;
  set paymentMethods(List<PaymentMethodModel> value) {
    _paymentMethods = value;
    notifyListeners();
  }

  ///Stores a payment methods list in [paymentMethods]
  PaymentMethodModel? _selectedPaymentMethod;
  PaymentMethodModel? get selectedPaymentMethod => _selectedPaymentMethod;
  set selectedPaymentMethod(PaymentMethodModel? value) {
    _selectedPaymentMethod = value;
    notifyListeners();
  }

  InvoiceModel? _userPaymentModel;
  InvoiceModel? get userPaymentModel => _userPaymentModel;
  void setUserPaymentModel(InvoiceModel? payment) {
    _userPaymentModel = payment;
    notifyListeners();
  }

  StoreModuleDeprecated? _moduleToPay;
  StoreModuleDeprecated? get moduleToPay => _moduleToPay;
  set moduleToPay(StoreModuleDeprecated? value) {
    _moduleToPay = value;
    notifyListeners();
  }

  double _paymentDiscount = 0.0;
  double get paymentDiscount => _paymentDiscount;
  set paymentDiscount(double value) {
    _paymentDiscount = value;
    notifyListeners();
  }

  double _transactionAmount = 0.0;
  double get transactionAmount => _transactionAmount;
  set transactionAmount(double value) {
    _transactionAmount = value;
    notifyListeners();
  }

  String _paymentPurchaseName = '';
  String get paymentPurchaseName => _paymentPurchaseName;
  set paymentPurchaseName(String value) {
    _paymentPurchaseName = value;
    notifyListeners();
  }

  String? _userQuotationId;
  String? get userQuotationId => _userQuotationId;
  set userQuotationId(String? value) {
    _userQuotationId = value;
    notifyListeners();
  }

  DateTime? _quotationRegisterDate;
  DateTime? get quotationRegisterDate => _quotationRegisterDate;
  set quotationRegisterDate(DateTime? value) {
    _quotationRegisterDate = value;
    notifyListeners();
  }

  int? _protectedQuantity;
  int? get protectedQuantity => _protectedQuantity;
  void setProtectedQuantity(int? protectedQuantity) {
    _protectedQuantity = protectedQuantity;
    notifyListeners();
  }

  ///Instantiated a service locator for [LevelsRepository]
  ///
  PaymentsRepositoryDeprecated get _paymentsRepository =>
      getIt<PaymentsRepositoryDeprecated>();

  ///Retrieves the detailed information of a paymeys methods
  /// by calling [_paymentsRepository] getLevelsByMembership
  /// method.
  ///
  /// Stores the payment methods list in [paymentMethods]
  ///  and establishes the [PaymentStateDeprecated] accomplished
  /// if the request is successful.
  ///
  /// If the request is not successful it either sets [PaymentStateDeprecated]
  /// in [paymentState] as error, or unexpectedError.
  ///
  Future<void> getPaymentsMethods() async {
    try {
      paymentState = PaymentStateDeprecated.getting;
      final data = await _paymentsRepository.getPaymentsMethods();

      if (data is PaymentStateDeprecated) {
        paymentState = data;
        paymentMethods = [];
      } else {
        final List<dynamic> responseData = data;
        paymentMethods =
            responseData.map((e) => PaymentMethodModel.fromJson(e)).toList();
        if (paymentMethods.isEmpty) {
          paymentState = PaymentStateDeprecated.empty;
        } else {
          paymentState = PaymentStateDeprecated.accomplished;
        }
      }
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in getPaymentsMethods',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      paymentState = PaymentStateDeprecated.error;
    }
  }

  ///Retrieves the detailed information of a user payment
  /// by calling [_paymentsRepository] makeUserPayment
  /// method.
  ///
  /// Stores the user payment  in [userPaymentModel]
  ///  and establishes the [PaymentStateDeprecated] accomplished
  /// if the request is successful.
  ///
  /// If the request is not successful it either sets [PaymentStateDeprecated]
  /// in [userPaymentState] as error, or unexpectedError.
  ///
  Future<PaymentStateDeprecated> makeUserPayment(
      {required UserPaymentRequestModel userPaymentRequest}) async {
    try {
      userPaymentState = PaymentStateDeprecated.getting;
      final data = await _paymentsRepository.makeUserPayment(
        userPaymentRequest: userPaymentRequest,
      );
      if (data is PaymentStateDeprecated) {
        _userPaymentState = data;
        setUserPaymentModel(null);
      } else {
        if (data != null) {
          final userPaymentModel = InvoiceModel.fromJson(data)
            ..setMissingPaymentInfo(
              finalDiscount: paymentDiscount,
              paymentMethodName: selectedPaymentMethod?.name ?? '',
              paymentPurchaseName: paymentPurchaseName.removeLineBreak,
              protectedQuantity: protectedQuantity ?? 0,
            );
          setUserPaymentModel(userPaymentModel);
          _userPaymentState = PaymentStateDeprecated.accomplished;
        }
      }
      notifyListeners();
      return _userPaymentState;
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in makeUserPayment '
            'with user quotation id ${userPaymentRequest.userQuotationId}',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      userPaymentState = PaymentStateDeprecated.error;
      return _userPaymentState;
    }
  }

  ///Retrieves the detailed information of a user payment
  /// by calling [_paymentsRepository] makeUserPayment
  /// method.
  ///
  /// Stores the user payment  in [userPaymentModel]
  ///  and establishes the [PaymentStateDeprecated] accomplished
  /// if the request is successful.
  ///
  /// If the request is not successful it either sets [PaymentStateDeprecated]
  /// in [userPaymentState] as error, or unexpectedError.
  ///
  Future<void> cancelUserPayment(
      {required CancelPaymentRequestModel cancelPaymentRequest}) async {
    try {
      cancelPaymentState = PaymentStateDeprecated.getting;
      final data = await _paymentsRepository.cancelUserPayment(
          cancelPaymentRequest: cancelPaymentRequest);
      if (data is PaymentStateDeprecated) {
        cancelPaymentState = data;
      } else {
        if (data != null) {
          cancelPaymentState = PaymentStateDeprecated.accomplished;
        }
      }
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in cancelUserPayment'
            'with purchase invoice id '
            '${cancelPaymentRequest.purchaseInvoiceId}',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      cancelPaymentState = PaymentStateDeprecated.error;
    }
  }

  void clearProvider() {
    _userPaymentState = PaymentStateDeprecated.idle;
    _paymentState = PaymentStateDeprecated.idle;
    _paymentMethods = [];
    _selectedPaymentMethod = null;
    notifyListeners();
  }
}
