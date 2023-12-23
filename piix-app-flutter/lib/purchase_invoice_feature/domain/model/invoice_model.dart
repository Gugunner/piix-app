import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:piix_mobile/extensions/date_extend_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/date_util.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/freezed_utils.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_date.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/product_model.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/user_quote_model.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_status_model.dart';
import 'package:piix_mobile/purchase_invoice_feature/utils/constants_deprecated/purchase_invoice_copies_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/utils/purchase_invoice_enums.dart';
import 'package:piix_mobile/purchase_invoice_feature/utils/product_type_enum_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/protected_quantity_model.dart';
import 'package:piix_mobile/store_feature/utils/payment_methods.dart';

part 'invoice_model.freezed.dart';
part 'invoice_model.g.dart';

///This stores all the information of purchase invoice
@Freezed(
    copyWith: true,
    fromJson: true,
    toJson: false,
    makeCollectionsUnmodifiable: false,
    unionKey: 'modelType')
class InvoiceModel with _$InvoiceModel {
  const InvoiceModel._();
  final yearInDays = const Duration(days: 365);
  factory InvoiceModel.purchased({
    @JsonKey(required: true) required String purchaseInvoiceId,
    @JsonKey(required: true) required String userId,
    @JsonKey(required: true) required String packageId,
    @JsonKey(required: true) required String paymentId,
    @JsonKey(required: true) required String paymentMethodId,
    @JsonKey(required: true) required String paymentMethodName,
    @JsonKey(required: true) required String paymentMethodReferenceId,
    @JsonKey(required: true, fromJson: fromPaymentStringStatus)
    required PaymentStatus paymentStatus,
    @JsonKey(
      required: true,
      name: 'controlStatus',
      fromJson: fromControlStringStatus,
    )
    required ProductStatus productStatus,
    @JsonKey(required: true) required DateTime registerDate,
    @JsonKey(required: true)
    required ProtectedQuantityModel protectedQuantityInCoverage,
    @JsonKey(required: true) required DateTime expirationDate,
    @JsonKey(required: true) required String beneficiaryName,
    @JsonKey(required: true, readValue: addPurchasedType)
    required UserQuoteModel userQuotation,
    @JsonKey(required: true, readValue: addPurchasedType)
    required ProductModel products,
    @JsonKey(required: true, fromJson: fromInvoiceStringStatus)
    required InvoiceStatusModel invoiceStatus,
    @Default('') String accountNumber,
    DateTime? updateDate,
    DateTime? approvedDate,
    @Default('') String barcode,
    @Default('') String barcodeType,
  }) = _InvoicePurchasedModel;

  factory InvoiceModel.detail({
    @JsonKey(required: true) required String purchaseInvoiceId,
    @JsonKey(required: true) required String userId,
    @JsonKey(required: true) required String packageId,
    @JsonKey(required: true) required String paymentId,
    @JsonKey(required: true) required String paymentMethodId,
    @JsonKey(required: true) required String paymentMethodName,
    @JsonKey(required: true) required String paymentMethodReferenceId,
    @JsonKey(required: true, fromJson: fromPaymentStringStatus)
    required PaymentStatus paymentStatus,
    @JsonKey(
      required: true,
      name: 'controlStatus',
      fromJson: fromControlStringStatus,
    )
    required ProductStatus productStatus,
    @JsonKey(required: true) required DateTime registerDate,
    @JsonKey(required: true)
    required ProtectedQuantityModel protectedQuantityInCoverage,
    @JsonKey(required: true) required DateTime expirationDate,
    @JsonKey(required: true) required String beneficiaryName,
    @JsonKey(required: true, readValue: addDetailType)
    required UserQuoteModel userQuotation,
    @JsonKey(required: true, readValue: addDetailType)
    required ProductModel products,
    @Default('') String accountNumber,
    DateTime? updateDate,
    DateTime? approvedDate,
    @JsonKey(required: true, fromJson: fromInvoiceStringStatus)
    required InvoiceStatusModel invoiceStatus,
    @Default('') String barcode,
    @Default('') String barcodeType,
  }) = _InvoiceDetailModel;

  factory InvoiceModel.payment({
    @JsonKey(required: true) required String purchaseInvoiceId,
    @JsonKey(required: true) required String userId,
    @JsonKey(required: true) required String packageId,
    @JsonKey(required: true) required String paymentId,
    @JsonKey(required: true) required String paymentMethodId,
    @JsonKey(required: true) required String paymentMethodName,
    @JsonKey(required: true) required String paymentMethodReferenceId,
    @JsonKey(required: true, fromJson: fromPaymentStringStatus)
    required PaymentStatus paymentStatus,
    @JsonKey(
      required: true,
      name: 'controlStatus',
      fromJson: fromControlStringStatus,
    )
    required ProductStatus productStatus,
    @JsonKey(required: true) required DateTime registerDate,
    @JsonKey(required: true)
    required ProtectedQuantityModel protectedQuantityInCoverage,
    @JsonKey(required: true) required DateTime expirationDate,
    @JsonKey(required: true) required String beneficiaryName,
    @JsonKey(required: true, readValue: addPaymentType)
    required UserQuoteModel userQuotation,
    @JsonKey(required: true, readValue: addPaymentType)
    required ProductModel products,
    @JsonKey(required: true, fromJson: fromInvoiceStringStatus)
    required InvoiceStatusModel invoiceStatus,
    DateTime? updateDate,
    @Default('') String accountNumber,
    @Default('') String barcode,
    @Default('') String barcodeType,
  }) = _InvoicePaymentModel;

  factory InvoiceModel.fromJson(Map<String, dynamic> json) =>
      _$InvoiceModelFromJson(json).setinvoiceStatusModel();

  @override
  String get purchaseInvoiceId => purchaseInvoiceId;

  @override
  String get userId => userId;

  @override
  String get packageId => packageId;

  @override
  String get paymentId => paymentId;

  @override
  String get paymentMethodId => paymentMethodId;

  @override
  String get paymentMethodName => paymentMethodName;

  @override
  String get paymentMethodReferenceId => paymentMethodReferenceId;

  @override
  PaymentStatus get paymentStatus => paymentStatus;

  @override
  ProductStatus get productStatus => productStatus;

  @override
  DateTime get registerDate => registerDate;

  @override
  ProtectedQuantityModel get protectedQuantityInCoverage => map(
        purchased: (value) => value.protectedQuantityInCoverage,
        detail: (value) => value.protectedQuantityInCoverage,
        payment: (value) => value.protectedQuantityInCoverage,
      );

  @override
  DateTime get expirationDate => expirationDate;

  @override
  String get beneficiaryName => beneficiaryName;

  @override
  UserQuoteModel get userQuotation => userQuotation;

  @override
  ProductModel get products => map(
        purchased: (value) => value.products,
        detail: (value) => value.products,
        payment: (value) => value.products,
      );

  @override
  String get accountNumber => accountNumber;

  @override
  DateTime? get updateDate => updateDate;

  DateTime? get approvedDate => mapOrNull(
        purchased: (value) => value.approvedDate,
        detail: (value) => value.approvedDate,
      );

  @override
  String get barcode => barcode;

  @override
  String get barcodeType => barcodeType;

  double get finalDiscount => maybeMap(
        purchased: (value) => value.userQuotation.finalDiscount,
        detail: (value) => value.userQuotation.finalDiscount,
        orElse: () => 0.0,
      );

  double get percentageFinalDiscount => finalDiscount * 100;

  int get protectedQuantity => map(
        purchased: (value) =>
            value.protectedQuantityInCoverage.protectedQuantity,
        detail: (value) => value.protectedQuantityInCoverage.protectedQuantity,
        payment: (value) => value.protectedQuantityInCoverage.protectedQuantity,
      );

  String get paymentPurchaseName => map(
        purchased: (value) => value.products.productName.removeLineBreak,
        detail: (value) => value.products.productName.removeLineBreak,
        payment: (value) => value.products.productName.removeLineBreak,
      );

  String get paymentPurchaseType =>
      userQuotation.productType.getTextOfPaymentByProductType;

  double get totalPremium => userQuotation.totalPremium;

  bool get isPaymentInvoice => maybeMap(
        payment: (_) => true,
        orElse: () => false,
      );

  bool get hasExpired => invoiceStatus.status == InvoiceStatus.expired;

  bool get isCancelable {
    return !hasExpired &&
        invoiceStatus.maybeMap(
          (value) => true,
          created: (_) => true,
          awaitingPayment: (_) => true,
          paymentInProcess: (_) => true,
          paid: (_) => true,
          awaitingFulfilment: (_) => true,
          orElse: () => false,
        );
  }

  bool get isPaid {
    return !hasExpired &&
        invoiceStatus.maybeMap(
          (value) => true,
          paid: (_) => true,
          awaitingFulfilment: (_) => true,
          fullfilled: (_) => true,
          orElse: () => false,
        );
  }

  String get validUntil {
    if (approvedDate == null) return '';
    final toDate = approvedDate!.add(yearInDays);
    return PurchaseInvoiceCopiesDeprecated.validityFromTo(
      approvedDate!.dateFormat!,
      toDate.dateFormat!,
    );
  }
}

extension MutableInvoiceModel on InvoiceModel {
  InvoiceModel setProducts(ProductModel products) => map(
        purchased: (value) => value.copyWith(
          products: products,
        ),
        detail: (value) => value.copyWith(
          products: products,
        ),
        payment: (value) => value.copyWith(
          products: products,
        ),
      );

  InvoiceModel setMissingPaymentInfo({
    required double finalDiscount,
    required String paymentMethodName,
    required String paymentPurchaseName,
    required int protectedQuantity,
  }) =>
      maybeMap(
        payment: (value) => value.copyWith(
          paymentMethodName: paymentMethodName,
        ),
        orElse: () => this,
      );

  InvoiceModel setinvoiceStatusModel() {
    return map(
      purchased: (value) => value.copyWith(invoiceStatus: invoiceStatus),
      detail: (value) => value.copyWith(invoiceStatus: invoiceStatus),
      payment: (value) => value.copyWith(invoiceStatus: invoiceStatus),
    );
  }
}

extension InvoiceModelExtend on InvoiceModel {
  List<InvoiceDate> get invoiceDates {
    final orderDate = InvoiceDate(
      name: PurchaseInvoiceCopiesDeprecated.orderDate,
      date: registerDate,
    );
    final paymentDate = InvoiceDate(
      name: PurchaseInvoiceCopiesDeprecated.paymentDate,
      date: approvedDate,
    );
    final canceledDate = InvoiceDate(
      name: PurchaseInvoiceCopiesDeprecated.canceledDate,
      date: updateDate,
    );
    final expiredDate = InvoiceDate(
      name: PurchaseInvoiceCopiesDeprecated.expiredDate,
      date: expirationDate,
    );
    final rejectedDate = InvoiceDate(
      name: PurchaseInvoiceCopiesDeprecated.rejectedDate,
      date: updateDate,
    );
    final refundedDate = InvoiceDate(
      name: PurchaseInvoiceCopiesDeprecated.refundedDate,
      date: updateDate,
    );
    final currentUpdate = InvoiceDate(
      name: PurchaseInvoiceCopiesDeprecated.updateDate,
      date: updateDate,
    );

    return invoiceStatus.map(
      (value) => [
        InvoiceDate(
          name: PurchaseInvoiceCopiesDeprecated.updateDate,
          date: DateTime.now(),
        ),
      ],
      created: (_) => [orderDate],
      awaitingPayment: (_) =>
          [orderDate, if (updateDate != null) currentUpdate],
      expired: (_) => [orderDate, expiredDate],
      bounced: (_) => [orderDate, rejectedDate],
      paymentInProcess: (_) =>
          [orderDate, if (updateDate != null) currentUpdate],
      canceled: (_) => [orderDate, if (updateDate != null) canceledDate],
      paymentInMediation: (_) => [
        orderDate,
        if (approvedDate != null) paymentDate,
        if (updateDate != null) currentUpdate
      ],
      refunded: (_) => [
        orderDate,
        if (approvedDate != null) paymentDate,
        if (updateDate != null) refundedDate
      ],
      paid: (_) => [
        orderDate,
        if (approvedDate != null) paymentDate,
      ],
      awaitingFulfilment: (_) => [
        orderDate,
        if (approvedDate != null) paymentDate,
        if (updateDate != null) currentUpdate
      ],
      fullfilled: (_) {
        final endDate = InvoiceDate(
          name: PurchaseInvoiceCopiesDeprecated.endDate,
          date: _endDate,
        );
        final activatedDate = InvoiceDate(
          name: PurchaseInvoiceCopiesDeprecated.activatedDate,
          date: updateDate,
        );
        return [
          orderDate,
          if (approvedDate != null) paymentDate,
          if (_endDate != null)
            endDate
          else if (updateDate != null)
            activatedDate,
        ];
      },
    );
  }

  String get productTextStatus {
    return invoiceStatus.map((_) => PiixCopiesDeprecated.noProduct,
        created: (_) => PiixCopiesDeprecated.pendingProduct,
        awaitingPayment: (_) => PiixCopiesDeprecated.pendingProduct,
        expired: (_) => PiixCopiesDeprecated.canceledProduct,
        bounced: (_) => PiixCopiesDeprecated.canceledProduct,
        paymentInProcess: (_) => PiixCopiesDeprecated.pendingProduct,
        canceled: (_) => PiixCopiesDeprecated.canceledProduct,
        paymentInMediation: (_) => PiixCopiesDeprecated.noProduct,
        refunded: (_) => PiixCopiesDeprecated.canceledProduct,
        paid: (_) => PiixCopiesDeprecated.activatingProduct,
        awaitingFulfilment: (_) => PiixCopiesDeprecated.activatingProduct,
        fullfilled: (_) {
          if (_endDate != null) {
            return PiixCopiesDeprecated.inactiveProduct;
          }
          return PiixCopiesDeprecated.activeProduct;
        });
  }

  String get paymentDetailInvoiceTextDescription => invoiceStatus.map(
        (_) => '',
        created: (_) => PurchaseInvoiceCopiesDeprecated.orderCreatedDescription,
        awaitingPayment: (_) =>
            '${PurchaseInvoiceCopiesDeprecated.pendingPaymentDescription} '
            '${expirationDate.dateFormatWhithMonth}.',
        expired: (_) =>
            PurchaseInvoiceCopiesDeprecated.expiredPaymentDescription,
        bounced: (_) =>
            PurchaseInvoiceCopiesDeprecated.rejectedPaymentDescription,
        paymentInProcess: (_) =>
            PurchaseInvoiceCopiesDeprecated.paymentInProcessDescription,
        canceled: (_) =>
            PurchaseInvoiceCopiesDeprecated.canceledPaymentDescription,
        paymentInMediation: (_) =>
            PurchaseInvoiceCopiesDeprecated.paymentInMediationDescription,
        refunded: (_) =>
            PurchaseInvoiceCopiesDeprecated.refundedPaymentDescription,
        paid: (_) => PurchaseInvoiceCopiesDeprecated.paidPaymentDescription,
        awaitingFulfilment: (_) =>
            PurchaseInvoiceCopiesDeprecated.paidPaymentDescription,
        fullfilled: (_) {
          if (_endDate != null)
            return PurchaseInvoiceCopiesDeprecated.endOfValidityDescription;
          return PurchaseInvoiceCopiesDeprecated.paidPaymentDescription;
        },
      );

  String get gratitudeText => invoiceStatus.map(
        (_) => PurchaseInvoiceCopiesDeprecated.thanksForChoosingUs,
        created: (_) => PurchaseInvoiceCopiesDeprecated.thanksForChoosingUs,
        awaitingPayment: (_) =>
            PurchaseInvoiceCopiesDeprecated.thanksForChoosingUs,
        expired: (_) => PurchaseInvoiceCopiesDeprecated.thanksForChoosingUs,
        bounced: (_) => PurchaseInvoiceCopiesDeprecated.thanksForTrustingUs,
        paymentInProcess: (_) =>
            PurchaseInvoiceCopiesDeprecated.thanksForChoosingUs,
        canceled: (_) => PurchaseInvoiceCopiesDeprecated.thanksForTrustingUs,
        paymentInMediation: (_) =>
            PurchaseInvoiceCopiesDeprecated.thanksForChoosingUs,
        refunded: (_) => PurchaseInvoiceCopiesDeprecated.thanksForTrustingPiix,
        paid: (_) => PurchaseInvoiceCopiesDeprecated.thanksForTrustingPiix,
        awaitingFulfilment: (_) =>
            PurchaseInvoiceCopiesDeprecated.thanksForTrustingPiix,
        fullfilled: (_) =>
            PurchaseInvoiceCopiesDeprecated.thanksForTrustingPiix,
      );

  String get paymentDetailInstructions {
    return invoiceStatus.map(
      (_) => '',
      created: (_) => PurchaseInvoiceCopiesDeprecated.orderCreatedDescription,
      awaitingPayment: (_) =>
          '${PurchaseInvoiceCopiesDeprecated.pendingPaymentDescription} '
          '${expirationDate.dateFormatWhithMonth}.',
      expired: (_) => PurchaseInvoiceCopiesDeprecated.expiredPaymentDescription,
      bounced: (_) =>
          PurchaseInvoiceCopiesDeprecated.rejectedPaymentDescription,
      paymentInProcess: (_) =>
          PurchaseInvoiceCopiesDeprecated.paymentInProcessDescription,
      canceled: (_) =>
          PurchaseInvoiceCopiesDeprecated.canceledPaymentDescription,
      paymentInMediation: (_) =>
          PurchaseInvoiceCopiesDeprecated.paymentInMediationDescription,
      refunded: (_) =>
          PurchaseInvoiceCopiesDeprecated.refundedPaymentDescription,
      paid: (_) => PurchaseInvoiceCopiesDeprecated.paidPaymentDescription,
      awaitingFulfilment: (_) =>
          PurchaseInvoiceCopiesDeprecated.paidPaymentDescription,
      fullfilled: (_) => PurchaseInvoiceCopiesDeprecated.paidPaymentDescription,
    );
  }

  String get coverageNextStepText {
    final productType = userQuotation.productType;
    var name =
        '${PiixCopiesDeprecated.the} ${productType.label}:'.toLowerCase();
    if (productType == ProductTypeDeprecated.NONE ||
        productType == ProductTypeDeprecated.PLAN) {
      name = '';
    }
    return invoiceStatus.map(
      (_) => '',
      created: (_) =>
          PurchaseInvoiceCopiesDeprecated.goingToImproveCoverageWith(name),
      awaitingPayment: (_) =>
          PurchaseInvoiceCopiesDeprecated.goingToImproveCoverageWith(name),
      expired: (_) =>
          PurchaseInvoiceCopiesDeprecated.stillImproveCoverageWith(name),
      bounced: (_) => name,
      paymentInProcess: (_) =>
          PurchaseInvoiceCopiesDeprecated.goingToImproveCoverageWith(name),
      canceled: (_) => name,
      paymentInMediation: (_) =>
          PurchaseInvoiceCopiesDeprecated.goingToImproveCoverageWith(name),
      refunded: (_) =>
          PurchaseInvoiceCopiesDeprecated.refundedPaymentDescription,
      paid: (_) =>
          PurchaseInvoiceCopiesDeprecated.haveImprovedCoverageWith(name),
      awaitingFulfilment: (_) =>
          PurchaseInvoiceCopiesDeprecated.haveImprovedCoverageWith(name),
      fullfilled: (_) =>
          PurchaseInvoiceCopiesDeprecated.haveImprovedCoverageWith(name),
    );
  }

  String get instructionText {
    final productType = userQuotation.productType;
    final name = productType.label.toLowerCase();
    return invoiceStatus.maybeMap(
      (_) => '',
      created: (_) =>
          PurchaseInvoiceCopiesDeprecated.makePaymentWithPaymentLine,
      awaitingPayment: (_) =>
          PurchaseInvoiceCopiesDeprecated.makePaymentWithPaymentLine,
      expired: (_) => PurchaseInvoiceCopiesDeprecated.remakePaymentPaymentLine,
      bounced: (_) =>
          PurchaseInvoiceCopiesDeprecated.interestedInAcquiredModule(name),
      canceled: (_) =>
          PurchaseInvoiceCopiesDeprecated.interestedInAcquiredModule(name),
      refunded: (_) =>
          PurchaseInvoiceCopiesDeprecated.refundMoneyFromModule(name),
      orElse: () => '',
    );
  }

  Color colorBy(InvoiceElementDeprecated element) => invoiceStatus.map(
        (_) => PiixColors.process,
        created: (_) {
          switch (element) {
            case InvoiceElementDeprecated.tag:
              return PiixColors.process;
            case InvoiceElementDeprecated.payment:
              return PiixColors.process;
            case InvoiceElementDeprecated.header:
              return PiixColors.process;
          }
        },
        awaitingPayment: (_) => PiixColors.process,
        expired: (_) {
          switch (element) {
            case InvoiceElementDeprecated.tag:
            case InvoiceElementDeprecated.header:
              return PiixColors.alert;
            case InvoiceElementDeprecated.payment:
              return PiixColors.error;
          }
        },
        bounced: (_) {
          switch (element) {
            case InvoiceElementDeprecated.tag:
            case InvoiceElementDeprecated.header:
              return PiixColors.alert;
            case InvoiceElementDeprecated.payment:
              return PiixColors.error;
          }
        },
        paymentInProcess: (_) {
          switch (element) {
            case InvoiceElementDeprecated.tag:
            case InvoiceElementDeprecated.header:
              return PiixColors.shine;
            case InvoiceElementDeprecated.payment:
              return PiixColors.process;
          }
        },
        canceled: (_) {
          switch (element) {
            case InvoiceElementDeprecated.tag:
            case InvoiceElementDeprecated.header:
              return PiixColors.alert;
            case InvoiceElementDeprecated.payment:
              return PiixColors.error;
          }
        },
        paymentInMediation: (_) {
          switch (element) {
            case InvoiceElementDeprecated.tag:
              return PiixColors.shine;
            case InvoiceElementDeprecated.payment:
              return PiixColors.process;
            case InvoiceElementDeprecated.header:
              return PiixColors.cloud;
          }
        },
        refunded: (_) {
          switch (element) {
            case InvoiceElementDeprecated.tag:
              return PiixColors.secondaryLight;
            case InvoiceElementDeprecated.payment:
              return PiixColors.error;
            case InvoiceElementDeprecated.header:
              return PiixColors.cloud;
          }
        },
        paid: (_) {
          switch (element) {
            case InvoiceElementDeprecated.tag:
            case InvoiceElementDeprecated.header:
              return PiixColors.success;
            case InvoiceElementDeprecated.payment:
              return PiixColors.warning;
          }
        },
        awaitingFulfilment: (_) {
          switch (element) {
            case InvoiceElementDeprecated.tag:
            case InvoiceElementDeprecated.header:
              return PiixColors.success;
            case InvoiceElementDeprecated.payment:
              return PiixColors.warning;
          }
        },
        fullfilled: (_) {
          if (_endDate != null) {
            switch (element) {
              case InvoiceElementDeprecated.tag:
                return PiixColors.success;
              case InvoiceElementDeprecated.payment:
                return PiixColors.secondary;
              case InvoiceElementDeprecated.header:
                return PiixColors.alert;
            }
          }
          return PiixColors.success;
        },
      );

  String get paymentDetailInvoiceTextTitle => invoiceStatus.map((_) => '',
      created: (_) => PurchaseInvoiceCopiesDeprecated.orderCreatedTitle,
      awaitingPayment: (_) =>
          PurchaseInvoiceCopiesDeprecated.pendingPaymentTitle,
      expired: (_) => PurchaseInvoiceCopiesDeprecated.expiredPaymentTitle,
      bounced: (_) => PurchaseInvoiceCopiesDeprecated.rejectedPaymentTitle,
      paymentInProcess: (_) =>
          PurchaseInvoiceCopiesDeprecated.paymentInProcessTitle,
      canceled: (_) => PurchaseInvoiceCopiesDeprecated.canceledPaymentTitle,
      paymentInMediation: (_) =>
          PurchaseInvoiceCopiesDeprecated.paymentInMediationTitle,
      refunded: (_) => PurchaseInvoiceCopiesDeprecated.refundedPaymentTitle,
      paid: (_) => PurchaseInvoiceCopiesDeprecated.paidPaymentTitle,
      awaitingFulfilment: (_) =>
          PurchaseInvoiceCopiesDeprecated.paidPaymentTitle,
      fullfilled: (_) {
        if (_endDate != null)
          return PurchaseInvoiceCopiesDeprecated.endOfValidityTitle;
        return PurchaseInvoiceCopiesDeprecated.paidPaymentTitle;
      });

  String get productTag => invoiceStatus.map(
        (_) => PurchaseInvoiceCopiesDeprecated.pendingLabel,
        created: (_) => PurchaseInvoiceCopiesDeprecated.pendingLabel,
        awaitingPayment: (_) => PurchaseInvoiceCopiesDeprecated.pendingLabel,
        expired: (_) => PurchaseInvoiceCopiesDeprecated.expiredLabel,
        bounced: (_) => PurchaseInvoiceCopiesDeprecated.declinedLabel,
        paymentInProcess: (_) => PurchaseInvoiceCopiesDeprecated.processedLabel,
        canceled: (_) => PurchaseInvoiceCopiesDeprecated.cancelLabel,
        paymentInMediation: (_) =>
            PurchaseInvoiceCopiesDeprecated.mediationLabel,
        refunded: (_) => PurchaseInvoiceCopiesDeprecated.refundedLabel,
        paid: (_) => PurchaseInvoiceCopiesDeprecated.paidLabel,
        awaitingFulfilment: (_) => PurchaseInvoiceCopiesDeprecated.paidLabel,
        fullfilled: (_) => PurchaseInvoiceCopiesDeprecated.paidLabel,
      );

  IconData get productStatusIcon => invoiceStatus.map(
        (value) => Icons.help,
        created: (_) => Icons.cancel,
        awaitingPayment: (_) => Icons.cancel,
        expired: (_) => Icons.cancel,
        bounced: (_) => Icons.cancel,
        paymentInProcess: (_) => Icons.cancel,
        canceled: (_) => Icons.cancel,
        paymentInMediation: (_) => Icons.cancel,
        refunded: (_) => Icons.cancel,
        paid: (_) => Icons.check_circle,
        awaitingFulfilment: (_) => Icons.check_circle,
        fullfilled: (_) {
          if (_endDate != null) return Icons.cancel;
          return Icons.check_circle;
        },
      );

  String get productStatusText => invoiceStatus.map(
        (value) => '',
        created: (_) => 'por activar',
        awaitingPayment: (_) => 'por activar',
        expired: (_) => 'expirado',
        bounced: (_) => 'cancelado',
        paymentInProcess: (_) => 'por activar',
        canceled: (_) => 'cancelado',
        paymentInMediation: (_) => 'por activar',
        refunded: (_) => 'cancelado',
        paid: (_) => 'en proceso de activación',
        awaitingFulfilment: (_) => 'en proceso de activación',
        fullfilled: (_) => productStatus.activeText,
      );

  String get productAdditionalStatusText => invoiceStatus.map(
        (value) => '',
        created: (_) => 'Se necesita realizar el pago para activarlo.',
        awaitingPayment: (_) => 'Se necesita realizar el pago para activarlo.',
        expired: (_) => 'La vigencia de la línea de captura ha terminado.',
        bounced: (_) => 'El pago ha sido declinado y el ticket '
            'se ha cancelado.',
        paymentInProcess: (_) => 'Se necesita procesar el pago para activarlo.',
        canceled: (_) => 'La compra ha sido cancelada y el ticket '
            'se ha cancelado.',
        paymentInMediation: (_) => 'Se ha iniciado un proceso de contracargo.',
        refunded: (_) => 'Se ha reembolsado el pago exitósamente.',
        paid: (_) => '',
        awaitingFulfilment: (_) => '',
        fullfilled: (_) => '',
      );

  String get productYearStatusText => invoiceStatus.map(
        (_) => '',
        created: (_) => PiixCopiesDeprecated.oneYearAfterActivate,
        awaitingPayment: (_) => PiixCopiesDeprecated.oneYearAfterActivate,
        expired: (_) => '',
        bounced: (_) => '',
        paymentInProcess: (_) => PiixCopiesDeprecated.oneYearAfterActivate,
        canceled: (_) => '',
        paymentInMediation: (_) => '',
        refunded: (_) => '',
        paid: (_) => PiixCopiesDeprecated.oneYearAfterActivate,
        awaitingFulfilment: (_) => PiixCopiesDeprecated.oneYearAfterActivate,
        fullfilled: (_) {
          final formatter = DateFormat('dd/MM/yyyy');
          var text = 'Vigencia del ';
          if (_endDate == null) return '';
          text += formatter.format(approvedDate!.toLocal());
          text += ' al ';
          text += formatter.format(_endDate!.toLocal());
          return text;
        },
      );

  DateTime? get _endDate {
    if (approvedDate == null) return null;
    final aYearPassed = dateAfterXTime(
      date: approvedDate!,
      xTime: yearInDays,
    );
    if (!aYearPassed) return null;
    return approvedDate!.add(yearInDays);
  }
}

@Deprecated('Will be removed in 4.0')
enum InvoiceElementDeprecated {
  tag,
  payment,
  header,
}
