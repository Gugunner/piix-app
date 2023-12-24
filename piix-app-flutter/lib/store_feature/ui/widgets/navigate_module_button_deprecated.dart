import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/store_feature/utils/store_module_enum_deprecated.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/additional_benefits_per_supplier_home_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/levels/levels_home_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/package_combos/package_combo_home_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/plans/plans_home_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/utils/payment_methods.dart';

@Deprecated('No longer in use in 4.0')

///This widget depends of module navigate to specific screen
///
class NavigateModuleButtonDeprecated extends StatelessWidget {
  const NavigateModuleButtonDeprecated({super.key, required this.module});
  final StoreModuleDeprecated module;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.628,
      height: 34.h,
      child: ElevatedButton(
        onPressed: () {
          if (module == StoreModuleDeprecated.additionalBenefit) {
            NavigatorKeyState().getNavigator()?.pushNamed(
                AdditionalBenefitsPerSupplierHomeScreenDeprecated.routeName);
          }
          if (module == StoreModuleDeprecated.plan) {
            NavigatorKeyState()
                .getNavigator(context)
                ?.pushNamed(PlansHomeScreenDeprecated.routeName);
          }
          if (module == StoreModuleDeprecated.level) {
            NavigatorKeyState()
                .getNavigator(context)
                ?.pushNamed(LevelsHomeScreenDeprecated.routeName);
          }
          if (module == StoreModuleDeprecated.combo) {
            NavigatorKeyState()
                .getNavigator(context)
                ?.pushNamed(PackageComboHomeScreenDeprecated.routeName);
          }
        },
        child: Text(
          module.getTextOfButtonPayments.toUpperCase(),
          style: context.primaryTextTheme?.titleMedium?.copyWith(
            color: PiixColors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
