import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/file_feature/domain/model/file_model.dart';
import 'package:piix_mobile/utils/extensions/list_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/purchase_invoice_feature/data/repository/purchase_invoices_repository_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_model.dart';
import 'package:piix_mobile/purchase_invoice_feature/utils/purchase_invoice_enums.dart';
import 'package:piix_mobile/purchase_invoice_feature/utils/product_type_enum_deprecated.dart';
import 'package:piix_mobile/store_feature/data/repository/levels_deprecated/levels_repository_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/plan_model_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This BLoC is where all the purchase invoices logic is located
///
class PurchaseInvoiceBLoCDeprecated with ChangeNotifier {
  ///Stores the [LevelStateDeprecated] and is used by all the
  ///methods that call an api inside [LevelStateDeprecated]
  InvoiceStateDeprecated _invoiceState = InvoiceStateDeprecated.idle;
  InvoiceStateDeprecated get invoiceState => _invoiceState;
  set invoiceState(InvoiceStateDeprecated state) {
    _invoiceState = state;
    notifyListeners();
  }

  ///Stores the [LevelStateDeprecated] and is used by all the
  ///methods that call an api inside [LevelStateDeprecated]
  InvoiceStateDeprecated _invoiceTicketState = InvoiceStateDeprecated.idle;
  InvoiceStateDeprecated get invoiceTicketState => _invoiceTicketState;
  set invoiceTicketState(InvoiceStateDeprecated state) {
    _invoiceTicketState = state;
    notifyListeners();
  }

  ///Stores a purchase invoice list in [_purchaseInvoiceList]
  List<InvoiceModel> _purchaseInvoiceList = [];
  List<InvoiceModel> get purchaseInvoiceList => _purchaseInvoiceList;
  void setPurchaseInvoiceList(List<InvoiceModel> value) {
    _purchaseInvoiceList = value;
    notifyListeners();
  }

  List<InvoiceModel> _activePurchases = [];
  List<InvoiceModel> get activePurchases => _activePurchases;
  void setActivePurchases(List<InvoiceModel> value) {
    _activePurchases = value;
    notifyListeners();
  }

  List<InvoiceModel> get activePurchaseList => activePurchases
      .where((element) => element.productStatus == ProductStatus.active)
      .toList();

  List<InvoiceModel> get additionalPurchaseList {
    final benefitList = activePurchaseList
        .where((element) =>
            element.userQuotation.productType ==
            ProductTypeDeprecated.ADDITIONAL)
        .toList();
    benefitList.sort((a, b) => a.registerDate.compareTo(a.registerDate));
    return benefitList;
  }

  List<InvoiceModel> get comboPurchaseList {
    final comboList = activePurchaseList
        .where((element) =>
            element.userQuotation.productType == ProductTypeDeprecated.COMBO)
        .toList();
    comboList.sort((a, b) => b.registerDate.compareTo(a.registerDate));
    return comboList;
  }

  List<PlanModel> get purchasePlanList {
    final purchasePlanList = activePurchaseList
        .where((element) =>
            element.userQuotation.productType == ProductTypeDeprecated.PLAN)
        .toList();
    final allPlanList = purchasePlanList
        .expand((purchase) => purchase.products.plans ?? <PlanModel>[])
        .toList();
    allPlanList.sort((a, b) => a.name.compareTo(b.name));
    return allPlanList;
  }

  void modifyStatusInPurchaseInvoiceList(String purchaseInvoiceId,
      PaymentStatus paymentStatus, ProductStatus productStatus) {
    final index = _purchaseInvoiceList.indexWhere(
        (element) => element.purchaseInvoiceId == purchaseInvoiceId);

    _purchaseInvoiceList[index] = _purchaseInvoiceList[index]
        .copyWith(paymentStatus: paymentStatus, productStatus: productStatus);
    notifyListeners();
  }

  ///Stores the detail purchase invoice
  InvoiceModel? _invoice;
  InvoiceModel? get invoice => _invoice;
  void setInvoice(InvoiceModel? id) {
    _invoice = id;
    notifyListeners();
  }

  ///Stores the detail purchase invoice
  InvoiceModel? _paymentLineFromList;
  InvoiceModel? get paymentLineFromList => _paymentLineFromList;
  set paymentLineFromList(InvoiceModel? model) {
    _paymentLineFromList = model;
    notifyListeners();
  }

  void setAdditionalBenefitPerSupplierLogoFiles(List<FileModel?> files) {
    for (final file in files) {
      if (file?.fileContent == null) continue;
      final name = file?.fileContent?.name.split('.')[0].split('/');
      if (name.isNullOrEmpty) continue;
      final base64Image = file?.fileContent?.base64Content;
      final supplier = invoice
          ?.products.additionalBenefitsPerSupplier?.first.supplier
          ?.copyWith(
        logoMemory: base64Image ?? '',
      );
      if (supplier == null || invoice == null) continue;
      final additionalBenefitPerSupplier =
          invoice!.products.additionalBenefitsPerSupplier?.first;
      additionalBenefitPerSupplier?.mapOrNull((value) => null,
          additional: (value) {
        final benefitPerSupplier = value.copyWith(
          supplier: supplier,
        );
        if (invoice!.products.additionalBenefitsPerSupplier.isNullOrEmpty)
          return;

        final additionalBenefitsPerSupplier = [
          benefitPerSupplier,
          ...invoice!.products.additionalBenefitsPerSupplier!.sublist(1)
        ];
        final products = invoice!.products.copyWith(
          additionalBenefitsPerSupplier: additionalBenefitsPerSupplier,
        );
        final purchaseInvoiceDetail = invoice!.setProducts(products);
        setInvoice(
          purchaseInvoiceDetail,
        );
      });
    }
    notifyListeners();
  }

  ///Instantiated a service locator for [PurchaseInvoiceRepositoryDeprecated]
  ///
  PurchaseInvoiceRepositoryDeprecated get _purchaseInvoiceRepository =>
      getIt<PurchaseInvoiceRepositoryDeprecated>();

  ///Retrieves the detailed information of a additional benefits per supplier
  /// by calling [_purchaseInvoiceRepository] getPurchaseInvoiceByMembership
  /// method.
  ///
  /// Stores the purchase invoice list in [purchaseInvoiceList] and establishes
  /// the [InvoiceStateDeprecated] accomplished if the request is successful.
  ///
  /// If the request is not successful it either sets [InvoiceStateDeprecated]
  /// in [invoiceState] as error, conflict, notFound or unexpectedError.
  ///
  Future<void> getAllInvoicesByMembership({
    required String membershipId,
    bool onlyActiveInvoices = false,
  }) async {
    try {
      invoiceState = InvoiceStateDeprecated.getting;
      final data = await _purchaseInvoiceRepository
          .getPurchaseInvoiceByMembershipRequested(
        membershipId: membershipId,
        onlyActiveInvoices: onlyActiveInvoices,
      );
      if (data is InvoiceStateDeprecated) {
        invoiceState = data;
      } else {
        final List<dynamic> dataList = data;
        final invoiceList = dataList.map((d) {
          d['modelType'] = 'purchased';
          return InvoiceModel.fromJson(d);
        }).toList();
        invoiceList.sort(
            (a, b) => b.productStatus.index.compareTo(a.productStatus.index));
        if (invoiceList.isNotEmpty) {
          invoiceState = InvoiceStateDeprecated.accomplished;
        } else {
          invoiceState = InvoiceStateDeprecated.empty;
        }
        if (onlyActiveInvoices) {
          setActivePurchases(invoiceList);
          return;
        }
        setPurchaseInvoiceList(invoiceList);
      }
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in getPurchaseInvoiceByMembership with membership'
            'id $membershipId',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      invoiceState = InvoiceStateDeprecated.error;
    }
  }

  /// Retrieves the detailed information of a specific additional benefit purchase
  /// by calling [_purchaseInvoiceRepository] getPurchaseInvoiceByMembership
  /// method.
  ///
  /// Stores the detail in [invoice] and establishes
  /// the [InvoiceStateDeprecated] accomplished if the request is successful.
  ///
  /// If the request is not successful it either sets [InvoiceStateDeprecated]
  /// in [invoiceState] as error, conflict, notFound or unexpectedError.
  ///
  Future<void> getAdditionalBenefitPurchaseInvoiceById(
      {required String membershipId, required String purchaseInvoiceId}) async {
    try {
      setInvoice(null);
      invoiceTicketState = InvoiceStateDeprecated.getting;
      final data = await _purchaseInvoiceRepository
          .getAdditionalBenefitPurchaseInvoiceRequested(
              membershipId: membershipId, purchaseInvoiceId: purchaseInvoiceId);

      if (data is InvoiceStateDeprecated) {
        invoiceTicketState = data;
      } else {
        setInvoice(InvoiceModel.fromJson(data));
        invoiceTicketState = InvoiceStateDeprecated.accomplished;
      }
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName:
            'Error in getAdditionalBenefitPurchaseInvoiceById whit membership'
            'id $membershipId, and purchaseInvoiceId'
            '$purchaseInvoiceId',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      invoiceTicketState = InvoiceStateDeprecated.error;
    }
  }

  /// Retrieves the detailed information of a specific package combo purchase
  /// by calling [_purchaseInvoiceRepository] getPurchaseInvoiceByMembership
  /// method.
  ///
  /// Stores the detail in [invoice] and establishes
  /// the [InvoiceStateDeprecated] accomplished if the request is successful.
  ///
  /// If the request is not successful it either sets [InvoiceStateDeprecated]
  /// in [invoiceState] as error, conflict, notFound or unexpectedError.
  ///
  Future<void> getPackageComboPurchaseInvoiceById(
      {required String membershipId, required String purchaseInvoiceId}) async {
    try {
      setInvoice(null);
      invoiceTicketState = InvoiceStateDeprecated.getting;
      final data =
          await _purchaseInvoiceRepository.getPackageComboPurchaseInvoiceById(
        membershipId: membershipId,
        purchaseInvoiceId: purchaseInvoiceId,
      );

      if (data is InvoiceStateDeprecated) {
        invoiceTicketState = data;
      } else {
        setInvoice(InvoiceModel.fromJson(data));
        invoiceTicketState = InvoiceStateDeprecated.accomplished;
      }
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName:
            'Error in getPackageComboPurchaseInvoiceById whit membership'
            'id $membershipId, and purchaseInvoiceId'
            '$purchaseInvoiceId',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      invoiceTicketState = InvoiceStateDeprecated.error;
    }
  }

  /// Retrieves the detailed information of a specific level purchase
  /// by calling [_purchaseInvoiceRepository] getPurchaseInvoiceByMembership
  /// method.
  ///
  /// Stores the detail in [invoice] and establishes
  /// the [InvoiceStateDeprecated] accomplished if the request is successful.
  ///
  /// If the request is not successful it either sets [InvoiceStateDeprecated]
  /// in [invoiceState] as error, conflict, notFound or unexpectedError.
  ///
  Future<void> getLevelPurchaseInvoiceById(
      {required String membershipId, required String purchaseInvoiceId}) async {
    try {
      setInvoice(null);
      invoiceTicketState = InvoiceStateDeprecated.getting;
      final data = await _purchaseInvoiceRepository.getLevelPurchaseInvoiceById(
          membershipId: membershipId, purchaseInvoiceId: purchaseInvoiceId);

      if (data is InvoiceStateDeprecated) {
        invoiceTicketState = data;
      } else {
        setInvoice(InvoiceModel.fromJson(data));
        invoiceTicketState = InvoiceStateDeprecated.accomplished;
      }
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in getLevelPurchaseInvoiceById whit membership'
            'id $membershipId, and purchaseInvoiceId'
            '$purchaseInvoiceId',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      invoiceTicketState = InvoiceStateDeprecated.error;
    }
  }

  /// Retrieves the detailed information of a specific plans purchase
  /// by calling [_purchaseInvoiceRepository] getPlanPurchaseInvoiceById
  /// method.
  ///
  /// Stores the detail in [invoice] and establishes
  /// the [InvoiceStateDeprecated] accomplished if the request is successful.
  ///
  /// If the request is not successful it either sets [InvoiceStateDeprecated]
  /// in [invoiceState] as error, conflict, notFound or unexpectedError.
  ///
  Future<void> getPlanPurchaseInvoiceById(
      {required String membershipId, required String purchaseInvoiceId}) async {
    try {
      setInvoice(null);
      invoiceTicketState = InvoiceStateDeprecated.getting;
      final data = await _purchaseInvoiceRepository.getPlanPurchaseInvoiceById(
          membershipId: membershipId, purchaseInvoiceId: purchaseInvoiceId);
      if (data is InvoiceStateDeprecated) {
        invoiceTicketState = data;
      } else {
        setInvoice(InvoiceModel.fromJson(data));
        invoiceTicketState = InvoiceStateDeprecated.accomplished;
      }
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in getPlanPurchaseInvoiceById whit membership'
            'id $membershipId, and purchaseInvoiceId'
            '$purchaseInvoiceId',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      invoiceTicketState = InvoiceStateDeprecated.notFound;
    }
  }
}
