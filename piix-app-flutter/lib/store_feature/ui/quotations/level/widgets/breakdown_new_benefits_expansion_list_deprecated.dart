import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/levels_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/level/widgets/new_benefit_expansion_container_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a breakdown new benefits level expansion list
///
class BreakdownNewBenefitsExpansionListDeprecated extends StatelessWidget {
  const BreakdownNewBenefitsExpansionListDeprecated({super.key});

  Color get greyWhite => PiixColors.greyWhite;
  Color get darkSkyBlue => PiixColors.darkSkyBlue;

  @override
  Widget build(BuildContext context) {
    final levelsBLoC = context.read<LevelsBLoCDeprecated>();
    final newBenefits =
        levelsBLoC.levelQuotation!.comparisonInformation.newBenefits;
    return newBenefits.isEmpty
        ? const SizedBox()
        : Theme(
            data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
                listTileTheme: ListTileTheme.of(context).copyWith(dense: true)),
            child: ExpansionTile(
              collapsedBackgroundColor: greyWhite,
              backgroundColor: greyWhite,
              textColor: PiixColors.infoDefault,
              iconColor: darkSkyBlue,
              collapsedIconColor: darkSkyBlue,
              title: Text(
                PiixCopiesDeprecated.breakdownNewBenefits,
                style: context.primaryTextTheme?.headlineSmall,
              ),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: newBenefits.map((newBenefit) {
                final index = newBenefits.indexOf(newBenefit) + 1;
                return NewBenefitExpansionContainerDeprecated(
                  index: index,
                  benefitPerSupplier: newBenefit,
                );
              }).toList(),
            ),
          );
  }
}
