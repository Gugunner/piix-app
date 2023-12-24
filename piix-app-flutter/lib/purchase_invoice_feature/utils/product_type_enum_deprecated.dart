import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';

@Deprecated('Will be removed in 4.0')
enum ProductTypeDeprecated {
  LEVEL(PiixCopiesDeprecated.levelLabel),
  PLAN(PiixCopiesDeprecated.planLabel),
  COMBO(PiixCopiesDeprecated.comboLabel),
  ADDITIONAL(PiixCopiesDeprecated.benefitLabel),
  NONE('');

  const ProductTypeDeprecated(this.label);

  final String label;
}
