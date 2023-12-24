import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';

///A composed Widget to show a [ListTile] with an [AppRadioButton].
///
///This [ListTile] only accepts classes that implement [IAppListTileButton]
///for it's [leading] value.
///To check any property passed please refer to the [ListTile] documentation.
final class AppListTileButton extends StatelessWidget {
  const AppListTileButton({
    super.key,
    this.isThreeLine = false,
    this.enabled = true,
    this.selected = false,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.horizontalTitleGap = 0,
    this.minVerticalPadding,
    this.minLeadingWidth,
  });

  final bool isThreeLine;

  final bool enabled;

  final bool selected;

  ///If you require a [ListTile]
  ///with another [Widget] please call
  ///[ListTile] directly.
  final IAppListTileButton? leading;

  final Widget? title;

  final Widget? subtitle;

  final Widget? trailing;

  final VoidCallback? onTap;

  final VoidCallback? onLongPress;

  final double? horizontalTitleGap;

  final double? minVerticalPadding;

  final double? minLeadingWidth;

  ///If the tile cannot be pressed it returns the disabled color
  Color? get _selectedColor {
    if (!enabled || (onTap == null && onLongPress == null))
      return PiixColors.inactive;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: isThreeLine,
      enabled: enabled,
      selected: selected,
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      onTap: onTap,
      onLongPress: onLongPress,
      horizontalTitleGap: horizontalTitleGap,
      minVerticalPadding: minVerticalPadding,
      minLeadingWidth: minLeadingWidth,
      selectedColor: _selectedColor,
    );
  }
}
