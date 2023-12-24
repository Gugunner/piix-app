import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/file_feature/file_model_barrel_file.dart';
import 'package:piix_mobile/form_feature/ui/widgets/documentation_camera_form_field/documentation_camera_barrel_file.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

///Shows the pictures the [first] and [last] picture taken
///inside a card styled [Widget].
final class UserPicturesCard extends StatelessWidget {
  const UserPicturesCard(this.pictures, {super.key});

  final List<FileContentModel> pictures;

  @override
  Widget build(BuildContext context) {
    final base64Pictures =
        pictures.map((picture) => base64Decode(picture.base64Content)).toList();
    return Container(
      width: context.width,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.w),
        color: PiixColors.space,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: PiixColors.contrast30.withOpacity(0.1),
            spreadRadius: 0.5,
            blurRadius: 0.5,
            offset: const Offset(0, 0.1),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            width: context.width,
            child: Column(
              children: [
                SizedBox(
                  child: Text(
                    context.localeMessage.officialIdentificationImage,
                    style: context.bodyMedium?.copyWith(
                      color: PiixColors.infoDefault,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                _CustomPicturePaint(base64Pictures.first),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: context.width,
            child: Column(
              children: [
                SizedBox(
                  child: Text(
                    context
                        .localeMessage.selfieBesideYourOfficialIdentification,
                    style: context.bodyMedium?.copyWith(
                      color: PiixColors.infoDefault,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                _CustomPicturePaint(base64Pictures.last),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomPicturePaint extends StatelessWidget {
  const _CustomPicturePaint(this.imageData);

  final Uint8List imageData;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RoundOutlinedDashedBorderPainter(
        color: PiixColors.contrast,
        strokeWidth: 1.w,
        dashLength: 8.w,
        gap: 4.w,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.w),
        child: Transform.scale(
          scaleX: -1,
          child: Image.memory(
            imageData,
            width: 121.w,
            height: 98.h,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              //TODO: Change to UI placeholder when ready
              return const Placeholder();
            },
          ),
        ),
      ),
    );
  }
}
