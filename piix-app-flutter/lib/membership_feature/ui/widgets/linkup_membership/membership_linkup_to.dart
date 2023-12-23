import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/membership_feature/membership_model_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

final class MembershipLinkupTo extends StatelessWidget {
  const MembershipLinkupTo(this.linkupCodeType, {super.key});

  final LinkupCodeTypeModel linkupCodeType;

  String get _name => linkupCodeType.name;

  LinkupCodeType get _linkType => linkupCodeType.type;

  String _getLinkUpToMessage(BuildContext context) =>
      '${context.localeMessage.linkUpTo(_linkType.getTypeName(context))}:';

  String _getIfNotYourMembershipLinkageMessage(BuildContext context) => context
      .localeMessage
      .ifNotYourMembershipLinkage(_linkType.getTypeName(context).toLowerCase());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          _getLinkUpToMessage(context),
          style: context.primaryTextTheme?.headlineSmall?.copyWith(
            color: PiixColors.primary,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          _name,
          style: context.accentTextTheme?.titleMedium?.copyWith(
            color: PiixColors.infoDefault,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          _getIfNotYourMembershipLinkageMessage(context),
          style: context.accentTextTheme?.labelSmall?.copyWith(
            color: PiixColors.primary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
