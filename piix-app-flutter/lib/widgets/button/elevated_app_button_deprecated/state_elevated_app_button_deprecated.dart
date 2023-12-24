import 'package:flutter/material.dart';
import 'package:piix_mobile/widgets/button/app_button_deprecated.dart';
import 'package:piix_mobile/widgets/button/elevated_app_button_deprecated/elevated_app_button_deprecated.dart';
import 'package:piix_mobile/widgets/button/state_app_button_deprecated.dart';

@Deprecated('Will be removed in 4.0')
///The button class to handle any [ElevatedAppButton] [clicked] state.
class StateElevatedAppButtonDeprecated extends StateAppButton {
  const StateElevatedAppButtonDeprecated({
    super.key,
    required super.text,
    required super.onClicked,
    super.isMain,
    super.loading,
    super.icon,
    super.buttonStyle,
  });

  @override
  State<StatefulWidget> createState() => _StateElevatedAppButtonState();
}

class _StateElevatedAppButtonState
    extends StateAppButtonState<StateElevatedAppButtonDeprecated> {
  @override
  OldAppButton build(BuildContext context) {
    return ElevatedAppButtonDeprecated(
      text: widget.text,
      loading: widget.loading,
      clicked: clicked,
      //Calls [onClicked] method and sets the [clicked] base class state.
      onPressed: handleOnClicked,
      icon: widget.icon,
      buttonStyle: widget.buttonStyle,
      isMain: widget.isMain,
    );
  }
}
