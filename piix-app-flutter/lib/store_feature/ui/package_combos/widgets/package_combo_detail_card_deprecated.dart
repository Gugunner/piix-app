import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/store_feature/domain/bloc/package_combos_bloc.dart';
import 'package:piix_mobile/store_feature/ui/package_combos/widgets/package_combo_additional_benefits_card_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/package_combos/widgets/package_combo_info_detail_card_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/widgets/ribbon_container_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a package combo main detail card includes info and
///additional benefits per suplier cards
///
class PackageComboDetailCardDeprecated extends StatelessWidget {
  const PackageComboDetailCardDeprecated({Key? key}) : super(key: key);
  double get mediumPadding => ConstantsDeprecated.mediumPadding;
  @override
  Widget build(BuildContext context) {
    final packageComboBLoC = context.read<PackageComboBLoC>();
    final currentPackageCombo =
        packageComboBLoC.currentPackageCombo?.mapOrNull((value) => value);
    final discount = (currentPackageCombo!.comboDiscount) * 100;

    return Column(
      children: [
        //Render a combo info detail card
        const PackageComboInfoDetailCardDeprecated().padHorizontal(
          mediumPadding.w,
        ),
        if (currentPackageCombo.comboDiscount > 0)
          //Render a discount detail ribbons
          RibbonDetailContainerDeprecated(
            discount: discount,
          ),
        //Render an additional benefits in combos card
        Transform.translate(
          offset: currentPackageCombo.comboDiscount > 0
              ? Offset.zero
              : Offset(0, -4.h),
          child: const PackageComboAdditionalBenefitsCardDeprecated()
              .padHorizontal(mediumPadding.w),
        ),
      ],
    );
  }
}
