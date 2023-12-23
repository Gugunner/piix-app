import 'package:flutter/material.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/utils/extensions/list_extend.dart';
import 'package:piix_mobile/input_form_feature_deprecated/domain/bloc/document_input_ui_state.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_camera_control_input_deprecated/piix_camera_control_screen_deprecated.dart';

void toCameraScreen(
  BuildContext context, {
  required FormFieldModelOld formField,
  required DocumentInputUiStateDeprecated documentInputUiState,
}) async {
  documentInputUiState.setDocumentSource(DocumentSource.camera);
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PiixCameraControlScreenDeprecated(
        formField: formField,
      ),
    ),
  );
}

int minimumImages(FormFieldModelOld formField) => formField.minPhotos;

bool hasMinimumImages(FormFieldModelOld formField) {
  if (formField.capturedImages.isNotNullOrEmpty) {
    return formField.capturedImages!.length >= minimumImages(formField);
  }
  return true;
}
