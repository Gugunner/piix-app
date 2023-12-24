import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

@Deprecated('Will be removed in 6.0')

///The widget can oly be used inside a [PiixObjectSelectDropDownButton] as it is a simple addition
///of a [Radio] widget.
class PiixDropdownMenuRadioDeprecated extends StatelessWidget {
  const PiixDropdownMenuRadioDeprecated({
    Key? key,
    required this.value,
    this.groupValue,
  }) : super(key: key);

  ///The [value] that relates to the [Radio] widget.
  final String value;

  ///The current selected [value] which is inserted in all the [Radio] widgets
  ///of the same group.
  final String? groupValue;

  ///Given a nullable lis of ```MaterialStateProperty<Color>``` if the state is
  ///considered a clickable state then it returns [azure] color else returns [grey].
  Color selectedRadio(states) {
    const interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
      MaterialState.selected,
    };
    if (states.any(interactiveStates.contains)) {
      return PiixColors.insurance;
    }
    return PiixColors.infoDefault;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 4.h, top: 0, left: 0),
      child: Radio<String>(
        value: value,
        groupValue: groupValue,
        fillColor: MaterialStateProperty.resolveWith(selectedRadio),
        //onChanged is handled by the [DropdownButtonFormField]
        onChanged: (_) {},
      ),
    );
  }
}
