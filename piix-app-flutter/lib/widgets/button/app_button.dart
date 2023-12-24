import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/widgets/button/ipersistent_select_button.dart';

///The base class to create a button for the app.
///
///If the state of a pressed button wants to be
///persisted to let the user know what buttons have been
///pressed already set true to [keepSelected].
///
///This button can also pass the [loading] paremeter which
///can be used to let subclasses of AppButton know when
///a service is being loaded.
abstract class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.keepSelected = false,
    this.loading = false,
    this.iconData,
    this.height,
    this.maxWidth,
    this.minWidth,
    this.style,
  });

  final String text;

  ///Set to true to persist the
  ///active state of the button.
  final bool keepSelected;

  ///Set to true or false when this button
  ///depends and waits for service to finish loading.
  final bool? loading;

  ///Pass an icon if the [icon] version of the
  ///button is to be built.
  final IconData? iconData;

  ///An optional callback execution when pressing the button,
  ///if not callback is passed, the button is disabled.
  final VoidCallback? onPressed;

  ///The height of the button.
  final double? height;

  ///The maximum width constraint for the button
  final double? maxWidth;

  ///The minimum width constraint for the button
  final double? minWidth;

  ///Pass this value to overwrite the [ButtonStyleButton] default
  ///style in [ThemeData].
  final ButtonStyle? style;
}

abstract class AppButtonState<T extends AppButton> extends State<AppButton>
    implements IPersistentSelectButton {
  ///Persist the active state of this.
  bool selected = false;

  ///Converts the nullable loading value to boolean value
  bool get loading => widget.loading ?? false;

  ///A wrapper method that maintains the logic that if no
  ///onPressed is passed then it disables the button.
  VoidCallback? get onButtonPressed {
    if (widget.onPressed == null) return null;

    ///Checks if the button should [keepSelected]
    ///attribute and executes [onPressed] callback.
    return () {
      if (widget.keepSelected) {
        setState(() {
          selected = !selected;
        });
      }
      widget.onPressed!.call();
    };
  }

  ///Returns a cloned copy of [style] with the modified
  ///colors only if [selected] is true.
  ///
  ///If not it returns [style] as it is.
  @override
  ButtonStyle? onSelected(
    ButtonStyle? style, {
    Color backgroundColor = PiixColors.primary,
    Color foregroundColor = PiixColors.space,
  }) {
    if (selected)
      return style?.copyWith(
        backgroundColor: MaterialStatePropertyAll<Color>(backgroundColor),
        foregroundColor: MaterialStatePropertyAll<Color>(foregroundColor),
        //Prevents any [Ink] splashing of button
        splashFactory: NoSplash.splashFactory,
      );
    return style;
  }
}
