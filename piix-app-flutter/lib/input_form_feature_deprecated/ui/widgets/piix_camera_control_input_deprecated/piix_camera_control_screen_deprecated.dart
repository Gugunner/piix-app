import 'dart:async';
import 'dart:ui' as ui;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/model/form_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/general_app_feature/ui/piix_simple_progress_loader_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/app_confirm_dialog.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/input_form_feature_deprecated/domain/bloc/camera_bloc.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_camera_control_input_deprecated/piix_camera_cancel_button_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_camera_dialog_deprecated/piix_camera_dialog_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_camera_control_input_deprecated/piix_camera_listener_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_camera_control_input_deprecated/piix_camera_zoom_slider_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_camera_control_input_deprecated/piix_image_thumbails_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_camera_control_input_deprecated/piix_take_picture_button_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_camera_control_input_deprecated/piix_accept_pictures_button_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/piix_camera_copies.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/piix_camera_errors.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/state_machine.dart';
import 'package:piix_mobile/ui/common/piix_alert.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';

@Deprecated('Use instead AppCameraPreviewScreen')
//TODO: Add documentation to class
class PiixCameraControlScreenDeprecated extends ConsumerStatefulWidget {
  const PiixCameraControlScreenDeprecated({
    Key? key,
    required this.formField,
  }) : super(key: key);

  final FormFieldModelOld formField;

  @override
  ConsumerState<PiixCameraControlScreenDeprecated> createState() =>
      _PiixCameraControlScreenState();
}

//TODO: Handle exposure selector with a controller
//Handle AppLifecycle state
class _PiixCameraControlScreenState
    extends ConsumerState<PiixCameraControlScreenDeprecated>
    with WidgetsBindingObserver {
  //Property to store future used in FutureBuilder to avoid executing
  //again if state changes
  late Future initializeCameraUse;
  late PiixCameraDialogDeprecated piixCameraDialog;
  late FormNotifier formNotifier;
  //The controller needed to set and check for camera sensor values
  CameraController? cameraController;
  late FormFieldModelOld formField;
  bool isCameraInitialized = false;
  //Zoom control values
  double minZoomLevel = 1.0;
  double maxZoomLevel = 1.0;
  double currentZoomLevel = 1.0;
  //Exposure control values
  double minExposureOffsetLevel = 0.0;
  double maxExposureOffsetLevel = 0.0;
  double currentExposureOffsetLevel = 0.0;

  ///A data model that contains all the information to render the [PiixCameraControlScreenDeprecated]

  int get frontCamera => 1;

  int get backCamera => 0;

  int get camera => formField.dataTypeId == ConstantsDeprecated.documentType ||
          cameras.length == 1
      ? backCamera
      : frontCamera;

  double minExposure = 0;
  double maxExposure = 0;

  List<CameraDescription> get cameras => getIt<CameraBLoC>().cameras;

  int get maximumPhotos => formField.maxPhotos;

  int get minimumPhotos => formField.minPhotos;

  List<XFile> get images => formField.capturedImages ?? [];

  Future<void> initializeZoomLevels() async {
    try {
      maxZoomLevel = await cameraController!.getMaxZoomLevel();
      minZoomLevel = await cameraController!.getMinZoomLevel();
    } on CameraException catch (e) {
      PiixCameraError.chooseCameraError(e, context);
    }
  }

  Future<void> initializeExposure() async {
    try {
      maxExposureOffsetLevel = await cameraController!.getMaxExposureOffset();
      minExposureOffsetLevel = await cameraController!.getMinExposureOffset();
    } on CameraException catch (e) {
      PiixCameraError.chooseCameraError(e, context);
    }
  }

  Future<void> onInitializeCamera() async {
    try {
      await cameraController?.initialize();
      if (mounted) {
        setState(() {
          isCameraInitialized = cameraController!.value.isInitialized;
        });
      }
      await initializeZoomLevels();
      await initializeExposure();
      cameraController!.setFlashMode(FlashMode.off);
    } on CameraException catch (e) {
      debugPrint('Error initializing the camera');
      PiixCameraError.chooseCameraError(
        e,
        context,
      );
    }
  }

  Future<void> onNewCamera(CameraDescription cameraDescription) async {
    final previousCameraController = cameraController;

    final controller = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await previousCameraController?.dispose();

    if (mounted) {
      setState(() {
        cameraController = controller;
      });
    }

    cameraController!.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    await onInitializeCamera();
  }

  @override
  void initState() {
    super.initState();
    formField = widget.formField;
    //Checks if there are cameras in the device
    if (cameras.isNotEmpty) {
      //Checks if camera can be accessed by ensuring the camera index is in the cameras list
      if (cameras.length - 1 >= camera) {
        initializeCameraUse = onNewCamera(cameras[camera]);
        piixCameraDialog = PiixCameraDialogDeprecated(formField: formField);
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final controller = cameraController;
    if (controller == null || !controller.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCamera(controller.description);
    }
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  //Sets and refreshed flash mode in camera
  Future<void> onSetFlashMode(FlashMode flashMode) async {
    try {
      await cameraController?.setFlashMode(flashMode);
      if (mounted) {
        setState(() {});
      }
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

  //Calls the camera controller to take the picture by communicating
  //with the actual device camera
  Future<XFile?> takePicture() async {
    if (!(cameraController?.value.isInitialized ?? false)) {
      PiixCameraError.showBannerError(
        PiixCameraError.cameraNotFound,
        context,
      );
      return null;
    }
    if (cameraController?.value.isTakingPicture ?? false) {
      //A capture is already in process
      return null;
    }
    try {
      final file = await cameraController?.takePicture();
      return file;
    } catch (e) {
      if (e is CameraException) {
        PiixCameraError.chooseCameraError(
          e,
          context,
        );
        return null;
      }
      PiixCameraError.showBannerError(
        PiixCameraError.unknownCameraError,
        context,
      );
    }
    return null;
  }

  void onTakePicture() async {
    if (images.length == maximumPhotos) {
      final shouldCheckPictures = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AppConfirmDialogDeprecated(
              title: PiixCameraCopiesDeprecated.photoLimit,
              message: PiixCameraCopiesDeprecated.deletePhotoToTakeNew,
              cancelText: PiixCopiesDeprecated.closeText.toUpperCase(),
              confirmText: PiixCameraCopiesDeprecated.viewPhotos.toUpperCase(),
            );
          });
      if (shouldCheckPictures ?? false) {
        final piixCameraDialog =
            PiixCameraDialogDeprecated(formField: formField);
        piixCameraDialog.showImageCatalogDialog(
          screenContext: context,
        );
      }
      return;
    }

    final file = await takePicture();
    if (file == null) return;
    final state = await piixCameraDialog.showImagePreview(
      image: file,
      screenContext: context,
    );
    if (state == null || state.index > 1) return;
    final newFormField = formNotifier.updateFormField(
      formField: formField,
      capturedImage: file,
      type: ResponseType.image,
    );
    if (formField.stringResponse.isNotNullEmpty) {
      formNotifier.updateFormField(
        formField: newFormField,
        value: null,
        type: ResponseType.string,
      );
    }

    if (state == StateMachine.one) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(formNotifierProvider);
    ref.listen<FormModelOld?>(formNotifierProvider, (_, __) {
      //Each time the formNotifierProvider changes
      //it reassigns the formField with the updated formField
      formField = ref
          .read(formNotifierProvider)!
          .formFieldBy(widget.formField.formFieldId)!;
      //It also reassigns the piixCameraDialog with the upated formField
      piixCameraDialog = PiixCameraDialogDeprecated(formField: formField);
    });
    formNotifier = ref.watch(formNotifierProvider.notifier);
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).nextFocus();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder(
          future: initializeCameraUse,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                cameraController != null) {
              final windowSize = MediaQueryData.fromView(ui.window).size;
              final height = windowSize.height;
              final width = windowSize.width;
              final aspectRatio = width / height;
              return Stack(
                children: [
                  AspectRatio(
                    aspectRatio: aspectRatio,
                    child: GestureDetector(
                      onTap: () async {
                        if (cameraController == null) {
                          return;
                        }
                        await cameraController!.setFocusPoint(null);
                      },
                      child: PiixCameraListenerDeprecated(
                        cameraController: cameraController!,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: context.height * 0.24,
                    child: PiixCameraZoomSliderDeprecated(
                      maxZoomLevel: maxZoomLevel,
                      minZoomLevel: minZoomLevel,
                      currentZoomLevel: currentZoomLevel,
                      onChangedZoom: (value) async {
                        setState(() {
                          currentZoomLevel = value;
                        });
                        await cameraController!.setZoomLevel(value);
                      },
                    ),
                  ),
                  Positioned(
                    left: context.width * 0.05,
                    child: SizedBox(
                      width: 40.h,
                      child: PiixCameraCancelButtonDeprecated(
                        backgroundColor: PiixColors.clearBlue.withOpacity(0.5),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    // bottom: 30,
                    child: PiixTakPictureButtonDeprecated(
                      onTakePicture: onTakePicture,
                    ),
                  ),
                  if (images.length > 0) ...[
                    Positioned(
                      right: context.width * 0.05,
                      bottom: context.height * 0.11,
                      child: SizedBox(
                        height: context.height * 0.044,
                        width: context.width * 0.262,
                        child: PiixAcceptPicturesButtonDeprecated(
                          pictureCount: images.length,
                          onPressed: () =>
                              piixCameraDialog.showImageCatalogDialog(
                            screenContext: context,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: context.width * 0.05,
                      bottom: context.height * 0.1,
                      child: GestureDetector(
                        onTap: () => piixCameraDialog.showImageCatalogDialog(
                          screenContext: context,
                        ),
                        child: Container(
                          color: Colors.black.withOpacity(0.4),
                          width: 60.h,
                          height: 60.h,
                          child: PiixImageThumbnailsDeprecated(
                            images: images,
                          ),
                        ),
                      ),
                    ),
                    //TODO: Uncomment once flash mode has been fixed for the camera package in Android phones
                    // if (formField.dataTypeId == Constants.documentType)
                    //   Positioned(
                    //     right: context.width * 0.05,
                    //     top: context.height * 0.025,
                    //     child: PiixCameraFlashControls(
                    //       flashMode:
                    //           cameraController?.value.flashMode ?? FlashMode.off,
                    //       onStopFlash: () => _setFlashMode(FlashMode.off),
                    //       onAutoFlash: () => _setFlashMode(FlashMode.auto),
                    //       onStartFlash: () => _setFlashMode(FlashMode.always),
                    //     ),
                    //   ),
                  ]
                ],
              );
            } else if (snapshot.hasError || cameras.isEmpty) {
              return PiixAlert(
                title: PiixCopiesDeprecated.appFailure,
                message: PiixCopiesDeprecated.cameraCouldNotStart,
                buttonText: PiixCopiesDeprecated.backText,
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            }
            return const PiixSimpleProgressLoaderDeprecated();
          },
        ),
      ),
    );
  }
}
