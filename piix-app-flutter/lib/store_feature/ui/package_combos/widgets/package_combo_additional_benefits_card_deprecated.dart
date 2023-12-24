import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/package_combos_bloc.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/widgets_deprecated/already_acquired__additional_benefit_banner_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/package_combos/widgets/additional_benefits_per_supplier_expansion_list_card_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/package_combos/widgets/package_combo_quotation_button_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This card render a additional benefits per supplier expansion list and
/// quotation buttons
///
class PackageComboAdditionalBenefitsCardDeprecated extends StatelessWidget {
  const PackageComboAdditionalBenefitsCardDeprecated({Key? key})
      : super(key: key);

  double get mediumPadding => ConstantsDeprecated.mediumPadding;

  @override
  Widget build(BuildContext context) {
    final packageComboBLoC = context.read<PackageComboBLoC>();
    final currentPackageCombo =
        packageComboBLoC.currentPackageCombo?.mapOrNull((value) => value);
    final anyBenefitAlreadyAcquired =
        currentPackageCombo?.additionalBenefitsPerSupplier.any(
              (element) => element.maybeMap((value) => false,
                  additional: (value) => value.isAlreadyAcquired,
                  orElse: () => false),
            ) ??
            false;
    final lastPadding = currentPackageCombo?.comboDiscount != null ? 12 : 6;
    return Stack(
      children: [
        Card(
          elevation: 3,
          margin: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(5))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //This text shows a brief of advantages to buy combos.
              Text(
                PiixCopiesDeprecated.buyCombosBrief,
                style: context.textTheme?.bodyMedium?.copyWith(
                  color: PiixColors.highlight,
                ),
              ).padHorizontal(mediumPadding.w).padVertical(lastPadding.h),
              //Render a button to navigate quotation combo screen
              PackageComboQuotationButtonDeprecated(
                packageCombo: currentPackageCombo!,
                buttonType: ButtonTypeDeprecated.outlined,
              ),
              if (currentPackageCombo
                  .additionalBenefitsPerSupplier.isNotEmpty) ...[
                Text(
                  PiixCopiesDeprecated.comboBenefits,
                  style: context.textTheme?.headlineSmall,
                )
                    .padHorizontal(mediumPadding.w)
                    .padOnly(top: 26.h, bottom: mediumPadding.h),
                //Render a additional benefit expansion tiles
                const AdditionalBenefitsPerSupplierExpansionListCardDeprecated()
                    .padHorizontal(16.w)
                //.padBottom(24.h)
              ],
              if (anyBenefitAlreadyAcquired)
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  child: AlreadyAcquiredAdditionalBenefitBannerDeprecated(
                    height: 48,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(4)),
                    label: PiixCopiesDeprecated.alreadyBenefitsInCombo,
                    labelStyle: context.textTheme?.labelMedium?.copyWith(
                      color: PiixColors.white,
                    ),
                  ),
                ),
              SizedBox(height: 20.h),
              //Render a button to navigate quotation combo screen
              PackageComboQuotationButtonDeprecated(
                packageCombo: currentPackageCombo,
                buttonType: ButtonTypeDeprecated.elevated,
              ).padBottom(8.h),
              if (currentPackageCombo.isAlreadyAcquired)
                Center(
                    child: Text(
                  PiixCopiesDeprecated.alreadyAcquiredCombo,
                  style: context.textTheme?.labelMedium?.copyWith(
                    color: PiixColors.primary,
                  ),
                )).padBottom(mediumPadding.h)
              else
                Center(
                    child: Text(
                  PiixCopiesDeprecated.discoverPrice,
                  style: context.textTheme?.labelMedium?.copyWith(
                    color: PiixColors.primary,
                  ),
                )).padBottom(mediumPadding.h),
              if (currentPackageCombo.isPartiallyAcquired)
                Center(
                  child: Text(
                    PiixCopiesDeprecated.anyProtectedNoCombo,
                    style: context.textTheme?.labelMedium?.copyWith(
                      color: PiixColors.process,
                    ),
                  ),
                ).padBottom(mediumPadding.h),

              if (currentPackageCombo.hasPendingInvoice)
                Center(
                  child: Text(
                    PiixCopiesDeprecated.quoteAndPendingComboInvoice,
                    style: context.textTheme?.labelMedium?.copyWith(
                      color: PiixColors.process,
                    ),
                  ),
                ).padBottom(mediumPadding.h),
            ],
          ),
        ),
        Transform.translate(
          offset: Offset(0, -4.h),
          child: Container(
            height: 10,
            margin: EdgeInsets.symmetric(horizontal: 2.w),
            color: PiixColors.white,
          ),
        ),
      ],
    );
  }
}
