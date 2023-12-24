import 'package:flutter/material.dart';
import 'package:piix_mobile/store_feature/domain/bloc/package_combos_bloc.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/widgets_deprecated/additional_benefit_expansion_tile_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a expansion additional benefit in combo card
///
class AdditionalBenefitsPerSupplierExpansionListCardDeprecated
    extends StatelessWidget {
  const AdditionalBenefitsPerSupplierExpansionListCardDeprecated({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final packageComboBLoC = context.read<PackageComboBLoC>();

    final currentPackageCombo = packageComboBLoC.currentPackageCombo;

    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(
        bottom: 0,
      ),
      child: Column(
        children: [
          ...currentPackageCombo!.additionalBenefitsPerSupplier
              .map((additionalBenefit) => Theme(
                    data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                        listTileTheme:
                            ListTileTheme.of(context).copyWith(dense: true)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(
                            color: PiixColors.secondaryLight, height: 0),
                        AdditionalBenefitExpansionTileDeprecated(
                          additionalBenefitPerSupplier: additionalBenefit,
                        ),
                      ],
                    ),
                  ))
        ],
      ),
    );
  }
}
