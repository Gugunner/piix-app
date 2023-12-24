import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a image with a rounder borders, receives a memory image
///
class AdditionalBenefitImageContainerDeprecated extends StatelessWidget {
  const AdditionalBenefitImageContainerDeprecated({
    super.key,
    required this.imageMemory,
    this.imageHeight = 0,
    this.imageWidth = 0,
  });
  final String? imageMemory;
  final double imageHeight;
  final double imageWidth;

  @override
  Widget build(BuildContext context) {
    final additionalBenefitImage =
        imageMemory != null && imageMemory!.isNotEmpty
            ? Image.memory(
                base64Decode(imageMemory!),
                errorBuilder: (context, exception, stackTrace) {
                  return Image.asset(PiixAssets.placeholderBen);
                },
                height: imageHeight.h,
                width: imageWidth.w,
                fit: BoxFit.fitWidth,
              )
            : Image.asset(
                PiixAssets.placeholderBen,
                fit: BoxFit.fitWidth,
                height: imageHeight.h,
                width: imageWidth.w,
              );

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: additionalBenefitImage,
    );
  }
}
