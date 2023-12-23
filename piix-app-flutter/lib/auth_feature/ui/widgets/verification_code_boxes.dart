import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_feature/auth_ui_barrel_file.dart';

///Builds a number of [VerificationCodeBox] based in the [_numberOfBoxes].
///
///Passes the [onChanged] method to each [VerificationCodeBox]
///with their corresponding index value.
///Passes the same [validator] to each [VerificationCodeBox].
final class VerificationCodeBoxes extends StatelessWidget {
  const VerificationCodeBoxes({
    super.key,
    required this.onChanged,
    required this.validator,
  });

  ///The callback which needs the index and
  ///value passed by each [VerificationCodeBox].
  final Function(int, String) onChanged;

  ///Uses the same validator from the parent for each
  ///[VerificationCodeBox].
  final String? Function(String?) validator;

  ///The predefined number of [VerificationCodeBox]
  ///to build.
  int get _numberOfBoxes => 6;

  double get _width => 288.w;

  ///The space between each [VerificationCodeBox]
  ///horizontally.
  double get _gap => 9.w;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(_numberOfBoxes, (index) {
          return Flexible(
            child: Container(
              margin: EdgeInsets.only(right: index < _numberOfBoxes ? _gap : 0),
              child: VerificationCodeBox(
                index: index,
                onChanged: onChanged,
                validator: validator,
              ),
            ),
          );
        }),
      ),
    );
  }
}
