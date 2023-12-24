import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:piix_mobile/camera_feature/camera_screen_barrel_file.dart';
import 'package:piix_mobile/camera_feature/camera_ui_barrel_file.dart';
import 'package:piix_mobile/camera_feature/camera_utils_barrel_file.dart';
import 'package:piix_mobile/file_feature/file_model_barrel_file.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/navigation_feature/navigation_utils_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/app_bar/logo_app_bar.dart';

import '../../../widgets/banner/banner_barrel_file.dart';

///A composed screen that uses [CameraScreenLayer] to draw
///a [cameraSilhouette] by using [CameraSilhouettePainter].
final class DocumentationCameraScreen extends ConsumerStatefulWidget {
  const DocumentationCameraScreen({
    super.key,
    this.cameraSilhouette = CameraSilhouette.id,
    this.onChanged,
  });

  ///The silhouette to show over the [CameraScreenLayer].
  final CameraSilhouette cameraSilhouette;

  final ValueChanged<FileContentModel?>? onChanged;

  @override
  ConsumerState<DocumentationCameraScreen> createState() =>
      _DocumentationCameraScreenState();
}

///Initializes the [CameraController] and sets a [camera] inside to
///build its preview screen.
///
///When it first loads the [Widget] it tries to initialize the camera and handle
///any type of [CameraException] that may occur, including the
///'CameraAccessDenied' error code thrown by the [CameraException].
///
///If 'CameraAccessDenied' error code is thrown which happens if the user
///previously or when prompted denies access to the camera or the microphone
///(which is used inside the camera) it launches an [AppBanner] explaining to
///the user that she must grant permission to the camera and a quick access
///button to the "App Settings". If ithe banner is dismissed it shows the same
///message in the screen so the user knows what she must do to access the camera
///inside the app.
///
///The camera also handles zoom levels by reading from the [_controller] its
///minZoomLevel and maxZoomLevel values. Any value between minZoomLevel and
///maxZoomLevel can be selected and is stored in [_currenZoomLevel].
final class _DocumentationCameraScreenState
    extends ConsumerState<DocumentationCameraScreen> {
  ///The controller which wraps around a [CameraDescription] to
  ///control initialization and other properties.
  CameraController? _controller;

  ///Contains the minimumZoomLevel allowed by the device camera.
  double _minZoomLevel = 1.0;

  ///Contains the maximumZoomLevel allowed by the device camera.
  double _maxZoomLevel = 1.0;

  ///Stores the camera zoom value selected to be passed onto the
  ///[_controller].
  double _currentZoomLevel = 1.0;

  ///Controls the fade in animation when the permission is denied.
  CameraAccess _cameraAccess = CameraAccess.waiting;

  List<CameraDescription> _cameras = [];

  bool _isRearCameraSelected = true;

  ///Checks whether a camera is present in the [_controller] and it
  ///has been initialized if any of the statements is false then the camera
  ///has not been initialized.
  bool get _isCameraInitialized => _controller?.value.isInitialized ?? false;

  CrossFadeState get _crossFadeState => !_isCameraInitialized
      ? CrossFadeState.showFirst
      : CrossFadeState.showSecond;

  String get _instructions {
    switch (widget.cameraSilhouette) {
      case CameraSilhouette.id:
        return context.localeMessage.placeYourIdentification;
      case CameraSilhouette.selfie:
        return context.localeMessage.placeYourFaceAndId;
    }
  }

  ///Each time the camera makes an action an empty
  ///call is made to this listener to rebuild its widget.
  void _refreshCamera() {
    if (mounted) setState(() {});
  }

  ///Launches an error banner with the passed on [description].
  void _launchErrorBanner(String description) {
    Future.microtask(() {
      ref.read(bannerPodProvider.notifier)
        ..setBanner(
          context,
          cause: BannerCause.error,
          description: description,
        )
        ..build();
    });
  }

  ///Reads the [CameraException] thrown [errorCode]
  ///and selects the appropriate [description] to pass
  ///onto [_launchErrorBanner].
  void _handleCameraErrorCode(String errorCode) {
    final localeMessage = context.localeMessage;
    var description = '';
    switch (errorCode.toUpperCase()) {
      case cannotCreateFileCode:
        description = localeMessage.cannotCreateFile;
        break;
      case captureTimeOutCode:
        description = localeMessage.captureTimeOut;
        break;
      case captureFailureCode:
        description = localeMessage.captureFailure;
        break;
      case zoomErrorCode:
        description = localeMessage.zoomError;
      default:
        description = localeMessage.unknownCameraError;
    }
    _launchErrorBanner(description);
  }

  ///When the user denies permission a banner opens up
  ///to ask the user to open "App Settings" and grant
  ///the camera and microphone permission.
  void _handleCameraPermission() {
    Future.microtask(() {
      ref.read(bannerPodProvider.notifier)
        ..setBanner(context,
            cause: BannerCause.warning,
            description: context.localeMessage.cameraAccessDenied,
            actionText: context.localeMessage.viewSettings, action: () {
          openAppSettings();
        }, onClose: () {
          if (mounted) {
            setState(() {
              _cameraAccess = CameraAccess.denied;
            });
          }
        })
        ..build();
    });
  }

  void _initializeZoomLimitLevels() {
    _controller?.getMinZoomLevel().then((value) => setState(() {
          if (value <= 1) {
            _minZoomLevel = 1;
            return;
          }
          _minZoomLevel = value.toInt().toDouble();
        }));
    _controller?.getMaxZoomLevel().then((value) => setState(() {
          if (value >= 3) {
            _maxZoomLevel = 3.0;
            return;
          }
          _maxZoomLevel = value.toInt().toDouble();
        }));
  }

  ///Each time a new camera is selected which happens when first loading
  ///the screen and each time the user selects to change to the front or
  ///back camera depending on which one is active, a new [CameraController]
  ///is created with all the appropriate selections and the old
  ///[CameraController] is disposed of.
  void _onNewCameraSelected(CameraDescription cameraDescription) async {
    //Store reference to current controller as the previous controller
    final previousController = _controller;
    //Create the new controller
    final newController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    //Add the new listener to refresh the camera each time it
    //an action triggers in the controller.
    newController.addListener(_refreshCamera);

    if (mounted) {
      setState(() {
        _controller = newController;
      });
    }

    //Remove any listener the previous controller may have
    previousController?.removeListener(_refreshCamera);
    //Dispose the previous controller so it can be cleaned
    //from the memory.
    await previousController?.dispose();
    //If no error was thrown set the controller with the
    //new camera controller.

    //Initialize the new controller with the new
    //camera
    try {
      await _controller?.initialize();
      _initializeZoomLimitLevels();
      //Set the camera access to granted if it has not been done
      //previously. This allows the class to show the
      //correct preview camera screen.
      if (_cameraAccess != CameraAccess.granted) {
        setState(() {
          _cameraAccess = CameraAccess.granted;
        });
      }
    } catch (e) {
      if (e is CameraException) {
        switch (e.code.toUpperCase()) {
          case cameraAccessDeniedCode:
          case cameraAccessDeniedWithoutPromptCode:
          case cameraAccessRestrictedCode:
          case audioAccessDeniedCode:
          case audioAccessDeniedWithoutPromptCode:
          case audioAccessRestrictedCode:
            return _handleCameraPermission();
          default:
            break;
        }
        return _handleCameraErrorCode(unknowCameraErrorCode);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // Hide the status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    Future.microtask(() async {
      try {
        //Gets the available cameras from the device
        _cameras = await availableCameras();
        if (_cameras.isEmpty) return;
        if (widget.cameraSilhouette == CameraSilhouette.selfie) {
          _onSwitchCamera();
          return;
        }
        _onNewCameraSelected(_cameras.first);
      } catch (e) {
        _handleCameraErrorCode(unknowCameraErrorCode);
      }
    });
  }

  void _onChangedZoom(double value) async {
    await _controller?.setZoomLevel(value);
    setState(() {
      _currentZoomLevel = value;
    });
  }

  void _onTakePicture() async {
    //If there is no camera or it has not been initialized exit.
    if (!_isCameraInitialized) return;
    //If the camera is already taking a picture exit.
    if (_controller!.value.isTakingPicture) return;
    //Locking focus mode speeds up the time when taking a picture.
    _controller?.setFocusMode(FocusMode.locked);
    try {
      final picture = await _controller?.takePicture();
      if (picture == null)
        throw CameraException(
            cannotCreateFileCode, context.localeMessage.cannotCreateFile);
      final base64Content = await picture.readAsBytes();
      final fileContent = FileContentModel(
        name: '${widget.cameraSilhouette}_${picture.path}',
        contentType: 'image/jpg',
        base64Content: base64Encode(base64Content),
      );
      //Pushes the preview screen and waits for the screen to pop
      //with either true or false to know if the picture should be saved.
      final savePicture = await NavigatorKeyState().slideToTopRoute<bool?>(
        page: DocumentationPreviewScreen(
          base64Content,
          cameraSilhouette: widget.cameraSilhouette,
        ),
        routeName: '',
      );
      //Checks if picture should be saved.
      if (savePicture ?? false) {
        //Calls the callback and passes the value
        //to the class aggregating this class.
        widget.onChanged?.call(
          fileContent,
        );
        Navigator.pop(context, fileContent);
      }
    } catch (error) {
      if (error is CameraException) {
        _handleCameraErrorCode(error.code);
        return;
      }
      _launchErrorBanner(unknowCameraErrorCode);
    }
  }

  ///Switches between the front and rear camera in the device
  ///if there is a front camera.
  void _onSwitchCamera() {
    setState(() {
      _isRearCameraSelected = !_isRearCameraSelected;
    });
    if (_cameras.length > 1)
      _onNewCameraSelected(_cameras[_isRearCameraSelected ? 0 : 1]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ref.read(bannerPodProvider)?.removeEntry();
        return true;
      },
      child: Scaffold(
        appBar: _cameraAccess == CameraAccess.denied ? LogoAppBar() : null,
        body: SafeArea(
          child: Builder(
            builder: (context) {
              if (_cameraAccess == CameraAccess.waiting) {
                return Container(color: PiixColors.contrast);
              }
              return AnimatedCrossFade(
                duration: const Duration(milliseconds: 600),
                crossFadeState: _crossFadeState,
                firstChild: Builder(
                  builder: (context) {
                    if (_cameraAccess == CameraAccess.denied) {
                      return const RequestCameraAccess();
                    }
                    return Container(
                      color: PiixColors.contrast,
                    );
                  },
                ),
                secondChild: GestureDetector(
                  onTap: () {
                    //Locking focus mode speeds up the time when taking a picture.
                    _controller?.setFocusMode(FocusMode.auto);
                  },
                  child: SizedBox(
                    width: context.width,
                    height: context.height,
                    child: Stack(
                      children: [
                        CameraScreenLayer(
                          cameraController: _controller,
                          onResumedSelectedCamera: _onNewCameraSelected,
                        ),
                        Stack(
                          children: [
                            CustomPaint(
                              painter: CameraSilhouettePainter(
                                cameraSilhouette: widget.cameraSilhouette,
                              ),
                              size: MediaQuery.of(context).size,
                            ),
                            Positioned(
                              top: 16.h,
                              left: 16.w,
                              child: SmallRoundControlButton(
                                onTap: () {
                                  Navigator.pop(context, null);
                                },
                                child: Icon(
                                  Icons.arrow_back_ios_new_outlined,
                                  size: 24.w,
                                  color: PiixColors.space,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 16.h,
                              right: 16.w,
                              child: SmallRoundControlButton(
                                onTap: _onSwitchCamera,
                                child: Icon(
                                  Icons.cameraswitch_outlined,
                                  size: 24.w,
                                  color: PiixColors.space,
                                ),
                              ),
                            ),
                            Positioned(
                                top: 52.h,
                                child: SizedBox(
                                  width: context.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CameraScreenInstructions(
                                        instructions: _instructions,
                                      )
                                    ],
                                  ),
                                )),
                            Positioned(
                              top: 384.h,
                              child: SizedBox(
                                width: context.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 200.w,
                                      child: CameraZoomSlider(
                                        currentZoomLevel: _currentZoomLevel,
                                        maxZoomLevel: _maxZoomLevel,
                                        minZoomLevel: _minZoomLevel,
                                        onChanged: _onChangedZoom,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 60.h,
                              child: SizedBox(
                                width: context.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RoundedCameraButton(
                                      onTakePicture: _onTakePicture,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
