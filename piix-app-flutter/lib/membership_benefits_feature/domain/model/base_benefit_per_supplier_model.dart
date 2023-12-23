import 'package:piix_mobile/claim_ticket_feature/domain/model/ticket_model.dart';
import 'package:piix_mobile/membership_benefits_feature/domain/model/benefit_model.dart';
import 'package:piix_mobile/membership_benefits_feature/domain/model/benefit_type_model.dart';
import 'package:piix_mobile/membership_benefits_feature/domain/model/supplier_model.dart';

abstract class BaseBenefitPerSupplierModel {
  const BaseBenefitPerSupplierModel({
    required this.folio,
    required this.wordingZero,
    required this.pdfWording,
    required this.benefitImage,
    required this.certificate,
    required this.coverageOfferType,
    required this.coverageOfferValue,
    required this.effectiveFromDate,
    required this.effectiveToDate,
    required this.claimedTimes,
    required this.requiresAgeCompliance,
    required this.hasBenefitForm,
    required this.needsBenefitFormSignature,
    required this.userHasAlreadySignedTheBenefitForm,
    required this.benefit,
    required this.benefitType,
    required this.supplier,
    this.ticket,
    this.wordingOne,
    this.wordingTwo,
    this.benefitFormId,
  });

  final String folio;
  final String wordingZero;
  final String pdfWording;
  final String benefitImage;
  final String certificate;
  final String coverageOfferType;
  final double coverageOfferValue;
  final DateTime effectiveFromDate;
  final DateTime effectiveToDate;
  final int claimedTimes;
  final bool requiresAgeCompliance;
  final bool hasBenefitForm;
  final bool needsBenefitFormSignature;
  final bool userHasAlreadySignedTheBenefitForm;
  final BenefitModel benefit;
  final BenefitTypeModel benefitType;
  final SupplierModel supplier;
  final TicketModel? ticket;
  final String? wordingOne;
  final String? wordingTwo;
  final String? benefitFormId;
}
