import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';


@Deprecated('Will be removed in 4.0')
//TODO: Add documentation
class PiixCameraFlashControlsDeprecated extends StatelessWidget {
  const PiixCameraFlashControlsDeprecated({
    Key? key,
    required this.flashMode,
    this.onStartFlash,
    this.onAutoFlash,
    this.onStopFlash,
  }) : super(key: key);

  //TODO: Explain property
  final FlashMode flashMode;
  //TODO: Explain property
  final VoidCallback? onStartFlash;
  //TODO: Explain property
  final VoidCallback? onAutoFlash;
  //TODO: Explain property
  final VoidCallback? onStopFlash;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.15,
      height: context.width * 0.553,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
        color: PiixColors.white.withOpacity(0.15),
        boxShadow: [
          BoxShadow(
            color: PiixColors.grey.withOpacity(0.05),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          PiixCameraFlash(
            currentFlashMode: FlashMode.auto,
            flashMode: flashMode,
            onPressed: onAutoFlash,
            flashIcon: Icons.flash_auto,
          ),
          PiixCameraFlash(
            currentFlashMode: FlashMode.off,
            flashMode: flashMode,
            onPressed: onStopFlash,
            flashIcon: Icons.flash_off,
          ),
          PiixCameraFlash(
            currentFlashMode: FlashMode.always,
            flashMode: flashMode,
            onPressed: onStartFlash,
            flashIcon: Icons.flash_on,
          ),
        ],
      ),
    );
  }
}

//TODO: Add documentation
class PiixCameraFlash extends StatelessWidget {
  const PiixCameraFlash({
    Key? key,
    required this.currentFlashMode,
    required this.flashMode,
    this.onPressed,
    required this.flashIcon,
  }) : super(key: key);

  final FlashMode currentFlashMode;
  final FlashMode flashMode;
  final VoidCallback? onPressed;
  final IconData flashIcon;

  //TODO: Explain getter calculation
  Color get selected => currentFlashMode == flashMode
      ? PiixColors.warningLight
      : PiixColors.grey_white2;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: context.height * 0.002),
      child: IconButton(
        onPressed: onPressed,
        iconSize: context.height * 0.055,
        icon: Icon(
          flashIcon,
          color: selected,
        ),
      ),
    );
  }
}
