import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

///A simple header used in [UserMembershipCardContent].
final class UserMembershipCardHeader extends StatelessWidget {
  const UserMembershipCardHeader({super.key});

  ///The color of the [Text].
  Color get _color => PiixColors.space;

  ///Retrieves the header value.
  String _getHeader(BuildContext context) =>
      '${context.localeMessage.piixMembership}';
  ///Retrieves the [TextStyle].
  TextStyle? _getTextStyle(BuildContext context) =>
      context.primaryTextTheme?.titleMedium?.copyWith(color: _color);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Text(
        _getHeader(context),
        style: _getTextStyle(context),
        textAlign: TextAlign.start,
      ),
    );
  }
}
