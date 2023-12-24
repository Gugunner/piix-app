import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_banner_content_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_banner_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/piix_camera_copies.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';

//TODO: Transform into a Sealed class
enum PiixCameraError {
  cameraPermission(
      PiixCopiesDeprecated.cameraPermission, Icons.camera_alt_rounded),
  cameraNotFound(PiixCopiesDeprecated.cameraNotFound, Icons.no_photography),
  captureAlreadyActive(
      PiixCopiesDeprecated.captureAlreadyActive, Icons.question_mark),
  cannotCreateFile(PiixCopiesDeprecated.cannotCreateFile, Icons.folder_off),
  captureTimeout(PiixCopiesDeprecated.captureTimeout, Icons.question_mark),
  captureFailure(PiixCopiesDeprecated.captureFailure, Icons.no_photography),
  IOError(PiixCopiesDeprecated.IOError, Icons.no_sim),
  videoRecordingFailed(
      PiixCopiesDeprecated.videoRecordingFailed, Icons.videocam_off_rounded),
  setFlashModeFailed(PiixCopiesDeprecated.setFlashModeFailed, Icons.flash_off),
  setExposureModeFailed(
      PiixCopiesDeprecated.setExposureModeFailed, Icons.question_mark),
  setFocusModeFailed(
      PiixCopiesDeprecated.setFocusModeFailed, Icons.question_mark),
  setFocusPointFailed(
      PiixCopiesDeprecated.setFocusModeFailed, Icons.question_mark),
  ZOOM_ERROR(PiixCopiesDeprecated.zoomError, Icons.no_photography),
  maximumPhotosReached(
      PiixCopiesDeprecated.maximumPhotosReached, Icons.front_hand_rounded),
  unknownCameraError(
      PiixCopiesDeprecated.unknownCameraError, Icons.no_photography);

  final String description;
  final IconData icon;

  const PiixCameraError(this.description, this.icon);

  static void chooseCameraError(
    CameraException cameraException,
    BuildContext context,
  ) {
    final errorCode = cameraException.code;
    final cameraError = PiixCameraError.values.firstWhere(
        (ce) => ce.name == errorCode,
        orElse: () => PiixCameraError.unknownCameraError);
    showBannerError(cameraError, context);
  }

  static void showBannerError(
    PiixCameraError cameraError,
    BuildContext context,
  ) {
    final bannerInstance = PiixBannerDeprecated.instance;

    final banner = PiixBannerContentDeprecated(
      title: cameraError.description,
      iconData: Icons.close_rounded,
      cardBackgroundColor: PiixColors.errorText,
    );

    bannerInstance.builder(
      context,
      children: banner.build(context),
    );
  }
}

@Deprecated('Will be removed in 4.0')
class PiixMaximumPhotosSnackbarDeprecated extends StatelessWidget {
  const PiixMaximumPhotosSnackbarDeprecated({
    Key? key,
    required this.description,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
        horizontal: context.width * 0.087,
      ),
      height: context.width * 0.738,
      width: context.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              PiixCameraCopiesDeprecated.photoLimit,
              style: context.headlineLarge?.copyWith(
                color: PiixColors.twilightBlue,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 4.0,
            ),
            child: Text(
              description,
              style: context.titleSmall?.copyWith(
                color: PiixColors.mainText,
                height: 14.sp / 14.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 8.h,
              bottom: 0,
            ),
            height: context.height * 0.058,
            width: context.width * 0.375,
            child: ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style,
              onPressed: onPressed,
              child: Text(
                PiixCameraCopiesDeprecated.viewPhotos,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: PiixColors.white),
              ),
            ),
          ),
          TextButton(
            style: Theme.of(context).textButtonTheme.style,
            onPressed: () async {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            child: Text(
              PiixCopiesDeprecated.closeText,
              style: context.labelLarge?.copyWith(
                color: PiixColors.clearBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
