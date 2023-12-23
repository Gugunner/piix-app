import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/app_text_button_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_banner_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_banner_content_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/input_form_feature_deprecated/domain/bloc/document_input_ui_state.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/piix_camera_copies.dart';

@Deprecated('Will be removed in 4.0')
class PiixImagePickerButtonDeprecated extends ConsumerWidget {
  const PiixImagePickerButtonDeprecated({
    super.key,
    required this.formField,
    required this.documentInputUiState,
  });
  final FormFieldModelOld formField;
  final DocumentInputUiStateDeprecated documentInputUiState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 32.h,
          child: AppTextButtonDeprecated(
            text: PiixCameraCopiesDeprecated.uploadImage,
            color: PiixColors.activeButton,
            onPressed: () => handleImagePicker(context, ref),
          ),
        ),
        if (documentInputUiState.pickerState == PickerState.lengthError)
          Text(
            PiixCameraCopiesDeprecated.errorImagePickerLength(
                formField.maxPhotos),
            style: context.textTheme?.labelMedium?.copyWith(
              color: PiixColors.error,
            ),
          )
      ],
    );
  }

  void handleImagePicker(BuildContext context, WidgetRef ref) {
    documentInputUiState.openGalleryToChooseImages(
        formField: formField, context: context, ref: ref);
    if (documentInputUiState.pickerState == PickerState.retrievedError) {
      const banner = PiixBannerContentDeprecated(
        title: PiixCopiesDeprecated.appFailure,
        subtitle: PiixCameraCopiesDeprecated.errorFromImagePicker,
        iconData: Icons.info,
        cardBackgroundColor: PiixColors.error,
      );
      PiixBannerDeprecated.instance.builder(
        context,
        children: banner.build(context),
      );
    }
  }
}
