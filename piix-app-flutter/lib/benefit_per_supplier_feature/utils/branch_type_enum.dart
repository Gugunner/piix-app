import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_icons/benefit_type_branch_icon.dart';
import 'package:piix_mobile/widgets/tag/tag_barrel_file.dart';

enum BranchType {
  transport(BenefitTypeBranchIcon.transport),
  technology(BenefitTypeBranchIcon.technology),
  tramits(BenefitTypeBranchIcon.tramits),
  general_assistance(BenefitTypeBranchIcon.general_assistance),
  automobile(BenefitTypeBranchIcon.automobile),
  dentist(BenefitTypeBranchIcon.dentist),
  entertainment(BenefitTypeBranchIcon.entertainment),
  funerary(BenefitTypeBranchIcon.funerary),
  household(BenefitTypeBranchIcon.household),
  incendiary(BenefitTypeBranchIcon.incendiary),
  flooding(BenefitTypeBranchIcon.flooding),
  laboratory(BenefitTypeBranchIcon.laboratory),
  legal(BenefitTypeBranchIcon.legal),
  nutriology(BenefitTypeBranchIcon.nutriology),
  psychology(BenefitTypeBranchIcon.psychology),
  robbery(BenefitTypeBranchIcon.robbery),
  health(BenefitTypeBranchIcon.health),
  household_force_majeure(BenefitTypeBranchIcon.household_force_majeure),
  earthquake(BenefitTypeBranchIcon.earthquake),
  farm_veterinary(BenefitTypeBranchIcon.farm_veterinary),
  home_veterinary(BenefitTypeBranchIcon.home_veterinary),
  life(BenefitTypeBranchIcon.life),
  emergency(BenefitTypeBranchIcon.emergency),
  unkown(Icons.question_mark_outlined);

  const BranchType(this.icon);

  final IconData icon;

  Tag get tag => Tag.icon(PiixColors.secondary, icon: icon);
}
