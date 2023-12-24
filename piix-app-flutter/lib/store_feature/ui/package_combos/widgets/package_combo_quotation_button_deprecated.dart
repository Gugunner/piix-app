import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/package_combos_bloc.dart';
import 'package:piix_mobile/store_feature/domain/model/combo_model.dart';
import 'package:piix_mobile/store_feature/ui/quotations/package_combo_quotation_home_screen_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This button navigate to package combo quotation screen
///
class PackageComboQuotationButtonDeprecated extends StatelessWidget {
  const PackageComboQuotationButtonDeprecated({
    super.key,
    required this.packageCombo,
    this.buttonType = ButtonTypeDeprecated.elevated,
  });
  final ComboModel packageCombo;
  final ButtonTypeDeprecated buttonType;

  void handleQuoteNavigation(BuildContext context) {
    final packageComboBLoC = context.read<PackageComboBLoC>();
    packageComboBLoC.setCurrentPackageCombo(packageCombo);
    NavigatorKeyState()
        .getNavigator(context)
        ?.pushNamed(PackageComboQuotationHomeScreenDeprecated.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final currentPackageCombo = packageCombo.mapOrNull((value) => value);
    final isPartiallyAcquired =
        currentPackageCombo?.isPartiallyAcquired ?? false;
    final isDisabled = !isPartiallyAcquired &&
        (currentPackageCombo?.isAlreadyAcquired ?? false);
    final buttonText = isPartiallyAcquired
        ? PiixCopiesDeprecated.quoteToProtectedLabel.toUpperCase()
        : PiixCopiesDeprecated.quoteButtonLabel.toUpperCase();
    return Center(
      child: SizedBox(
        height: 32.h,
        width: context.width * 0.629,
        child: buttonType == ButtonTypeDeprecated.outlined
            ? OutlinedButton(
                style: Theme.of(context).outlinedButtonTheme.style,
                onPressed:
                    isDisabled ? null : () => handleQuoteNavigation(context),
                child: Text(
                  buttonText,
                ),
              )
            : ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style,
                onPressed:
                    isDisabled ? null : () => handleQuoteNavigation(context),
                child: Text(
                  buttonText,
                  style: context.accentTextTheme?.labelMedium,
                ),
              ),
      ),
    );
  }
}
