import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/input_form_feature_deprecated/domain/bloc/document_input_ui_state.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_document_input_deprecated/piix_camera_input_image_preview_widget_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/piix_camera_copies.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/piix_document_input_utils_deprecated.dart';
import 'package:piix_mobile/ui/common/piix_confirm_alert_deprecated.dart';
import 'package:piix_mobile/widgets/button/text_app_button/text_app_button_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This widget is in charge of showing the previews of the images chosen from
///the gallery or the photos taken.
///
///It shows them in a horizontal list, this list can have a scroll depending
///on the number of images.
///
///This widget also shows two buttons, one that allows us to take or choose
///other images or photos and another button that allows us to delete all photos
/// or images.
///
///Receives:
///[formField] => is the model that brings all the information from the field.
///[count] => is the number of images or photos that have been taken.
///[documentInputUiState] => is the handler of the ui states for the
///documentation field.
class PiixCameraInputPreviewDeprecated extends ConsumerWidget {
  const PiixCameraInputPreviewDeprecated({
    super.key,
    required this.formField,
    required this.count,
    required this.documentInputUiState,
  });

  final FormFieldModelOld formField;
  final int count;
  final DocumentInputUiStateDeprecated documentInputUiState;

  String get sourceImageText =>
      documentInputUiState.documentSource == DocumentSource.gallery
          ? PiixCameraCopiesDeprecated.uploadAnotherImage
          : PiixCameraCopiesDeprecated.takeAnotherPhoto;

  String get cleanImageText =>
      documentInputUiState.documentSource == DocumentSource.gallery
          ? PiixCameraCopiesDeprecated.cleanImages(count)
          : PiixCameraCopiesDeprecated.cleanPhotos(count);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkPhotos =
        formField.hasMinimumImages && formField.responseErrorText.isNullOrEmpty;
    final minimumPhotos = formField.minimumImages;
    final errorText = formField.responseErrorText.isNotNullEmpty
        ? formField.responseErrorText!
        : PiixCameraCopiesDeprecated.getMinimumPhotosWarning(minimumPhotos);
    ref.watch(formNotifierProvider);
    final networkImages = formField.networkImages;
    return SizedBox(
      height: context.height * 0.3628,
      width: context.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: context.width,
            height: context.height * 0.24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return PiixCameraInputImagePreviewWidgetDeprecated(
                        formField: formField,
                        index: index,
                      );
                    },
                    itemCount: count,
                  ),
                ),
              ],
            ),
          ),
          if (!checkPhotos)
            SizedBox(
              width: context.width,
              child: Text(
                errorText,
                style: context.textTheme?.labelMedium?.copyWith(
                  color: PiixColors.error,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          if (networkImages.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
              ),
              child: Text(
                PiixCameraCopiesDeprecated.getCurrentPhotos(
                    networkImages.length),
                style: context.textTheme?.labelMedium?.copyWith(
                  color: PiixColors.primary,
                ),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 32.h,
                child: TextAppButtonDeprecated(
                  text: networkImages.isNotEmpty
                      ? PiixCameraCopiesDeprecated.changePicture(
                          networkImages.length)
                      : sourceImageText,
                  onPressed: () => handleCameraAndPicker(context, ref),
                ),
              ),
              SizedBox(
                height: 32.h,
                child: TextAppButtonDeprecated(
                  text: cleanImageText,
                  onPressed: () => handleCleanImagesDialog(context, ref),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void handleCleanImagesDialog(BuildContext context, WidgetRef ref) {
    final formNotifier = ref.read(formNotifierProvider.notifier);
    showDialog<bool>(
      context: context,
      builder: (_) => PiixConfirmAlertDialogDeprecated(
        title: PiixCameraCopiesDeprecated.shouldDeleteAllPhotos,
        titleStyle: context.textTheme?.headlineSmall,
        message: PiixCameraCopiesDeprecated.youCannotRecoverPhotos,
        onCancel: () => Navigator.pop(context, false),
        onConfirm: () {
          final newFormField = formNotifier.removeAllImages(formField);
          if (formField.stringResponse.isNotNullEmpty) {
            formNotifier.updateFormField(
              formField: newFormField,
              value: null,
              type: ResponseType.string,
            );
          }
          Navigator.pop(context);
        },
      ),
    );
  }

  //This method depending on the source of the image selection will navigate to
  // the camera or open the image picker
  void handleCameraAndPicker(BuildContext context, WidgetRef ref) {
    if (documentInputUiState.documentSource == DocumentSource.gallery) {
      documentInputUiState.openGalleryToChooseImages(
          formField: formField, context: context, ref: ref);
      return;
    }
    toCameraScreen(
      context,
      formField: formField,
      documentInputUiState: documentInputUiState,
    );
  }
}
