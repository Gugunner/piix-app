import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/form_feature/form_utils_barrel_file.dart';
import 'package:piix_mobile/form_feature/ui/widgets/documentation_camera_form_field/dashed_border_painter.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/input_form_feature_deprecated/domain/bloc/document_input_ui_state.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/piix_camera_copies.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/piix_document_input_utils_deprecated.dart';

@Deprecated('Will be removed in 4.0')
class PiixCameraButtonDeprecated extends ConsumerWidget {
  const PiixCameraButtonDeprecated({
    super.key,
    required this.formField,
    required this.documentInputUiState,
  });

  final FormFieldModelOld formField;
  final DocumentInputUiStateDeprecated documentInputUiState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(formNotifierProvider);
    return GestureDetector(
      onTap: () => toCameraScreen(
        context,
        formField: formField,
        documentInputUiState: documentInputUiState,
      ),
      child: CustomPaint(
        foregroundPainter: const RoundOutlinedDashedBorderPainter(
          color: PiixColors.space,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 16,
          ),
          height: context.width * 0.382,
          width: context.width * 0.382,
          decoration: decoration,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: PiixColors.active,
                    size: 40.h,
                  ),
                ),
                SizedBox(
                  child: Text(
                    PiixCameraCopiesDeprecated.takePhoto,
                    style: context.primaryTextTheme?.titleSmall,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//TODO: Add documentation
extension _PiixCameraButtonDecorator on PiixCameraButtonDeprecated {
  BoxDecoration get decoration => BoxDecoration(
        borderRadius: BorderRadius.circular(
          8,
        ),
        border: Border.all(
          color: PiixColors.secondaryText,
        ),
      );
}
