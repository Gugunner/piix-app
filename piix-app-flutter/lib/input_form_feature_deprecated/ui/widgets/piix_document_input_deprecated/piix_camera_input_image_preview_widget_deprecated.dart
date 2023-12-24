import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_document_input_deprecated/piix_camera_input_image_deprecated.dart';

@Deprecated('Will be removed in 4.0')
class PiixCameraInputImagePreviewWidgetDeprecated extends ConsumerWidget {
  const PiixCameraInputImagePreviewWidgetDeprecated({
    Key? key,
    required this.index,
    required this.formField,
  }) : super(key: key);

  final FormFieldModelOld formField;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(formNotifierProvider.notifier);
    final networkImages = formField.networkImages;
    return Stack(
      children: [
        if (networkImages.isNotEmpty)
          Container(
            width: context.width * 0.262,
            height: context.height * 0.2,
            margin: EdgeInsets.only(
              left: 8.w,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: PiixColors.secondaryMain,
              ),
            ),
            child: SizedBox(
              child: Icon(
                Icons.photo_camera_back_outlined,
                size: 48.w,
                color: PiixColors.twilightBlue,
              ),
            ),
          )
        else ...[
          Container(
            margin: EdgeInsets.only(
              right: 8.w,
            ),
            width: context.width * 0.262,
            height: context.height * 0.24,
            child: Center(
              child: PiixCameraInputImageDeprecated(
                formField: formField,
                index: index,
              ),
            ),
          ),
          Positioned(
            top: -8,
            right: -8,
            child: PiixCameraEraseImageFromPreviewButtonDeprecated(
              formField: formField,
              index: index,
            ),
          ),
        ]
      ],
    );
  }
}

@Deprecated('Will be removed in 4.0')
class PiixCameraEraseImageFromPreviewButtonDeprecated extends ConsumerWidget {
  const PiixCameraEraseImageFromPreviewButtonDeprecated({
    Key? key,
    required this.formField,
    required this.index,
  }) : super(key: key);

  final FormFieldModelOld formField;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        ref.read(formNotifierProvider.notifier).removeCapturedImage(
              formField,
              index,
            );
      },
      icon: Container(
        height: 20.w,
        width: 20.w,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: PiixColors.errorText,
        ),
        child: Center(
          child: Icon(
            Icons.close_rounded,
            size: 12.w,
            color: PiixColors.white,
          ),
        ),
      ),
    );
  }
}
