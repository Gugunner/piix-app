import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/utils/extensions/list_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';

enum DocumentSource { camera, gallery, none }

enum PickerState {
  idle,
  retrieving,
  retrievedError,
  retrieved,
  lengthError,
}

@Deprecated('Will be removed in 4.0')
class DocumentInputUiStateDeprecated {
  DocumentInputUiStateDeprecated({required this.setState});
  final StateSetter setState;

  DocumentSource _documentSource = DocumentSource.none;
  DocumentSource get documentSource => _documentSource;
  void setDocumentSource(DocumentSource value) {
    _documentSource = value;
    setState(() {});
  }

  PickerState _pickerState = PickerState.idle;
  PickerState get pickerState => _pickerState;
  void setPickerState(PickerState state) {
    _pickerState = state;
    setState(() {});
  }

  void openGalleryToChooseImages({
    required FormFieldModelOld formField,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final picker = ImagePicker();
    setDocumentSource(DocumentSource.gallery);
    try {
      setPickerState(PickerState.retrieving);
      //In android there is a fraction of a second where the notify listener is
      //performed faster than the closing of the image picker and a black screen
      //is seen, to avoid this we use a delay of 10 milliseconds and with this we
      //avoid the black screen.
      final pickedFileList = await (picker.pickMultiImage().then((value) =>
          Future.delayed(const Duration(milliseconds: 150), () => value)));
      setPickerState(PickerState.retrieved);
      if (pickedFileList.isNullOrEmpty) return;
      //This conditional evaluates the maximum number of photos
      if (pickedFileList.length > formField.maxPhotos) {
        setPickerState(PickerState.lengthError);
        return;
      }
      ref
          .read(formNotifierProvider.notifier)
          .addGalleryImages(formField, pickedFileList);
    } catch (e) {
      setPickerState(PickerState.retrievedError);
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in image picker',
        message: e.toString(),
        isLoggable: true,
      );
      PiixLogger.instance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
    }
  }
}
