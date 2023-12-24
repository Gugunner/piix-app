import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/package_combos_bloc.dart';
import 'package:piix_mobile/store_feature/domain/model/combo_model.dart';
import 'package:piix_mobile/store_feature/ui/details/package_combo_detail_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/package_combos/widgets/combo_suppliers_rich_text_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/package_combos/widgets/discount_ribbon.dart';
import 'package:piix_mobile/store_feature/ui/package_combos/widgets/package_combo_quotation_button_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/package_combos/widgets/package_combo_tags_row_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/widgets/pending_invoice_icon_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This card render a package combo,
///includes main info of package combo
///
class PackageComboCardDeprecated extends StatelessWidget {
  const PackageComboCardDeprecated({
    super.key,
    required this.packageCombo,
  });

  final ComboModel packageCombo;

  void handleDetailComboNavigation(BuildContext context) {
    final packageComboBLoC = context.read<PackageComboBLoC>();
    packageComboBLoC.setCurrentPackageCombo(packageCombo);
    NavigatorKeyState()
        .getNavigator(context)
        ?.pushNamed(PackageComboDetailScreenDeprecated.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final currentPackageCombo = packageCombo.mapOrNull((value) => value);
    return Card(
      elevation: 3,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                vertical: ConstantsDeprecated.mediumPadding.h),
            width: context.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Render a combo name
                GestureDetector(
                  onTap: () => handleDetailComboNavigation(context),
                  child: Text(
                    packageCombo.name,
                    style: context.textTheme?.headlineMedium,
                  )
                      .padHorizontal(ConstantsDeprecated.mediumPadding.w)
                      .padBottom(ConstantsDeprecated.mediumPadding.h)
                      .padRight(
                          !(currentPackageCombo?.hasPendingInvoice ?? true)
                              ? 16.w
                              : 0),
                ),
                //Render tags for benefits types in package combo
                PackageComboTagsRowDeprecated(
                  additionalBenefitsPerSupplier:
                      packageCombo.additionalBenefitsPerSupplier,
                )
                    .padHorizontal(ConstantsDeprecated.mediumPadding.w)
                    .padBottom(ConstantsDeprecated.mediumPadding.h),
                //Render a provider list of combo in a rich text
                ComboSuppliersRichTextDeprecated(packageCombo: packageCombo)
                    .padHorizontal(ConstantsDeprecated.mediumPadding.w)
                    .padBottom(8.h),
                if (currentPackageCombo?.description != null)
                  //Render a package combo description
                  Html(data: '''${currentPackageCombo!.description}''', style: {
                    'p': Style(
                      color: PiixColors.infoDefault,
                      fontFamily: 'Raleway',
                      fontSize: FontSize(
                        12.sp,
                      ),
                      letterSpacing: 0.1,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.justify,
                      lineHeight: LineHeight.em(1),
                    ),
                  })
                      .padHorizontal(10.w)
                      .padBottom(ConstantsDeprecated.mediumPadding.h),
                if (currentPackageCombo?.comboDiscount != null &&
                    currentPackageCombo!.comboDiscount > 0)
                  //Render a discount ribbon
                  DiscountRibbon(
                    discount: currentPackageCombo.comboDiscount,
                  ).padBottom(ConstantsDeprecated.mediumPadding.h),
                //Render a quotation button
                PackageComboQuotationButtonDeprecated(
                        packageCombo: packageCombo)
                    .padBottom(8.h),

                if (currentPackageCombo?.isPartiallyAcquired ?? false)
                  Text(
                    PiixCopiesDeprecated.anyProtectedNoCombo,
                    style: context.textTheme?.labelMedium?.copyWith(
                      color: PiixColors.process,
                    ),
                  ).center()
                else if (currentPackageCombo?.hasPendingInvoice ?? false)
                  Text(
                    PiixCopiesDeprecated.quoteAndPendingComboInvoice,
                    style: context.textTheme?.labelMedium?.copyWith(
                      color: PiixColors.process,
                    ),
                  ).center()
                else if (currentPackageCombo?.isAlreadyAcquired ?? false)
                  Center(
                      child: Text(
                    PiixCopiesDeprecated.alreadyAcquiredCombo,
                    style: context.textTheme?.labelMedium?.copyWith(
                      color: PiixColors.primary,
                    ),
                  )).center()
                else //Render a discover and cover text
                  Center(
                    child: Text(
                      PiixCopiesDeprecated.discoverPrice,
                      style: context.textTheme?.labelMedium?.copyWith(
                        color: PiixColors.primary,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (currentPackageCombo?.hasPendingInvoice ?? false)
            const Align(
              alignment: Alignment.topRight,
              child: PendingInvoiceIconDeprecated(),
            )
        ],
      ),
    );
  }
}
