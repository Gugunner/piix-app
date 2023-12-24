import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';

extension AdditionalBenefitPerSupplierListExtend
    on List<BenefitPerSupplierModel> {
  List<BenefitPerSupplierModel> filterByType(String type) =>
      where((additionalBenefit) =>
          additionalBenefit.benefitType?.benefitType.name == type).toList();
}

extension AdditionalBenefitsPerSupplierStringExtend on String {
  String infoTooltip() {
    switch (this) {
      case 'Asistencias':
        return PiixCopiesDeprecated.attendanceTooltipInfo;
      case 'Seguros':
        return PiixCopiesDeprecated.insuranceTooltipInfo;
      case 'Servicios':
        return PiixCopiesDeprecated.servicesTooltipInfo;
      case 'Todos los beneficios':
        return PiixCopiesDeprecated.allBenefitsTooltipInfo;
      default:
        return PiixCopiesDeprecated.combosTooltipInfo;
    }
  }
}
