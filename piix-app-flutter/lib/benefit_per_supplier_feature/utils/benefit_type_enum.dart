import 'package:flutter/material.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/utils/constants_deprecated/benefit_per_supplier_copies_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_icons.dart';
import 'package:piix_mobile/widgets/tag/tag_barrel_file.dart';

enum BenefitType {
  S(
    type: 'Seguros',
    color: PiixColors.insurance,
    icon: PiixIcons.seguros,
  ),
  X(
    type: 'Servicios',
    color: PiixColors.services,
    icon: PiixIcons.servicios,
  ),
  A(
    type: 'Asistencias',
    color: PiixColors.assists,
    icon: PiixIcons.asistencias,
  ),
  Z(
    type: 'Acuerdos Comerciales',
    color: PiixColors.rewards,
    icon: PiixIcons.descuentos_mas,
  ),
  N(
    type: 'None',
    color: PiixColors.space,
    icon: PiixIcons.info,
  );

  const BenefitType({
    required this.type,
    required this.color,
    required this.icon,
  });

  final String type;
  final Color color;
  final IconData icon;

  String get copy {
    switch (type) {
      case 'Seguros':
        return BenefitPerSupplierCopiesDeprecated.insurance;
      case 'Asistencias':
        return BenefitPerSupplierCopiesDeprecated.assistance;
      case 'Acuerdos Comerciales':
        return BenefitPerSupplierCopiesDeprecated.reward;
      case 'Servicios':
        return BenefitPerSupplierCopiesDeprecated.service;
      default:
        return BenefitPerSupplierCopiesDeprecated.assistance;
    }
  }

  Tag get tag => Tag.label(
        color,
        label: copy,
        icon: icon,
      );
}
