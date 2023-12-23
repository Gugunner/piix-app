import 'package:flutter/src/widgets/framework.dart';
import 'package:piix_mobile/widgets/button/app_button_deprecated.dart';
import 'package:piix_mobile/widgets/button/outlined_app_button/outlined_app_button_deprecated.dart';
import 'package:piix_mobile/widgets/button/state_app_button_deprecated.dart';

@Deprecated('Use instead AppOutlinedSizedButton')

///The button class to handle any [OutlinedAppButton] [clicked] state.
class StateOutlinedAppButton extends StateAppButton {
  const StateOutlinedAppButton({
    super.key,
    required super.text,
    required super.onClicked,
    super.isMain,
    super.loading,
    super.icon,
    super.buttonStyle,
  });

  @override
  State<StatefulWidget> createState() => _StateOutlinedAppButtonState();
}

class _StateOutlinedAppButtonState
    extends StateAppButtonState<StateOutlinedAppButton> {
  @override
  OldAppButton build(BuildContext context) {
    return OutlinedAppButtonDeprecated(
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
