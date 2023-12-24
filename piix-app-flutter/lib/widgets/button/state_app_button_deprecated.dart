import 'package:flutter/material.dart';
import 'package:piix_mobile/widgets/button/app_button_deprecated.dart';

///The base [Stateful] class for the properties used
///in the app buttons.
abstract class StateAppButton extends StatefulWidget {
  const StateAppButton({
    super.key,
    required this.text,
    required this.onClicked,
    this.isMain = true,
    this.loading = false,
    this.icon,
    this.buttonStyle,
  });

  ///All buttons need to have a text
  final String text;

  ///A callback that must return a boolean value which sets the [clicked]
  ///state of any [StateAppButtonState] button.
  final bool Function() onClicked;

  ///This allows for showing a [CircularProgressIndicator] widget
  ///inside the button when a user is waiting after pressing the button.
  final bool loading;

  ///Controls if the button is main style or small style.
  ///This changes the [TextStyle] and [icon] size of the button.
  final bool isMain;

  ///The icon to be shown as a prefix to the button [text].
  ///Changes it size depending on the [isMain] value.
  final IconData? icon;

  ///In specific cases use it to override the main or small button [testStyle].
  final ButtonStyle? buttonStyle;
}

///The base [State] class for any [OldAppButton] that needs to handle it's own
///[clicked] state.
abstract class StateAppButtonState<T extends StateAppButton> extends State<T> {
  ///Manages the state of a button after being pressed.
  bool clicked = false;

  ///This method can be called in the [onPressed] property of any [OldAppButton]
  ///to get the appropriate value for clicked.
  ///No need to override it as any additional logic can be added inside the
  ///[onClicked] widget property
  void handleOnClicked() => setState(() {
        clicked = widget.onClicked.call();
      });

  ///Use to build any [OldAppButton] that handles a [clicked] state
  @override
  OldAppButton build(BuildContext context);
}
