import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/package_combos_bloc.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/widgets_deprecated/already_acquired__additional_benefit_banner_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/package_combos/widgets/package_combo_detail_card_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/widgets/svg_asset_image_container_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a package combo detail screen
///Render a combo banner, main info of combo, combo discount and additional
///benefits in combo
///
class PackageComboDetailScreenDeprecated extends StatelessWidget {
  static const routeName = '/package_combo_detail';
  const PackageComboDetailScreenDeprecated({Key? key}) : super(key: key);

  double get paddingVertical => 24;
  double get imageHeight => 99;
  double get borderRadius => 4;
  //This is a factor to stack package combo card on package combo image
  double get stackPositionedFactor => 0.95;

  @override
  Widget build(BuildContext context) {
    final packageComboBLoC = context.watch<PackageComboBLoC>();
    final currentPackageCombo =
        packageComboBLoC.currentPackageCombo?.mapOrNull((value) => value);
    final isAlreadyAcquired = currentPackageCombo?.isAlreadyAcquired ?? false;
    final paddingTop = isAlreadyAcquired ? 54 : paddingVertical;

    return Scaffold(
      appBar: AppBar(
        title: const Text(PiixCopiesDeprecated.comboDetail),
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: PiixColors.greyWhite,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(bottom: paddingVertical.h),
              child: Column(
                children: [
                  //This is a combo image widget
                  Align(
                    heightFactor: stackPositionedFactor,
                    alignment: Alignment.topCenter,
                    child: SvgAssetImageContainerDeprecated(
                      PiixAssets.detail_combo_banner,
                      borderRadius: borderRadius.h,
                      height: imageHeight.h,
                      width: context.width,
                    )
                        .padHorizontal(ConstantsDeprecated.mediumPadding.w)
                        .padTop(paddingTop.h),
                  ),
                  //This is a package combo card
                  const Align(
                    alignment: Alignment.topCenter,
                    child: PackageComboDetailCardDeprecated(),
                  ),
                  //This is a text fot no more add benefits in combo instructions
                  Text(
                    PiixCopiesDeprecated.noMoreAddBenefitsInCombo,
                    textAlign: TextAlign.justify,
                    style: context.textTheme?.labelMedium,
                  ).padHorizontal(18.w).padTop(24.h)
                ],
              ),
            ),
          ),
          if (isAlreadyAcquired)
            //This is a already acquire benefit banner
            const Align(
              alignment: Alignment.topCenter,
              child: AlreadyAcquiredAdditionalBenefitBannerDeprecated(
                label: PiixCopiesDeprecated.alreadyAcquiredCombo,
              ),
            ),
          if (currentPackageCombo?.isPartiallyAcquired ?? false)
            //This is a already acquire benefit banner
            Align(
              alignment: Alignment.topCenter,
              child: AlreadyAcquiredAdditionalBenefitBannerDeprecated(
                label: PiixCopiesDeprecated.haveThisComboButYourProtectedNo,
                color: PiixColors.simultaneousColor,
                height: 22.h,
              ),
            ),
        ],
      ),
    );
  }
}
