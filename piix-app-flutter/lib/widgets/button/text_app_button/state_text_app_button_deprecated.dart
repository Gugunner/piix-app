import 'package:flutter/src/widgets/framework.dart';
import 'package:piix_mobile/widgets/button/app_button_deprecated.dart';
import 'package:piix_mobile/widgets/button/state_app_button_deprecated.dart';
import 'package:piix_mobile/widgets/button/text_app_button/text_app_button_deprecated.dart';

@Deprecated('Use instead AppTextSizedButton')
class StateTextAppButton extends StateAppButton {
  const StateTextAppButton({
    super.key,
    required super.text,
    required super.onClicked,
    this.type = 'one',
    super.isMain,
    super.loading,
    super.icon,
    super.buttonStyle,
  });

  ///Controls if the botton should handle type 'one' or 'two'
  ///for the fontSize.
  ///Will not work if [buttonStyle] is declared.
  final String type;

  @override
  State<StatefulWidget> createState() => _StateTextAppButtonState();
}

class _StateTextAppButtonState extends StateAppButtonState<StateTextAppButton> {
  @override
  OldAppButton build(BuildContext context) {
    return TextAppButtonDeprecated(
      text: widget.text,
      type: widget.type,
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
