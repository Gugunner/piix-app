import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/membership_benefits_feature/domain/model/benefit_model.dart';
import 'package:piix_mobile/membership_benefits_feature/domain/model/benefit_type_model.dart';
import 'package:piix_mobile/membership_benefits_feature/domain/model/supplier_model.dart';
import 'package:piix_mobile/file_feature/domain/model/file_content_model.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/freezed_utils.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/model/ticket_model.dart';
import 'package:piix_mobile/store_feature/domain/model/current_quote_plans_model/current_quote_price_plans_model.dart';
import 'package:piix_mobile/store_feature/domain/model/intermediary_fee_model.dart';
import 'package:piix_mobile/store_feature/domain/model/pending_purchases_of_combo_model.dart';
import 'package:piix_mobile/store_feature/domain/model/product_rates_model.dart';

part 'benefit_per_supplier_model_deprecated.freezed.dart';
part 'benefit_per_supplier_model_deprecated.g.dart';

@Deprecated('Will be removed in 4.0')

///This class contains all benefit per supplier information.
@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType',
)
class BenefitPerSupplierModel with _$BenefitPerSupplierModel {
  @JsonSerializable(explicitToJson: true)
  const BenefitPerSupplierModel._();
  factory BenefitPerSupplierModel({
    @JsonKey(required: true) required String benefitPerSupplierId,
    @JsonKey(required: true) required BenefitModel benefit,
    @JsonKey(required: true) required BenefitTypeModel benefitType,
    @JsonKey(required: true) required String wordingZero,
    @Default(false) bool requiresAgeCompliance,
    @Default(false) bool hasBenefitForm,
    @Default(false) bool needsBenefitFormSignature,
    @Default(false) bool userHasAlreadySignedTheBenefitForm,
    @Default(false) bool hasCobenefits,
    @Default('') String benefitFormId,
    @Default('') String wordingOne,
    @Default('') String wordingTwo,
  }) = _BenefitPerSupplierModel;

  factory BenefitPerSupplierModel.detail({
    @JsonKey(required: true) required String benefitPerSupplierId,
    @JsonKey(required: true) required BenefitModel benefit,
    @JsonKey(required: true) required BenefitTypeModel benefitType,
    @JsonKey(required: true) required String wordingZero,
    @JsonKey(required: true) required SupplierModel supplier,
    @Default(false) bool requiresAgeCompliance,
    @Default(false) bool hasBenefitForm,
    @Default(false) bool needsBenefitFormSignature,
    @Default(false) bool userHasAlreadySignedTheBenefitForm,
    @Default(false) bool hasCobenefits,
    @JsonKey(readValue: addCobenefitType)
    @Default([])
    List<BenefitPerSupplierModel> cobenefitsPerSupplier,
    @Default('') String benefitFormId,
    @Default('') String wordingOne,
    @Default('') String wordingTwo,
    @Default('') String benefitImage,
    @Default('') String benefitImageMemory,
    @Default('') String pdfWording,
    FileContentModel? pdfWordingMemory,
    TicketModel? ticket,
  }) = _BenefitPerSupplierDetailModel;

  factory BenefitPerSupplierModel.cobenefit({
    @JsonKey(required: true) required String coverageOfferType,
    @JsonKey(
      required: true,
      name: 'cobenefitPerSupplierId',
    )
    required String benefitPerSupplierId,
    @JsonKey(required: true) required BenefitModel benefit,
    @JsonKey(required: true) required BenefitTypeModel benefitType,
    @JsonKey(required: true) required String wordingZero,
    @JsonKey(required: true) required SupplierModel supplier,
    @Default(0) double coverageOfferValue,
    @Default(false) bool needsBenefitFormSignature,
    @Default(false) bool requiresAgeCompliance,
    @Default(false) bool hasBenefitForm,
    @Default(false) bool userHasAlreadySignedTheBenefitForm,
    @Default('') String benefitFormId,
    @Default('') String wordingOne,
    @Default('') String wordingTwo,
    @Default('') String benefitImage,
    @Default('') String benefitImageMemory,
    @Default('') String pdfWording,
    FileContentModel? pdfWordingMemory,
    TicketModel? ticket,
  }) = _CobenefitPerSupplierModel;

  factory BenefitPerSupplierModel.additional({
    @JsonKey(
      required: true,
      name: 'additionalBenefitPerSupplierId',
    )
    required String benefitPerSupplierId,
    @JsonKey(required: true) required String folio,
    @JsonKey(required: true) required BenefitTypeModel benefitType,
    @JsonKey(required: true) required BenefitModel benefit,
    @JsonKey(required: true) required SupplierModel supplier,
    @Default('') String benefitImage,
    @JsonKey(required: true) required String wordingZero,
    @Default('') String pdfWording,
    @Default(false) bool hasBenefitForm,
    @Default(false) bool userHasAlreadySignedTheBenefitForm,
    @Default(false) bool needsBenefitFormSignature,
    //Store properties
    @Default(false) bool isPartiallyAcquired,
    @Default(false) bool hasPendingInvoice,
    @Default(false) bool pendingPurchaseForSameProduct,
    List<PendingPurchasesOfComboModel>? pendingPurchasesOfCombo,
    @Default('') String userQuotationId,
    @Default(false) bool requiresAgeCompliance,
    @Default(false) bool isAlreadyAcquired,
    @Default(0.0) double coverageOfferValue,
    @Default('') String coverageOfferType,
    ProductRatesModel? productRates,
    List<IntermediaryFeeModel>? intermediariesFees,
    DateTime? quotationRegisterDate,
    @Default(0.0) double newCoverageOfferValue,
    @Default(0.0) double oldCoverageOfferValue,
    @JsonKey(name: 'plansForCurrentQuotation')
    CurrentQuotePricePlansModel? currentQuotePricePlans,
    //Properties when user acquires benefit
    @Default('') String wordingOne,
    @Default('') String wordingTwo,
    @Default('') String benefitImageMemory,
    FileContentModel? pdfWordingMemory,
  }) = _AdditionalBenefitPerSupplierModel;

  factory BenefitPerSupplierModel.purchased({
    //The following properties are universal
    //in all the instances of this model
    @JsonKey(
      required: true,
      name: 'additionalBenefitPerSupplierId',
    )
    required String benefitPerSupplierId,
    @JsonKey(required: true) required String folio,
    @JsonKey(required: true) required BenefitModel benefit,
    @JsonKey(required: true) required SupplierModel supplier,
    @Default('') String benefitImage,
    @JsonKey(required: true) required String wordingZero,
    @Default('') String pdfWording,
    @Default(false) bool hasBenefitForm,
    @Default(false) bool userHasAlreadySignedTheBenefitForm,
    @Default(false) bool needsBenefitFormSignature,
    @Default('') String benefitImageMemory,
    FileContentModel? pdfWordingMemory,
    @JsonKey(required: false) BenefitTypeModel? benefitType,
    @Default('') String benefitFormId,
    @Default(false) bool fromStore,
  }) = _AdditionalBenefitPerSupplierPurchasedModel;

  factory BenefitPerSupplierModel.level({
    @JsonKey(required: true) required String benefitPerSupplierId,
    @JsonKey(required: true) required String wordingZero,
    @JsonKey(required: true) required BenefitModel benefit,
    @JsonKey(required: true) required BenefitTypeModel benefitType,
    @JsonKey(required: true) required SupplierModel supplier,
    @JsonKey(required: true) required String coverageOfferType,
    @Default(false) bool hasCobenefits,
    @Default(0.0) double coverageOfferValue,
    @Default('') String benefitFormId,
    @Default(false) bool requiresAgeCompliance,
    @Default('') String benefitImage,
    @Default('') String benefitImageMemory,
    @Default('') String pdfWording,
    FileContentModel? pdfWordingMemory,
    @Default(false) bool hasBenefitForm,
    @Default(false) bool needsBenefitFormSignature,
    @Default(false) bool userHasAlreadySignedTheBenefitForm,
    @JsonKey(readValue: addCobenefitType)
    @Default([])
    List<BenefitPerSupplierModel> cobenefitsPerSupplier,
  }) = _BenefitPerSupplierLevelModel;

  factory BenefitPerSupplierModel.fromJson(Map<String, dynamic> json) =>
      _$BenefitPerSupplierModelFromJson(json);

  @override
  String get benefitPerSupplierId => maybeMap(
        (value) => value.benefitPerSupplierId,
        detail: (value) => value.benefitPerSupplierId,
        cobenefit: (value) => value.benefitPerSupplierId,
        additional: (value) => value.benefitPerSupplierId,
        purchased: (value) => value.benefitPerSupplierId,
        level: (value) => value.benefitPerSupplierId,
        orElse: () => '',
      );

  @override
  BenefitModel get benefit => map(
        (value) => value.benefit,
        detail: (value) => value.benefit,
        cobenefit: (value) => value.benefit,
        additional: (value) => value.benefit,
        purchased: (value) => value.benefit,
        level: (value) => value.benefit,
      );

  String get benefitName => map(
        (value) => value.benefit.name,
        detail: (value) => value.benefit.name,
        cobenefit: (value) => value.benefit.name,
        additional: (value) => value.benefit.name,
        purchased: (value) => value.benefit.name,
        level: (value) => value.benefit.name,
      );

  @override
  String get wordingZero => map(
        (value) => value.wordingZero,
        detail: (value) => value.wordingZero,
        cobenefit: (value) => value.wordingZero,
        additional: (value) => value.wordingZero,
        purchased: (value) => value.wordingZero,
        level: (value) => value.wordingZero,
      );

  bool get requiresAgeCompliance => maybeMap(
        (value) => value.requiresAgeCompliance,
        detail: (value) => value.requiresAgeCompliance,
        cobenefit: (value) => value.requiresAgeCompliance,
        additional: (value) => value.requiresAgeCompliance,
        level: (value) => value.requiresAgeCompliance,
        orElse: () => false,
      );

  @override
  bool get hasBenefitForm => map(
        (value) => value.hasBenefitForm,
        detail: (value) => value.hasBenefitForm,
        cobenefit: (value) => value.hasBenefitForm,
        additional: (value) => value.hasBenefitForm,
        purchased: (value) => value.hasBenefitForm,
        level: (value) => value.hasBenefitForm,
      );

  @override
  bool get needsBenefitFormSignature => map(
        (value) => value.needsBenefitFormSignature,
        detail: (value) => value.needsBenefitFormSignature,
        cobenefit: (value) => value.needsBenefitFormSignature,
        additional: (value) => value.needsBenefitFormSignature,
        purchased: (value) => value.needsBenefitFormSignature,
        level: (value) => value.needsBenefitFormSignature,
      );

  @override
  bool get userHasAlreadySignedTheBenefitForm => map(
        (value) => value.userHasAlreadySignedTheBenefitForm,
        detail: (value) => value.userHasAlreadySignedTheBenefitForm,
        cobenefit: (value) => value.userHasAlreadySignedTheBenefitForm,
        additional: (value) => value.userHasAlreadySignedTheBenefitForm,
        purchased: (value) => value.userHasAlreadySignedTheBenefitForm,
        level: (value) => value.userHasAlreadySignedTheBenefitForm,
      );

  bool get hasCobenefits => maybeMap(
        (value) => value.hasCobenefits,
        detail: (value) => value.hasCobenefits,
        level: (value) => value.hasCobenefits,
        orElse: () => false,
      );

  @override
  BenefitTypeModel? get benefitType => mapOrNull(
        (value) => value.benefitType,
        detail: (value) => value.benefitType,
        cobenefit: (value) => value.benefitType,
        additional: (value) => value.benefitType,
        purchased: (value) => value.benefitType,
        level: (value) => value.benefitType,
      );

  List<BenefitPerSupplierModel> get cobenefitsPerSupplier => maybeMap(
        (value) => [],
        detail: (value) => value.cobenefitsPerSupplier,
        level: (value) => value.cobenefitsPerSupplier,
        orElse: () => [],
      );

  String get benefitFormId => maybeMap(
        (value) => value.benefitFormId,
        detail: (value) => value.benefitFormId,
        cobenefit: (value) => value.benefitFormId,
        purchased: (value) => value.benefitFormId,
        level: (value) => value.benefitFormId,
        orElse: () => '',
      );

  String get wordingOne => maybeMap(
        (value) => value.wordingOne,
        detail: (value) => value.wordingOne,
        cobenefit: (value) => value.wordingOne,
        additional: (value) => value.wordingOne,
        orElse: () => '',
      );

  String get wordingTwo => maybeMap(
        (value) => value.wordingTwo,
        detail: (value) => value.wordingTwo,
        cobenefit: (value) => value.wordingTwo,
        additional: (value) => value.wordingTwo,
        orElse: () => '',
      );

  SupplierModel? get supplier => mapOrNull(
        (value) => null,
        detail: (value) => value.supplier,
        cobenefit: (value) => value.supplier,
        additional: (value) => value.supplier,
        purchased: (value) => value.supplier,
        level: (value) => value.supplier,
      );

  String get supplierId => maybeMap((value) => '',
      detail: (value) => value.supplier.supplierId,
      cobenefit: (value) => value.supplier.supplierId,
      additional: (value) => value.supplier.supplierId,
      purchased: (value) => value.supplier.supplierId,
      level: (value) => value.supplier.supplierId,
      orElse: () => '');

  String get supplierName => maybeMap((value) => '',
      detail: (value) => value.supplier.name,
      cobenefit: (value) => value.supplier.name,
      additional: (value) => value.supplier.name,
      purchased: (value) => value.supplier.name,
      level: (value) => value.supplier.name,
      orElse: () => '');

  String get benefitImage => maybeMap(
        (value) => '',
        detail: (value) => value.benefitImage,
        cobenefit: (value) => value.benefitImage,
        additional: (value) => value.benefitImage,
        purchased: (value) => value.benefitImage,
        level: (value) => value.benefitImage,
        orElse: () => '',
      );

  String get benefitImageMemory => maybeMap(
        (value) => '',
        detail: (value) => value.benefitImageMemory,
        cobenefit: (value) => value.benefitImageMemory,
        additional: (value) => value.benefitImageMemory,
        purchased: (value) => value.benefitImageMemory,
        level: (value) => value.benefitImageMemory,
        orElse: () => '',
      );

  String get pdfWording => maybeMap(
        (value) => '',
        detail: (value) => value.pdfWording,
        cobenefit: (value) => value.pdfWording,
        additional: (value) => value.pdfWording,
        purchased: (value) => value.pdfWording,
        level: (value) => value.pdfWording,
        orElse: () => '',
      );

  FileContentModel? get pdfWordingMemory => mapOrNull(
        (value) => null,
        detail: (value) => value.pdfWordingMemory,
        cobenefit: (value) => value.pdfWordingMemory,
        additional: (value) => value.pdfWordingMemory,
        purchased: (value) => value.pdfWordingMemory,
        level: (value) => value.pdfWordingMemory,
      );

  TicketModel? get ticket => mapOrNull(
        (value) => null,
        detail: (value) => value.ticket,
        cobenefit: (value) => value.ticket,
      );

  double get coverageOfferValue => maybeMap(
        (value) => 0.0,
        cobenefit: (value) => value.coverageOfferValue,
        additional: (value) => value.coverageOfferValue,
        level: (value) => value.coverageOfferValue,
        orElse: () => 0.0,
      );

  String get folio => maybeMap(
        (value) => '',
        additional: (value) => value.folio,
        purchased: (value) => value.folio,
        orElse: () => '',
      );

  bool get hasPendingInvoice => maybeMap(
        (value) => false,
        additional: (value) => value.hasPendingInvoice,
        orElse: () => false,
      );

  bool get pendingPurchaseForSameProduct => maybeMap(
        (value) => false,
        additional: (value) => value.pendingPurchaseForSameProduct,
        orElse: () => false,
      );

  List<PendingPurchasesOfComboModel>? get pendingPurchasesOfCombo => maybeMap(
        (value) => [],
        additional: (value) => value.pendingPurchasesOfCombo,
        orElse: () => [],
      );

  String get userQuotationId => maybeMap(
        (value) => '',
        additional: (value) => value.userQuotationId,
        orElse: () => '',
      );

  bool get isAlreadyAcquired => maybeMap(
        (value) => false,
        additional: (value) => value.isAlreadyAcquired,
        orElse: () => false,
      );

  String get coverageOfferType => maybeMap(
        (value) => '',
        additional: (value) => value.coverageOfferType,
        level: (value) => value.coverageOfferType,
        orElse: () => '',
      );

  ProductRatesModel? get productRates => mapOrNull(
        (value) => null,
        additional: (value) => value.productRates,
      );

  List<IntermediaryFeeModel>? get intermediariesFees => maybeMap(
        (value) => [],
        additional: (value) => value.intermediariesFees,
        orElse: () => [],
      );

  DateTime? get quotationRegisterDate => mapOrNull(
        (value) => null,
        additional: (value) => value.quotationRegisterDate,
      );

  double get newCoverageOfferValue => maybeMap(
        (value) => 0.0,
        additional: (value) => value.newCoverageOfferValue,
        level: (value) => value.coverageOfferValue,
        orElse: () => 0.0,
      );

  double get oldCoverageOfferValue => maybeMap(
        (value) => 0.0,
        additional: (value) => value.oldCoverageOfferValue,
        level: (value) => value.coverageOfferValue,
        orElse: () => 0.0,
      );

  CurrentQuotePricePlansModel? get currentQuotePricePlans => mapOrNull(
        (value) => null,
        additional: (value) => value.currentQuotePricePlans,
      );

  bool get fromStore => maybeMap(
        (value) => false,
        purchased: (value) => value.fromStore,
        orElse: () => false,
      );

  bool get isPartiallyAcquired => maybeMap(
        (value) => false,
        additional: (value) => value.isPartiallyAcquired,
        orElse: () => false,
      );

  bool get isCobenefit => maybeMap(
        (value) => false,
        cobenefit: (_) => true,
        orElse: () => false,
      );
}

extension MutableBenefitPerSupplierModel on BenefitPerSupplierModel {
  BenefitPerSupplierModel? setTicket(TicketModel? ticket) => mapOrNull(
        (value) => null,
        detail: (value) => value.copyWith(ticket: ticket),
        cobenefit: (value) => value.copyWith(ticket: ticket),
      );

  ///Use to update or add a new BenefitPerSupplierModel of type cobenefit.
  ///
  ///Returns a BenefitPerSupplierModel of type detail or level
  ///Change [addNew] to true if a new BenefitPerSupplierModel of type cobenefit
  ///is being added.
  BenefitPerSupplierModel? setCobenefitPerSupplier(
    BenefitPerSupplierModel cobenefitPerSupplier, {
    bool addNew = false,
  }) {
    final currentCobenefitsPerSupplier =
        List<BenefitPerSupplierModel>.from(cobenefitsPerSupplier);
    final index = currentCobenefitsPerSupplier.indexWhere((element) =>
        element.benefitPerSupplierId ==
        cobenefitPerSupplier.benefitPerSupplierId);
    if (addNew) {
      if (index < 0) {
        final newCobenefitsPerSupplier = [
          ...currentCobenefitsPerSupplier,
          cobenefitPerSupplier,
        ];
        return setCobenefitsPerSupplier(newCobenefitsPerSupplier);
      }
      //Does not add a new element if it already exists
      return this;
    }
    //Does not update an element that does not exist
    if (index < 0) return this;
    currentCobenefitsPerSupplier[index] = cobenefitPerSupplier;
    final updatedCobenefitsPerSupplier = currentCobenefitsPerSupplier;
    return setCobenefitsPerSupplier(updatedCobenefitsPerSupplier);
  }

  BenefitPerSupplierModel? setCobenefitsPerSupplier(
      List<BenefitPerSupplierModel> cobenefitsPerSupplier) {
    return mapOrNull(
      (value) => null,
      detail: (value) => value.copyWith(
        cobenefitsPerSupplier: cobenefitsPerSupplier,
      ),
      level: (value) => value.copyWith(
        cobenefitsPerSupplier: cobenefitsPerSupplier,
      ),
    );
  }

  BenefitPerSupplierModel toPurchasedModel() =>
      BenefitPerSupplierModel.purchased(
        benefitPerSupplierId: benefitPerSupplierId,
        folio: folio,
        wordingZero: wordingZero,
        benefitImage: benefitImage,
        pdfWording: pdfWording,
        supplier: supplier!,
        benefit: benefit,
        benefitType: benefitType,
        fromStore: true,
      );
}
