import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_camera_dialog_deprecated/piix_camera_dialog_deprecated.dart';

@Deprecated('Will be removed in 4.0')
class PiixCameraInputImageDeprecated extends StatelessWidget {
  const PiixCameraInputImageDeprecated({
    Key? key,
    required this.formField,
    required this.index,
  }) : super(key: key);

  final FormFieldModelOld formField;
  final int index;

  @override
  Widget build(BuildContext context) {
    final piixCameraDialog = PiixCameraDialogDeprecated(formField: formField);
    final networkImages = formField.networkImages;
    return GestureDetector(
      onTap: () => piixCameraDialog.showImageCatalogDialog(
        screenContext: context,
      ),
      child: Container(
        width: context.width * 0.262,
        height: context.height * 0.2,
        margin: EdgeInsets.only(
          left: 8.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: formField.hasMinimumImages
                ? PiixColors.black
                : PiixColors.errorText,
          ),
          image: DecorationImage(
            image: networkImages.isNotEmpty
                ? Image.network(
                    networkImages[index],
                    loadingBuilder: ((context, error, progress) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: PiixColors.twilightBlue,
                        ),
                      );
                    }),
                    errorBuilder: ((context, error, stackTrace) {
                      return const Placeholder(
                        color: PiixColors.black,
                      );
                    }),
                  ).image
                : Image.file(
                    File(
                      formField.capturedImages![index].path,
                    ),
                    errorBuilder: ((context, error, stackTrace) {
                      return const Placeholder(
                        color: PiixColors.black,
                      );
                    }),
                  ).image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
