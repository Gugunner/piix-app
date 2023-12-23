import 'package:flutter/material.dart';
import 'package:piix_mobile/camera_feature/camera_utils_barrel_file.dart';
import 'package:piix_mobile/file_feature/file_model_barrel_file.dart';
import 'package:piix_mobile/form_feature/ui/widgets/documentation_camera_form_field/documentation_camera_barrel_file.dart';
import 'package:piix_mobile/form_feature/utils/camera_input_decoration.dart';

///Controls the state of the [FileContentModel] picture and builds
///the DocumentationCameraField.
///
///Works as a wrap class that allows passing additional properties
///to its constructor.
class DocumentationCameraFormField extends FormField<FileContentModel?> {
  DocumentationCameraFormField({
    super.key,
    super.onSaved,
    super.validator,
    super.restorationId,
    CameraSilhouette? cameraSilhouette,
    bool readOnly = false,
    int maxLines = 1,
    bool? enabled,
    FocusNode? focusNode,
    CameraInputDecoration? decoration,
    AutovalidateMode? autovalidateMode,
    TextStyle? style,
    TextAlign? textAlign,
    ValueChanged<FileContentModel?>? onChanged,
    VoidCallback? onEditingComplete,
    ValueChanged<FileContentModel?>? onSubmitted,
    VoidCallback? onTap,
    VoidCallback? onDoubleTap,
    VoidCallback? onDeletePicture,
    VoidCallback? onReplacePicture,
    FileContentModel? initialPicture,
  }) : super(
            autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
            enabled: enabled ?? decoration?.enabled ?? true,
            builder: (FormFieldState<FileContentModel?> field) {
              final state = field as _CameraFormFieldState;
              final effectiveDecoration = (decoration ??
                      CameraInputDecoration())
                  .applyDefaults(Theme.of(state.context).inputDecorationTheme)
                  .copyWith(
                      errorText: field.errorText) as CameraInputDecoration;
              void onChangedHandler(FileContentModel? file) {
                field.didChange(file);
                if (onChanged != null) {
                  onChanged(file);
                }
              }

              return DocumentationCameraField(
                cameraSilhouette: cameraSilhouette ?? CameraSilhouette.id,
                readOnly: readOnly,
                maxLines: maxLines,
                enabled: enabled ?? effectiveDecoration.enabled,
                focusNode: focusNode,
                decoration: effectiveDecoration,
                style: style,
                textAlign: textAlign,
                onChanged: onChangedHandler,
                onEditingComplete: onEditingComplete,
                onSubmitted: onSubmitted,
                onTap: onDoubleTap,
                onDeletePicture: onDeletePicture,
                onReplacePicture: onReplacePicture,
                initialPicture: initialPicture,
              );
            });

  @override
  FormFieldState<FileContentModel?> createState() => _CameraFormFieldState();
}

class _CameraFormFieldState extends FormFieldState<FileContentModel?> {}
