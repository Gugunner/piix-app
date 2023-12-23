import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/piix_camera_copies.dart';

@Deprecated('Will be removed in 4.0')
class PreviewImageErrorWidgetDeprecated extends StatelessWidget {
  const PreviewImageErrorWidgetDeprecated({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            PiixCameraCopiesDeprecated.noImageToVisualize,
            style: context.labelLarge?.copyWith(
              color: PiixColors.white,
              height: 12.sp / 12.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 8.h,
          ),
          SizedBox(
            width: context.width * 0.16,
            height: context.width * 0.16,
            child: const Placeholder(
              color: PiixColors.greyWhite,
            ),
          ),
        ],
      ),
    );
  }
}
