import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/color_utils.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';

///An app wrapper button that allows to call all original
///Flutter Material [Switch] widgets with a scalable size approach.
final class AppSwitchButton extends Switch implements IAppListTileButton {
  const AppSwitchButton({
    super.key,
    required super.value,
    required super.onChanged,
    super.autofocus,
    super.dragStartBehavior,
    super.activeColor,
    super.activeTrackColor,
    super.inactiveThumbColor,
    super.inactiveTrackColor,
    super.activeThumbImage,
    super.onActiveThumbImageError,
    super.inactiveThumbImage,
    super.onInactiveThumbImageError,
    super.thumbColor,
    super.trackColor,
    super.trackOutlineColor,
    super.thumbIcon,
    super.materialTapTargetSize,
    super.mouseCursor,
    super.focusColor,
    super.hoverColor,
    super.overlayColor,
    super.splashRadius,
    super.focusNode,
    super.onFocusChange,
    this.scaleX = 1.4,
    this.scaleY = 1.2,
    this.scale,
  });

  ///The default value scale in the X dimension that
  ///is used by the app general design.
  final double? scaleX;

  ///The default value scale in the Y dimension that
  ///is used by the app general design.
  final double? scaleY;

  ///Modify this value to increase or decrease
  ///the size of the radio.
  final double? scale;

  ///Returns the color for the thumb in the switch button.
  ///
  ///Has a special condition when the switch button is disabled
  ///but the [value] is set to true.
  Color _getAppThumbColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.focused) ||
        states.contains(MaterialState.hovered) ||
        states.contains(MaterialState.selected)) {
      //Show an adequate color for the thumb color
      //when disabled but [value] is true
      if (onChanged == null) {
        return ColorUtils.lighten(PiixColors.active, 0.2);
      }
      return PiixColors.active;
    }
    return PiixColors.sky;
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scaleX: scaleX,
      scaleY: scaleY,
      scale: scale,
      child: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        autofocus: autofocus,
        dragStartBehavior: dragStartBehavior,
        activeColor: activeColor,
        activeTrackColor: activeTrackColor,
        inactiveTrackColor: inactiveTrackColor,
        inactiveThumbColor: inactiveThumbColor,
        activeThumbImage: activeThumbImage,
        onActiveThumbImageError: onActiveThumbImageError,
        inactiveThumbImage: inactiveThumbImage,
        onInactiveThumbImageError: onInactiveThumbImageError,
        thumbColor: thumbColor ??
            MaterialStateProperty.resolveWith<Color>(_getAppThumbColor),
        trackColor: trackColor,
        trackOutlineColor: trackOutlineColor,
        thumbIcon: thumbIcon,
        materialTapTargetSize: materialTapTargetSize,
        mouseCursor: mouseCursor,
        focusColor: focusColor,
        hoverColor: hoverColor,
        overlayColor: overlayColor,
        splashRadius: splashRadius,
        focusNode: focusNode,
        onFocusChange: onFocusChange,
      ),
    );
  }
}
