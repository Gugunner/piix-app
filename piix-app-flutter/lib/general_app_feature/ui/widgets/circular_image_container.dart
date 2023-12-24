import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';

///This widget is a circular image container,
///Receives a image url path and size
///
class CircularImageContainer extends StatelessWidget {
  const CircularImageContainer({
    super.key,
    this.pathImage,
    this.sizeImage = 160,
  });
  final String? pathImage;
  final double sizeImage;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(sizeImage.h),
      child: ColoredBox(
        color: PiixColors.lightGray,
        child: Builder(
          builder: (BuildContext context) {
            if (pathImage.isNotNullEmpty) {
              return Image.memory(
                base64Decode(pathImage!),
                errorBuilder: (context, exception, stackTrace) {
                  return Image.asset(PiixAssets.placeholderProv);
                },
                height: sizeImage.h,
                width: sizeImage.h,
              );
            }
            return Image.asset(
              PiixAssets.placeholderProv,
              fit: BoxFit.contain,
              height: sizeImage.h,
              width: sizeImage.h,
            );
          },
        ),
      ),
    );
  }
}
