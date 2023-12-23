import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/state_machine.dart';

@Deprecated('Will be removed in 4.0')
//TODO: Add documentation
class PiixCameraCancelButtonDeprecated extends StatelessWidget {
  const PiixCameraCancelButtonDeprecated({
    Key? key,
    this.backgroundColor,
    this.state,
  }) : super(key: key);

  final Color? backgroundColor;
  final StateMachine? state;

  //TODO: Explain getter
  double get diameter => 40;

  //TODO: Explain getter
  double get size => diameter - 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: context.height * 0.046,
      ),
      padding: EdgeInsets.zero,
      width: diameter.h,
      height: diameter.h,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: PiixColors.white.withOpacity(0.25),
          boxShadow: [
            BoxShadow(
              color: PiixColors.grey.withOpacity(0.25),
            ),
          ]),
      //Close button
      child: Center(
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.pop(context, state);
          },
          icon: Icon(
            Icons.close,
            color: PiixColors.grey_white2,
            size: size.h,
          ),
        ),
      ),
    );
  }
}
