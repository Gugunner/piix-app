import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/utils/extensions/list_extend.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/input_form_feature_deprecated/domain/bloc/document_input_ui_state.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_document_input_deprecated/piix_camera_button_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_document_input_deprecated/piix_camera_input_preview_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_document_input_deprecated/piix_image_picker_button_deprecated.dart';

@Deprecated('Use instead AppOnActionDocumentField')
class PiixDocumentInputDeprecated extends ConsumerStatefulWidget {
  const PiixDocumentInputDeprecated({
    Key? key,
    required this.formField,
  }) : super(key: key);

  final FormFieldModelOld formField;

  @override
  ConsumerState<PiixDocumentInputDeprecated> createState() =>
      _PiixDocumentInputState();
}

class _PiixDocumentInputState
    extends ConsumerState<PiixDocumentInputDeprecated> {
  late DocumentInputUiStateDeprecated documentInputUiState;

  @override
  void initState() {
    super.initState();
    documentInputUiState = DocumentInputUiStateDeprecated(setState: setState);
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.formField.capturedImages ?? [];
    final networkImages = widget.formField.networkImages;
    final count =
        networkImages.isNotEmpty ? networkImages.length : images.length;
    ref.watch(formNotifierProvider);
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: context.height * 0.0085,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: context.width,
            child: Text(
              widget.formField.name,
              style: context.textTheme?.bodyMedium?.copyWith(
                color: widget.formField.hasMinimumImages &&
                        widget.formField.responseErrorText.isNullOrEmpty
                    ? PiixColors.infoDefault
                    : PiixColors.error,
                height: 12.sp / 12.sp,
              ),
            ),
          ),
          if (widget.formField.document.isNotNullEmpty)
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              width: context.width,
              child: Text(
                widget.formField.document!,
                style: context.textTheme?.bodyMedium?.copyWith(
                  color: widget.formField.hasMinimumImages &&
                          widget.formField.responseErrorText.isNullOrEmpty
                      ? PiixColors.infoDefault
                      : PiixColors.error,
                  height: 12.sp / 12.sp,
                ),
              ),
            ),
          SizedBox(
            height: 16.h,
          ),
          Builder(
            builder: (context) {
              if (images.isNotNullOrEmpty || networkImages.isNotEmpty) {
                return PiixCameraInputPreviewDeprecated(
                  formField: widget.formField,
                  count: count,
                  documentInputUiState: documentInputUiState,
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PiixCameraButtonDeprecated(
                    formField: widget.formField,
                    documentInputUiState: documentInputUiState,
                  ),
                  PiixImagePickerButtonDeprecated(
                    formField: widget.formField,
                    documentInputUiState: documentInputUiState,
                  ),
                ],
              );
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
