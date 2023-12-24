import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

///An empty formatted content when the user has no membership.
final class BlankMembershipCardContent extends StatelessWidget {
  const BlankMembershipCardContent({super.key});

  ///Returns the message to explain a blank membership.
  String _getMessage(BuildContext context) =>
      context.localeMessage.blankMembership;
  ///The color of the logo, [Text] and [Icon]s.
  Color get _color => PiixColors.contrast;
  ///The style for the message.
  TextStyle? _getTextStyle(BuildContext context) =>
      context.bodyMedium?.copyWith(color: _color);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: context.width * 0.5,
        child: Text(
          _getMessage(context),
          style: _getTextStyle(context),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
