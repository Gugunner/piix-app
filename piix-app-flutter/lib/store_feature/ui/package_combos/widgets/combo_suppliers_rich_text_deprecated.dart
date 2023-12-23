import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/package_combos_bloc.dart';
import 'package:piix_mobile/store_feature/domain/model/combo_model.dart';
import 'package:piix_mobile/store_feature/ui/details/package_combo_detail_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/widgets/store_text_button.dart';
import 'package:piix_mobile/store_feature/utils/combos.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget receives a package combo and render each one of the suppliers
///of the each one additional benefit per suppliers in a rich text
///
class ComboSuppliersRichTextDeprecated extends StatelessWidget {
  const ComboSuppliersRichTextDeprecated({
    super.key,
    required this.packageCombo,
    this.isDetail = false,
  });
  final ComboModel packageCombo;
  final bool isDetail;

  @override
  Widget build(BuildContext context) {
    void handleDetailComboNavigation() {
      final packageComboBLoC = context.read<PackageComboBLoC>();
      packageComboBLoC.setCurrentPackageCombo(packageCombo);
      NavigatorKeyState()
          .getNavigator(context)
          ?.pushNamed(PackageComboDetailScreenDeprecated.routeName);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text:
                      '${packageCombo.additionalBenefitsPerSupplier.getSupplierText}: ',
                  style: context.primaryTextTheme?.titleMedium,
                ),
                TextSpan(
                  text: packageCombo
                      .additionalBenefitsPerSupplier.getSupplierNames,
                  style: context.textTheme?.bodyMedium,
                ),
              ],
            ),
          ),
        ),
        if (!isDetail)
          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: StoreTextButtonDeprecated(
              label: PiixCopiesDeprecated.knowMore.toUpperCase(),
              onTap: handleDetailComboNavigation,
            ),
          )
      ],
    );
  }
}
