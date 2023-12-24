import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/piix_camera_copies.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

@Deprecated('Will be removed in 4.0')
class PiixPictureThumbnailSelectionCardDeprecated extends ConsumerWidget {
  const PiixPictureThumbnailSelectionCardDeprecated({
    Key? key,
    required this.image,
    required this.index,
    required this.onDelete,
  }) : super(key: key);

  //TODO: Explain property
  final XFile image;
  //TODO: Explain property
  final int index;
  //TODO: Explain property
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Create a random index that changes seed based on the picture index with a possibility of 10000 values
    //This is a safe guard if the path cannot be
    ref.watch(formNotifierProvider);
    final randomIndex = Random(index).nextInt(10000);
    return SizedBox(
      width: context.width,
      height: context.height,
      child: Card(
        color: PiixColors.white,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          side: BorderSide(
            width: 1.0,
            color: PiixColors.greyWhite,
          ),
        ),
        child: Dismissible(
          key: ValueKey('${image.path} - $randomIndex'),
          onDismissed: (_) => onDelete.call(),
          direction: DismissDirection.endToStart,
          background: Container(
            width: context.width * 0.518,
            padding: EdgeInsets.all(32.sp),
            decoration: const BoxDecoration(
              color: PiixColors.errorText,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.delete_sweep_outlined,
                color: PiixColors.white,
                size: 24.h,
              ),
            ),
          ),
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 32.h,
                  ),
                  child: Text(
                    'Foto ${index + 1}',
                    style: context.headlineLarge?.copyWith(
                      color: PiixColors.mainText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Container(
                    width: context.width,
                    height: context.height,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                    ),
                    child: Image.file(
                      File(image.path),
                      errorBuilder: (context, obj, error) {
                        //Safe guard if image can't be loaded
                        return const Placeholder();
                      },
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => onDelete.call(),
                  child: Text(
                    PiixCameraCopiesDeprecated.erase,
                    style: context.labelLarge?.copyWith(
                      color: PiixColors.errorText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
