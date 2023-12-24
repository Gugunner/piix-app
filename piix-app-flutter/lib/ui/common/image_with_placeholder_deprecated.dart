import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';

@Deprecated('Will be removed in 4.0')

/// This widget render a fade in image whit a dynamic place holder.
class ImageWithPlaceholderDeprecated extends StatelessWidget {
  const ImageWithPlaceholderDeprecated(
      {Key? key, this.urlImage, this.height, this.width, this.type})
      : super(key: key);

  final String? urlImage;
  final double? width;
  final double? height;
  final String? type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 14.h),
      child: urlImage == null
          ? Image.asset(
              type == 'level' || type == 'levelH'
                  ? PiixAssets.placeholderLevel
                  : PiixAssets.placeholderBen,
              fit: BoxFit.fitWidth,
              height: height ?? 200.h,
              width: width ?? 100,
            )
          : RotatedBox(
              quarterTurns: type == 'levelH' ? 1 : 0,
              child: urlImage!.isEmpty
                  ? Image.asset(
                      type == 'level' || type == 'levelH'
                          ? PiixAssets.placeholderLevel
                          : PiixAssets.placeholderBen,
                      fit: BoxFit.fitWidth,
                      height: height ?? 200.h,
                      width: width ?? 100,
                    )
                  : Image.memory(
                      base64Decode(urlImage!),
                      errorBuilder: (context, exception, stackTrace) {
                        return Image.asset(PiixAssets.placeholderBen);
                      },
                      height: height ?? 200.h,
                      width: width ?? 100.w,
                      fit: BoxFit.contain,
                    ),
            ),
    );
  }
}
