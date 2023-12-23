import 'package:flutter/material.dart';
import 'package:piix_mobile/form_feature/form_utils_barrel_file.dart';
import 'package:piix_mobile/form_feature/ui/widgets/documentation_camera_form_field/documentation_camera_barrel_file.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

base class AppDocumentationCameraFormField
    extends DocumentationCameraFormField {
  AppDocumentationCameraFormField({
    super.key,
    super.onSaved,
    super.validator,
    super.restorationId,
    super.cameraSilhouette,
    super.readOnly,
    super.maxLines,
    super.enabled,
    super.focusNode,
    super.autovalidateMode,
    super.onChanged,
    super.onEditingComplete,
    super.onSubmitted,
    super.onTap,
    super.onDoubleTap,
    super.onDeletePicture,
    super.onReplacePicture,
    super.initialPicture,
    this.errorText,
    this.helperText,
    this.labelText,
    this.actionText,
    this.hintText,
    this.errorMaxLines,
    this.helperMaxLines,
    this.hintMaxLines,
    this.contentPadding,
  }) : super(
          decoration: CameraInputDecoration(
            labelText: labelText,
            helperText: helperText,
            errorText: errorText,
            actionText: actionText,
            hintText: hintText,
            errorMaxLines: errorMaxLines,
            helperMaxLines: helperMaxLines,
            hintMaxLines: hintMaxLines,
            enabled: enabled ?? true,
            contentPadding: contentPadding,
            fillColor: PiixColors.active.withAlpha(80),
            focusColor: PiixColors.active,
            disabledColor: PiixColors.secondary,
          ),
        );

  ///The text shown when the [DocumentationCameraFormField] has
  ///an error.
  final String? errorText;

  ///The text shown below the [DocumentationCameraFormField] to
  ///indicate what the user needs to comply with.
  final String? helperText;

  ///The text shown in the [DocumentationCameraFormField] to
  ///knwow what the field is for.
  final String? labelText;

  ///The text shown in the [DocumentationCameraFormField] to
  ///knwow what the field can do.
  final String? actionText;

  ///The text shown in the [DocumentationCameraFormField] to
  ///knwow what the field needs to have.
  final String? hintText;

  ///Maximum number of lines an error can show below the
  ///[DocumentationCameraFormField].
  final int? errorMaxLines;

  ///Maximum number of lines a help text can show below the
  ///[DocumentationCameraFormField].
  final int? helperMaxLines;

  ///Maximum number of lines a hint text can show below the
  ///[DocumentationCameraFormField].
  final int? hintMaxLines;

  ///Allows to acommodate the content to make bigger or smaller
  ///the input space.
  final EdgeInsets? contentPadding;
}
