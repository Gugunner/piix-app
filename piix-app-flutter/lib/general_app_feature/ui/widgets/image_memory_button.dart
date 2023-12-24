import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/shimmer/shimmer.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_loading.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_wrap.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';



//TODO: Revise the class architecture and refactor for 4.0
///This widget is a template for an image memory button.
///receives a [Uint8List] image, height, placeholder and onTap function
///
class ImageMemoryButton extends StatelessWidget {
  const ImageMemoryButton({
    super.key,
    this.imageMemory,
    this.height,
    this.width,
    this.onTap,
    this.placeholder,
    this.boxFit,
    this.circleColor,
    this.usePlaceHolder = false,
    this.hasCircularImage = false,
    this.isLoading = false,
  });
  final VoidCallback? onTap;
  final Uint8List? imageMemory;
  final double? height;
  final double? width;
  final String? placeholder;
  final BoxFit? boxFit;
  final Color? circleColor;
  final bool usePlaceHolder;
  final bool hasCircularImage;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: ShimmerLoading(
        isLoading: isLoading,
        child: GestureDetector(
          onTap: onTap,
          child: Align(
            child: Builder(builder: (context) {
              if (usePlaceHolder ||
                  imageMemory == null ||
                  imageMemory!.isEmpty) {
                return ShimmerWrap(
                  shape:
                      hasCircularImage ? BoxShape.circle : BoxShape.rectangle,
                  child: Image.asset(
                    placeholder ?? PiixAssets.membershipPlaceHolder,
                    height: height,
                    width: width,
                    fit: boxFit ?? BoxFit.cover,
                  ),
                );
              }
              return ShimmerWrap(
                shape: hasCircularImage ? BoxShape.circle : BoxShape.rectangle,
                child: ClipRRect(
                  borderRadius: hasCircularImage
                      ? BorderRadius.circular(width ?? 45.w)
                      : BorderRadius.zero,
                  child: ColoredBox(
                    color: circleColor ?? PiixColors.white,
                    child: Image.memory(
                      imageMemory!,
                      height: height,
                      width: width,
                      fit: boxFit ?? BoxFit.cover,
                      errorBuilder: (context, exception, stackTrace) {
                        return Image.asset(
                          placeholder ?? PiixAssets.membershipPlaceHolder,
                          height: height ?? 25.h,
                          fit: boxFit ?? BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
