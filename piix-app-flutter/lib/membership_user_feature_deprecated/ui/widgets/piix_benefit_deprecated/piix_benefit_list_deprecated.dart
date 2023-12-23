import 'package:flutter/material.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/piix_benefit_deprecated/piix_benefit_tile_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/piix_benefit_deprecated/piix_benefit_type_tile_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/responsive.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

/// This widget maps and displays all the combo additions that each type of membership
/// addition has.
class PiixBenefitListDeprecated extends StatelessWidget {
  const PiixBenefitListDeprecated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = Responsive.of(context);
    final membershipInfoBLoC = context.watch<MembershipProviderDeprecated>();
    final benefitsByTypes = membershipInfoBLoC.benefitsByTypes;

    return Card(
      elevation: 3,
      child: Column(
        children: benefitsByTypes.asMap().entries.map((benefitsByTypesEntry) {
          final index = benefitsByTypesEntry.key;
          final benefitsByType = benefitsByTypesEntry.value;
          final name = benefitsByType.name!;
          return Column(
            children: [
              Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                  listTileTheme:
                      ListTileTheme.of(context).copyWith(dense: true),
                ),
                child: ExpansionTile(
                  title: PiixBenefitTypeTileDeprecated(name: name),
                  collapsedIconColor: PiixColors.darkSkyBlue,
                  children: [
                    const Divider(color: Colors.grey),
                    ...benefitsByType.benefits!.asMap().entries.map((benefit) {
                      final index = benefit.key;
                      final benefitPerSupplier = benefit.value;
                      return Column(
                        children: [
                          PiixBenefitTileDeprecated(
                              benefitPerSupplier: benefitPerSupplier),
                          if (index != benefitsByType.benefits!.length - 1)
                            const Divider(height: 7, color: Colors.grey),
                        ],
                      ).padHorizontal(16);
                    }).toList()
                  ],
                ),
              ),
              if (index != benefitsByTypes.length - 1) const Divider(),
              if (index == benefitsByTypes.length - 1)
                SizedBox(height: screenSize.hp(1)),
            ],
          );
        }).toList(),
      ),
    );
  }
}
