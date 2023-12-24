import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

///Shows a [Row] where the children are the [userProperty] and the 
///[userValue] in the same line.
final class UserPersonalInformationRow extends StatelessWidget {
  const UserPersonalInformationRow({
    super.key,
    required this.userProperty,
    this.userValue = '',
  });

  final String userProperty;

  final String userValue;

  TextStyle? _getProperyStyle(BuildContext context) =>
      context.primaryTextTheme?.titleSmall
          ?.copyWith(color: PiixColors.infoDefault);

  TextStyle? _getValueStyle(BuildContext context) =>
      context.accentTextTheme?.titleMedium
          ?.copyWith(color: PiixColors.infoDefault);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child: Text(
            userProperty,
            style: _getProperyStyle(context),
          )),
          Flexible(
              child: Text(
            userValue.isEmpty ? '-' : userValue,
            style: _getValueStyle(context),
          )),
        ],
      ),
    );
  }
}
