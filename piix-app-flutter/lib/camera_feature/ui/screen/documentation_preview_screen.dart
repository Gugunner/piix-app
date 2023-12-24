import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/camera_feature/camera_ui_barrel_file.dart';
import 'package:piix_mobile/camera_feature/camera_utils_barrel_file.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';

///Shows the user the picture preview that was just taken.
///
///Requires the temporal device [path] where the picture
///data is stored. To keep with appearances with what
///the user took a picture of the [cameraSilhouette] is
///again drawn over the picture.
///
///If the [path] is null or cannot be found a message with a
///go back button appears explaining the user that the picture
///could not be found and that she should try again.
final class DocumentationPreviewScreen extends StatelessWidget {
  const DocumentationPreviewScreen(
    this.imageData, {
    super.key,
    this.cameraSilhouette = CameraSilhouette.id,
  });

  final CameraSilhouette cameraSilhouette;

  final Uint8List imageData;

  ///Returns to the previous screen and passes false
  ///indicating that the picture was not approved for use
  ///by the user and should be discarded.
  void _retakePicture(BuildContext context) {
    Navigator.pop(context, false);
  }

  ///Returns to the previous screen and passes true
  ///indicating that the picture was approved for use
  ///by the user and should be saved.
  void _usePicture(BuildContext context) {
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    final aspectRatio = width / height;
    return Scaffold(
      body: SafeArea(
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: Image.memory(
            imageData,
            height: height,
            width: width,
            alignment: Alignment.center,
            fit: BoxFit.fill,
            frameBuilder: (frameContext, child, frame, wasSynchronouslyLoaded) {
              return Stack(
                children: [
                  Transform.scale(
                    scaleX:
                        cameraSilhouette == CameraSilhouette.selfie ? -1 : 1,
                    child: child,
                  ),
                  CustomPaint(
                    painter: CameraSilhouettePainter(
                      cameraSilhouette: cameraSilhouette,
                    ),
                    size: MediaQuery.of(context).size,
                  ),
                  Positioned(
                    top: 16.h,
                    left: 16.w,
                    child: SmallRoundControlButton(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        size: 24.w,
                        color: PiixColors.space,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 24.h,
                    child: SizedBox(
                      width: context.width,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: _RetakePictureCustomStyleButton(
                                onPressed: _retakePicture,
                              ),
                            ),
                            SizedBox(
                              child: AppFilledSizedButton(
                                //TODO: Change to localeMessage
                                text: 'Usar foto',
                                onPressed: () => _usePicture(context),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            errorBuilder: (_, __, ___) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      //TODO: Change to localeMessage
                      'Lo sentimos la imagen no se encontro, por favor vuelve a tomarla',
                      style: context.headlineSmall?.copyWith(
                        color: PiixColors.infoDefault,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h),
                    AppFilledSizedButton(
                      //TODO: Change to localeMessage
                      text: 'Tomar otra',
                      onPressed: () => _retakePicture(context),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

///Builds an [AppFilledSizedButton] with a cloned
///[ButtonStyle] of the default [FilledButtonThemeData]
///changing the [backgroundColor], [overlayColor],
///[foregroundColor] and [side].
final class _RetakePictureCustomStyleButton extends StatelessWidget {
  const _RetakePictureCustomStyleButton({
    required this.onPressed,
  });

  final Function(BuildContext) onPressed;

  @override
  Widget build(BuildContext context) {
    final activeColor = ColorUtils.darken(PiixColors.space, 0.1);
    return AppFilledSizedButton(
      text: 'Tomar otra',
      onPressed: () => onPressed.call(context),
      style: Theme.of(context).filledButtonTheme.style?.copyWith(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return PiixColors.inactive;
            }
            if (states.contains(MaterialState.pressed) ||
                states.contains(MaterialState.hovered) ||
                states.contains(MaterialState.selected)) {
              return activeColor;
            }
            return PiixColors.space;
          },
        ),
        overlayColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return PiixColors.inactive;
            }
            if (states.contains(MaterialState.pressed) ||
                states.contains(MaterialState.hovered) ||
                states.contains(MaterialState.selected)) {
              return activeColor;
            }
            return PiixColors.active;
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return PiixColors.inactive;
            }
            if (states.contains(MaterialState.pressed) ||
                states.contains(MaterialState.hovered) ||
                states.contains(MaterialState.selected)) {
              return ColorUtils.lighten(PiixColors.infoDefault, 0.1);
            }
            return PiixColors.infoDefault;
          },
        ),
        side: MaterialStateProperty.resolveWith<BorderSide>(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return const BorderSide(
                color: PiixColors.inactive,
              );
            }
            if (states.contains(MaterialState.pressed) ||
                states.contains(MaterialState.hovered) ||
                states.contains(MaterialState.selected)) {
              return BorderSide(color: activeColor);
            }
            return const BorderSide(color: PiixColors.space);
          },
        ),
      ),
    );
  }
}
