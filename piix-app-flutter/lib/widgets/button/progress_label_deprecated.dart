import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';

///Returns either a [Text] or a [CircularProgressIndicator]
///if the button is main or small.
///
///Use with any [AppButton].
@immutable
class ProgressLabel extends StatelessWidget {
  const ProgressLabel({
    super.key,
    this.isMain = true,
    this.textStyle,
    this.progressColor,
  });
  final bool isMain;
  final TextStyle? textStyle;
  final Color? progressColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ProgressLabelIndicator(
          progressColor: progressColor,
        ),
        if (isMain) ...[
          SizedBox(
            width: 8.w,
          ),
          Flexible(
            child: Container(
              margin: EdgeInsets.only(
                left: 12.w,
              ),
              child: Text(
                PiixCopiesDeprecated.loadingButton.toUpperCase(),
                style: textStyle,
              ),
            ),
          ),
        ]
      ],
    );
  }
}

@immutable
class _ProgressLabelIndicator extends StatelessWidget {
  const _ProgressLabelIndicator({
    this.progressColor,
  });

  final Color? progressColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 14.sp,
      width: 14.sp,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: progressColor,
      ),
    );
  }
}
