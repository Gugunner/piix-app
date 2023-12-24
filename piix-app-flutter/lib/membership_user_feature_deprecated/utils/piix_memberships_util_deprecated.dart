import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/extensions/date_extend_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_icons.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/membership_model/membership_model_deprecated.dart';

/// Gets the corresponding sign label for the benefit
String getSignLabelFromBenefit(BenefitPerSupplierModel benefitPerSupplier,
    {bool addHereToText = false}) {
  final benefit = benefitPerSupplier.mapOrNull(
    (value) => value,
  );
  if (benefit == null) return '';
  final label = addHereToText ? ' ${PiixCopiesDeprecated.hereLabel}' : '';
  return benefit.userHasAlreadySignedTheBenefitForm
      ? PiixCopiesDeprecated.filledLabel
      : benefit.needsBenefitFormSignature
          ? '${PiixCopiesDeprecated.signLabel}$label'
          : '${PiixCopiesDeprecated.fillLabel}$label';
}

/// Gets the corresponding sign label for the benefit
String getSignLabelByFlags(
    bool userHasAlreadySignedTheBenefitForm, bool needsBenefitFormSignature,
    {bool addHereToText = false}) {
  return userHasAlreadySignedTheBenefitForm
      ? PiixCopiesDeprecated.filledLabel
      : needsBenefitFormSignature
          ? '${PiixCopiesDeprecated.signLabel}${(addHereToText ? ' ${PiixCopiesDeprecated.hereLabel}' : '')}'
          : '${PiixCopiesDeprecated.fillLabel}${(addHereToText ? ' ${PiixCopiesDeprecated.hereLabel}' : '')}';
}

/// Gets the corresponding sign color for the benefit
Color getColorLabelByFlags(
  bool userHasAlreadySignedTheBenefitForm,
  bool needsBenefitFormSignature,
) {
  return userHasAlreadySignedTheBenefitForm
      ? PiixColors.brownGrey
      : needsBenefitFormSignature
          ? PiixColors.pumpkinOrange
          : PiixColors.darkMustard;
}

/// Gets the corresponding sign color for the benefit
Color getSignColorFromBenefit(BenefitPerSupplierModel benefitPerSupplier) {
  final benefit = benefitPerSupplier.mapOrNull(
    (value) => value,
  );
  if (benefit == null) return Colors.transparent;
  return benefit.userHasAlreadySignedTheBenefitForm
      ? PiixColors.brownGrey
      : benefit.needsBenefitFormSignature
          ? PiixColors.pumpkinOrange
          : PiixColors.darkMustard;
}

/// Gets the corresponding sign label for the cobenefit
String getSignLabelFromCoBenefit(BenefitPerSupplierModel cobenefitPerSupplier,
    {bool addHereToText = false}) {
  final cobenefit = cobenefitPerSupplier.mapOrNull((value) => null,
      cobenefit: (value) => value);
  if (cobenefit == null) return '';
  return cobenefit.userHasAlreadySignedTheBenefitForm
      ? PiixCopiesDeprecated.filledLabel
      : cobenefit.needsBenefitFormSignature
          ? '${PiixCopiesDeprecated.signLabel}${(addHereToText ? ' '
              '${PiixCopiesDeprecated.hereLabel}' : '')}'
          : '${PiixCopiesDeprecated.fillLabel}${(addHereToText ? ' '
              '${PiixCopiesDeprecated.hereLabel}' : '')}';
}

/// Gets the corresponding sign color for the cobenefit
Color getSignColorFromCoBenefit(BenefitPerSupplierModel cobenefitPerSupplier) {
  final cobenefit = cobenefitPerSupplier.mapOrNull((value) => null,
      cobenefit: (value) => value);
  if (cobenefit == null) return Colors.transparent;
  return cobenefit.userHasAlreadySignedTheBenefitForm
      ? PiixColors.brownGrey
      : cobenefit.needsBenefitFormSignature
          ? PiixColors.pumpkinOrange
          : PiixColors.darkMustard;
}

// Gets the corresponding sign label for the benefit
String getSignInfoLabelFromBenefit(bool needsBenefitFormSignature) {
  return needsBenefitFormSignature
      ? PiixCopiesDeprecated.signInfoLabel
      : PiixCopiesDeprecated.fillInfoLabel;
}

// Gets the corresponding sign label for the benefit
String getSignInfoLabelFromCoBenefit(
    BenefitPerSupplierModel? cobenefitPerSupplier) {
  final cobenefit = cobenefitPerSupplier?.mapOrNull((value) => null,
      cobenefit: (value) => value);
  return cobenefit?.needsBenefitFormSignature != null &&
          cobenefit!.needsBenefitFormSignature
      ? PiixCopiesDeprecated.signCoInfoLabel
      : PiixCopiesDeprecated.fillCoInfoLabel;
}

/// From [benefitType], an icon is returned
IconData getBenefitTypeIcon(String? benefitType) {
  switch (benefitType) {
    case 'Seguros':
      return PiixIcons.seguros;
    case 'Asistencias':
      return PiixIcons.asistencias;
    case 'Acuerdos Comerciales':
      return PiixIcons.descuentos_mas;
    case 'Servicios':
      return PiixIcons.servicios;
    case 'Combos':
      return PiixIcons.combos_image;
    case 'Todo':
      return Icons.grid_view_outlined;
    default:
      return PiixIcons.recompensas;
  }
}

/// From [benefitType], a color is returned
Color getBenefitTypeColor(String? benefitType) {
  switch (benefitType) {
    case 'Seguros':
      return PiixColors.azure;
    case 'Asistencias':
      return PiixColors.attendanceGreen;
    case 'Acuerdos Comerciales':
    case 'Servicios':
      return PiixColors.servicesPink;
    case 'Combos':
      return PiixColors.sunYellow;
    case 'Todo':
      return PiixColors.greyTotalCard;
    default:
      return PiixColors.bluePurple;
  }
}

/// From [benefitType], a copy is returned
String getBenefitTypeCopy(String? benefitType) {
  switch (benefitType) {
    case 'Seguros':
      return 'Seguro';
    case 'Asistencias':
      return 'Asistencia';
    case 'Acuerdos Comerciales':
      return 'Recompensas';
    case 'Servicios':
      return 'Servicios';
    default:
      return 'Recompensas';
  }
}

/// Copy to clipboard the membership data.
void copyMembershipData({
  required String? uniqueId,
  required MembershipModelDeprecated? membership,
}) {
  final isActive = membership?.isActive ?? false;
  Clipboard.setData(ClipboardData(
    text: '${PiixCopiesDeprecated.myPiixInfo}\n'
        '${PiixCopiesDeprecated.id} ${(uniqueId ?? '').addComma().addSpace()}\n'
        '${PiixCopiesDeprecated.membershipWord}: '
        '${(membership?.membershipId ?? '').addComma().addSpace()}\n'
        '${PiixCopiesDeprecated.client}: '
        '${(membership?.clientName ?? '').addComma().addSpace()}\n'
        '${PiixCopiesDeprecated.package}: '
        '${(membership?.package.name ?? '').addComma().addSpace()}\n'
        '${PiixCopiesDeprecated.fromValidity} '
        '${(membership?.toDate.dateFormat ?? '').addComma().addSpace()}\n'
        '${PiixCopiesDeprecated.validityTo} '
        '${(membership?.toDate.dateFormat ?? '').addComma().addSpace()}\n'
        '${PiixCopiesDeprecated.levelText}: '
        '${(membership?.usersMembershipLevel.name ?? '').addComma().addSpace()}'
        '\n'
        '${PiixCopiesDeprecated.planLabel}: '
        '${membership?.usersMembershipPlans.map((e) {
              return e.name;
            }).join('/').addComma().addSpace()}\n'
        '${PiixCopiesDeprecated.status}: '
        '${isActive ? PiixCopiesDeprecated.activeProduct : PiixCopiesDeprecated.inactiveProduct}',
  ));
}
