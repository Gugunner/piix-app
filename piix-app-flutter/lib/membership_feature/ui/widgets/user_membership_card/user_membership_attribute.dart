import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';


///An abstract base class that builds a specific formatted key, value
///inline [TextSpan]. 
abstract base class UserMembershipAttribute extends StatelessWidget {
  const UserMembershipAttribute({
    super.key,
    required this.keyAttribute,
    required this.value,
  });

  ///The key before the colon ':'.
  final String keyAttribute;
  ///The text value after the colon ':'.
  final String value;

  ///The color of the [TextSpan].
  Color get _color => PiixColors.space;
  ///The maximum number of lines the combination of
  ///[keyAttribute] and [value] can ocuppy.
  int get _maxLines => 2;
  ///Retrieves the [TextStyle] for the [TextSpan] containint the [keyAttribute].
  TextStyle? _getKeyTextStyle(BuildContext context) =>
      context.primaryTextTheme?.titleMedium?.copyWith(color: _color);
  ///Retrieves the [TextStyle] for the [TextSpan] containint the [value].
  TextStyle? _getValueTextStyle(BuildContext context) =>
      context.bodyMedium?.copyWith(color: _color);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Text.rich(
        TextSpan(
            text: '$keyAttribute: ',
            style: _getKeyTextStyle(context),
            children: [
              TextSpan(
                text: value,
                style: _getValueTextStyle(context),
              ),
            ]),
        textAlign: TextAlign.start,
        maxLines: _maxLines,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
