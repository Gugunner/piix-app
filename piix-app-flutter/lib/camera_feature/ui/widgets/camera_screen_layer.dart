import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///Responsible for building the preview of the [cameraController].
///
///This screen does not create its own [CameraController]
///and requires one to build the camera preview.
///
///A [onResumedSelectedCamera] callback needs to be passed also
///because the screen handles its own [AppLifecycleState]
///through a lsitener.
class CameraScreenLayer extends StatefulWidget {
  const CameraScreenLayer({
    super.key,
    required this.cameraController,
    required this.onResumedSelectedCamera,
  }) : assert(cameraController == null || onResumedSelectedCamera != null);

  ///If no controller is passed the screen is white.
  final CameraController? cameraController;

  ///If [cameraController] is not null this property cannot be null
  ///to control the [AppLifecycleState].
  final Function(CameraDescription)? onResumedSelectedCamera;

  @override
  State<CameraScreenLayer> createState() => _CameraScreenLayerState();
}

///Builds the camera preview and reads the [AppLifecycleState]
///to handle either disposing or adding a new [CameraDescription]
///based on the value stored in the [cameraController].
class _CameraScreenLayerState extends State<CameraScreenLayer> {
  ///Listens to any change in the [AppLifecycleState]
  late final AppLifecycleListener _listener;

    bool isCameraActive = false;

  bool get isCameraInitialized =>
      widget.cameraController?.value.isInitialized ?? false;

  void _onStateChanged(AppLifecycleState state) {
    final cameraController = widget.cameraController;
    if (cameraController == null || !isCameraInitialized) return;
    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
      setState(() {
        isCameraActive = false;
      });
    } else if (state == AppLifecycleState.resumed) {
      widget.onResumedSelectedCamera?.call(cameraController.description);
      setState(() {
        isCameraActive = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Hide the status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    //initializes the listening of the app lifecycle.
    _listener = AppLifecycleListener(onStateChange: _onStateChanged);
    isCameraActive = widget.cameraController?.value.isInitialized ?? false;
  }

  @override
  void dispose() {
    _listener.dispose();
    //Enable again the status and bottom bar.
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    final aspectRatio = width / height;
    if (!isCameraInitialized) return Container();
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: isCameraInitialized && isCameraActive
          ? CameraPreview(widget.cameraController!)
          : const SizedBox(),
    );
  }
}
