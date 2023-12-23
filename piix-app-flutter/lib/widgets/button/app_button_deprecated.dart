import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Use instead AppButton')

///The base [StatelessWidget] class for the properties used
///in the app buttons.
abstract class OldAppButton extends StatelessWidget {
  const OldAppButton({
    super.key,
    required this.text,
    this.loading = false,
    this.clicked = false,
    this.isMain = true,
    this.onPressed,
    this.icon,
    this.buttonStyle,
  });

  ///All buttons need to have a text
  final String text;

  ///This allows to show a [CircularProgressIndicator] widget
  ///inside the button when a user is waiting after pressing the button.
  final bool loading;

  ///Signals that a button has been clicked showing a specific [ButtonStyle].
  final bool clicked;

  ///Controls if the button is main style or small style.
  ///This changes the [TextStyle] and [icon] size of the button.
  final bool isMain;

  ///An optional element to handle a callback when the button is pressed.
  ///If null the button is disabled.
  final VoidCallback? onPressed;

  ///The icon to be shown as a prefix to the button [text].
  ///Changes it size depending on the [isMain] value.
  final IconData? icon;

  ///In specific cases use it to override the main or small button [testStyle].
  final ButtonStyle? buttonStyle;

  ///Selects the approriate color when the button [clicked] property is handled
  Color get clickedColor => clicked ? PiixColors.primary : PiixColors.active;

  ///Determines the minimum width for the button.
  double get minWidth {
    if (isMain) return icon == null ? 168.w : 176.w;
    return icon == null ? 68.w : 84.w;
  }

  ///The default style used for any app button, override it to
  ///add more styles.
  TextStyle? textStyle(BuildContext context) {
    if (!isMain) return context.primaryTextTheme?.titleMedium;
    return context.accentTextTheme?.labelMedium;
  }

  ///The default styles to be used for any button,
  ///this can be override by passing in a [buttonStyle]
  ///argument.
  ButtonStyle? style(BuildContext context) => throw UnimplementedError();
}

abstract class ProgressAppButtonLoader extends StatelessWidget {
  const ProgressAppButtonLoader({
    super.key,
    this.isMain = true,
  });

  final bool isMain;

  @override
  ButtonStyleButton build(BuildContext context);
}
