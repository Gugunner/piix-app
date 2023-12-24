import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/general_app_feature/utils/responsive.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/utils/piix_memberships_util_deprecated.dart';

@Deprecated('Will be removed in 4.0')
class PiixBenefitTypeTileDeprecated extends StatelessWidget {
  const PiixBenefitTypeTileDeprecated({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    final screenSize = Responsive.of(context);
    return Row(
      children: [
        Icon(
          getBenefitTypeIcon(name),
          color: PiixColors.twilightBlue,
        ),
        Container(
          margin: EdgeInsets.only(left: screenSize.wp(4.4)),
          child: Text(
            name,
            style: context.textTheme?.headlineSmall,
          ),
        ),
      ],
    );
  }
}
