import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_camera_control_input_deprecated/piix_picture_thumbnail_selection_card_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_camera_dialog_deprecated/image_catalog_dialog_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_camera_dialog_deprecated/preview_image_dialog_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/state_machine.dart';

@Deprecated('Will be removed in 4.0')
class PiixCameraDialogDeprecated {
  const PiixCameraDialogDeprecated({required this.formField});

  ///A data model that contains all the information
  ///to render the [PiixPictureThumbnailSelectionCardDeprecated]
  final FormFieldModelOld formField;

  Future<StateMachine?> showImagePreview({
    required XFile image,
    required BuildContext screenContext,
  }) async {
    return showDialog<StateMachine>(
      context: screenContext,
      builder: (context) {
        return PreviewImageDialogDeprecated(
          image: File(image.path),
        );
      },
    );
  }

  void showImageCatalogDialog({
    required BuildContext screenContext,
  }) async {
    return await showDialog(
      barrierDismissible: false,
      context: screenContext,
      builder: (context) {
        return ImageCatalogDialogDeprecated(
          formField: formField,
        );
      },
    );
  }
}
