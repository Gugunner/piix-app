import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

///A predefined [Text] composed widget that returns the
///label "Piix ©2023" with the current year.
final class CopyRightLabel extends StatelessWidget {
  const CopyRightLabel({super.key});

  ///The color of the [Text].
  Color get _color => PiixColors.space;

  ///Returns the value of "Piix ©2023" with the current year.
  String _getCopyRightMessage(BuildContext context) =>
      context.localeMessage.copyRight(currentYear());

  @override
  Widget build(BuildContext context) {
    return Text(
      _getCopyRightMessage(context),
      style: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 9.sp,
        letterSpacing: -0.09,
        color: _color,
      ),
    );
  }
}
