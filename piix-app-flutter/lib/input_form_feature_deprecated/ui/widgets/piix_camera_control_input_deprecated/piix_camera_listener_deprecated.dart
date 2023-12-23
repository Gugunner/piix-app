import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/piix_camera_errors.dart';

@Deprecated('Will be removed in 4.0')
//TODO: Add documentation
class PiixCameraListenerDeprecated extends ConsumerStatefulWidget {
  const PiixCameraListenerDeprecated({
    Key? key,
    required this.cameraController,
  }) : super(key: key);

  final CameraController cameraController;

  @override
  ConsumerState<PiixCameraListenerDeprecated> createState() =>
      _PiixCameraListenerState();
}

class _PiixCameraListenerState
    extends ConsumerState<PiixCameraListenerDeprecated> {
  //TODO: Explain property
  int pointer = 0;
  //TODO: Explain property
  double baseScaleFactor = 1.0;
  //TODO: Explain property
  double currentScale = 1.0;
  //TODO: Explain property
  double maxZoom = 1.0;
  //TODO: Explain property
  double minZoom = 1.0;

  CameraController get cameraController => widget.cameraController;

  //TODO: Explain method
  void _onTapDown(TapDownDetails details, BoxConstraints constraints) async {
    final dx = details.localPosition.dx / constraints.maxWidth;
    final dy = details.localPosition.dy / constraints.maxHeight;
    final offset = Offset(dx, dy);
    try {
      await cameraController.setExposurePoint(offset);
      await cameraController.setFocusPoint(offset);
    } catch (e) {
      if (e is CameraException) {
        PiixCameraError.chooseCameraError(
          e,
          context,
        );
        return;
      }
      PiixCameraError.showBannerError(
        PiixCameraError.unknownCameraError,
        context,
      );
    }
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    debugPrint('Clicks!');
    final offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    cameraController.setExposurePoint(offset);
    cameraController.setFocusPoint(offset);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(formNotifierProvider);
    return CameraPreview(
      cameraController,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (details) => onViewFinderTap(details, constraints),
          );
        },
      ),
    );
  }
}
