import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/tag/app_tag.dart';

///A composed [Tag] that shows whether a membership is
///[active] or [inactive].
class MembershipStatusTag extends StatelessWidget {
  const MembershipStatusTag(this.isActive, {super.key});

  final bool isActive;

  ///Returns the [active] message.
  String _getActiveMessage(BuildContext context) =>
      context.localeMessage.active;

  ///Returns the [inactive] message.
  String _getInactiveMessage(BuildContext context) =>
      context.localeMessage.inactive;

  ///Returns an [active] or [inactive] depending if the membersip [isActive].
  String _getMembershipStatusMessage(BuildContext context) =>
      isActive ? _getActiveMessage(context) : _getInactiveMessage(context);

  ///The color of the [Tag] that changes depending if membership [isActive].
  Color get _tagColor => isActive ? PiixColors.success : PiixColors.secondary;

  @override
  Widget build(BuildContext context) {
    return Tag.actionable(
      _tagColor,
      label: _getMembershipStatusMessage(context),
      action: null,
    );
  }
}
