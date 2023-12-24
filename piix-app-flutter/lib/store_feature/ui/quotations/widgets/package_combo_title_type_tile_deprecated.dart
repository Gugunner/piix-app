import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/package_combos_bloc.dart';
import 'package:piix_mobile/store_feature/utils/combos.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget contains name, benefits type names and number of benefits for a
/// current package combo
///
class PackageComboTitleTypeTileDeprecated extends StatelessWidget {
  const PackageComboTitleTypeTileDeprecated({super.key});

  @override
  Widget build(BuildContext context) {
    final packageComboBLoC = context.read<PackageComboBLoC>();
    final packageComboWithPrices = packageComboBLoC.packageComboWithPrices;
    final additionalBenefitsPerSupplier =
        packageComboWithPrices!.additionalBenefitsPerSupplier;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          packageComboWithPrices.name,
          style: context.primaryTextTheme?.headlineSmall,
        ).padBottom(4.h),
        Text(
          additionalBenefitsPerSupplier.getAdditionalBenefitTypesNameInString,
          style: context.textTheme?.bodyMedium,
        ),
        Text(
          '${PiixCopiesDeprecated.contains} '
          '${additionalBenefitsPerSupplier.length} '
          '${PiixCopiesDeprecated.benefits.toLowerCase()}',
          style: context.textTheme?.bodyMedium,
        )
      ],
    );
  }
}
