import 'package:flutter/material.dart';
import 'package:piix_mobile/file_feature/file_model_barrel_file.dart';
import 'package:piix_mobile/form_feature/ui/widgets/documentation_camera_form_field/documentation_camera_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

final class IdentificationFormField
    extends BaseAppDocumentationCameraFormField {
  const IdentificationFormField({
    super.key,
    required super.cameraSilhouette,
    super.index,
    super.enabled,
    super.required,
    super.handleFocusNode,
    super.readOnly,
    super.onSaved,
    super.onChanged,
    super.onHandleForm,
    super.validator,
    super.initialPicture,
    super.newFocusNode,
    super.onEditingComplete,
    super.onFieldSubmitted,
    super.onFocus,
    super.helperText,
    super.labelText,
    super.errorText,
    super.actionText,
    super.hintText,
    super.inputDecoration,
    super.apiException,
  });

  @override
  State<StatefulWidget> createState() => _IdentificationFormFieldState();
}

final class _IdentificationFormFieldState
    extends BaseAppDocumentationCameraFormFieldState<IdentificationFormField> {
  @override
  String get hintText =>
      context.localeMessage.takeAPictureOfYourOfficialIdentification;

  @override
  String? validator(FileContentModel? value) {
    //If a [validator] callback is passed then it replaces this
    //method.
    if (widget.validator != null) return widget.validator?.call(value);
    final localeMessage = context.localeMessage;
    final apiException = widget.apiException;
    //If no api error is found then no error is shown.
    if (apiException == null) return null;
    if (apiException.errorCodes.isNullOrEmpty) return null;
    //Checks for specific error codes.
    //TODO: Change to real documentation or selfie errors
    if (apiException.errorCodes!.contains(apiEmailAlreadyUsed))
      return localeMessage.alreadyUsedEmail;
    return null;
  }

  ///Unfocus the [AppTextFormField] if
  /// [useInternalFocusNode] is true when
  /// the user taps outside the this.
  void onTapOutside(PointerDownEvent? event) {
    if (widget.handleFocusNode) {
      focusNode?.unfocus();
    }
  }

  @override
  void onFocus() => widget.onFocus?.call();

  @override
  AppDocumentationCameraFormField build(BuildContext context) {
    return AppDocumentationCameraFormField(
      onSaved: widget.onSaved,
      validator: validator,
      cameraSilhouette: widget.cameraSilhouette,
      readOnly: widget.readOnly,
      maxLines: 3,
      enabled: widget.enabled,
      focusNode: focusNode,
      autovalidateMode: autovalidateMode,
      onChanged: onChanged,
      onSubmitted: widget.onFieldSubmitted,
      initialPicture: widget.initialPicture,
      helperText: helperText,
      labelText: labelText,
      actionText: actionText,
      hintText: hintText,
      errorMaxLines: 3,
      helperMaxLines: 3,
      hintMaxLines: 3,
    );
  }
}
