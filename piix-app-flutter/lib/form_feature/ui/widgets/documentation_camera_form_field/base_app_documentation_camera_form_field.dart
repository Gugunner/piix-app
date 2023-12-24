import 'package:flutter/material.dart';
import 'package:piix_mobile/camera_feature/camera_utils_barrel_file.dart';
import 'package:piix_mobile/file_feature/file_model_barrel_file.dart';
import 'package:piix_mobile/form_feature/form_utils_barrel_file.dart';
import 'package:piix_mobile/form_feature/ui/widgets/documentation_camera_form_field/documentation_camera_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

///The class which constitutes any [DocumentationCameraFormField]
///implementation.
///
///Since it is used inside a form it requires an [index] value that may or
///may not be passed to, this [index] is used in conjunction with the [required]
///property when executing the [onHandleForm] to pass on the values up to the
///parent [Form] class and store in the corresponding
///[AnswerModel] by referencing it through the [index]
///and updating whether this is [required] or not.
///
///Passing [handleFocusNode] with the true value implies that it will handle
///a [newFocusNode] which needs to be passed or an assert failure condition will
///execute.
///
///Passing [onSaved], [onChanged], [onEditingComplete] and [onFieldSubmitted]
///means that this needs to build a [AppDocumentationCameraFormField]
///and that the execution of those callbacks will occur in the following manner:
///First the [onChanged] method is executed.
///Second A - if the [AppDocumentationCameraFormField] passes focus to the
///next element then it executes [onEditingComplete].
///Second B - if the [AppDocumentationCameraFormField] will instead finish
///and submit the form then [onFieldSubmitted] is executed.
///Third when the [Form.key.currentState] executes [save()] then [onSaved]
///is executed.
///
///Passing [initialPictureData] will result in the
///[AppDocumentationCameraFormField] showing inside an [Image.file].
///
///Passing [onDeletePicture] or [onReplacePicture] will determine what happens
///when the picture is confirm to be deleted or confirm that should be replaced.
abstract class BaseAppDocumentationCameraFormField extends StatefulWidget {
  const BaseAppDocumentationCameraFormField({
    super.key,
    required this.cameraSilhouette,
    this.index = 0,
    this.enabled = true,
    this.required = true,
    this.handleFocusNode = false,
    this.readOnly = false,
    this.onSaved,
    this.onChanged,
    this.onHandleForm,
    this.validator,
    this.autovalidateMode,
    this.initialPicture,
    this.newFocusNode,
    this.onTap,
    this.onTapOutside,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onDeletePicture,
    this.onReplacePicture,
    this.onFocus,
    this.helperText,
    this.labelText,
    this.errorText,
    this.actionText,
    this.hintText,
    this.inputDecoration,
    this.apiException,
  }) : assert(!handleFocusNode || newFocusNode != null);

  ///Determines what silhouette layer to show in the
  ///[DocumentationCameraScreen].
  final CameraSilhouette cameraSilhouette;

  ///Helps reference the correct [AnswerModel].
  final int index;

  ///Allows the [AppDocumentationCameraFormField] to be
  ///interacted with.
  final bool enabled;

  ///Used by the parent class to check if all
  ///required fields have been filled.
  final bool required;

  ///Set the value to true if a [newFocusNode]
  ///will be used.
  final bool handleFocusNode;

  ///Does not allow the [AppDocumentationCameraFormField]
  ///to be modified.
  final bool readOnly;

  ///Executes when [Form.key.currentState] save() is executed.
  final ValueChanged<FileContentModel?>? onSaved;

  ///Executes each time a picture is taken, edited or deleted.
  final ValueChanged<FileContentModel?>? onChanged;

  ///Passes the values to store the picture data in the
  ///correct [AnswerModel].
  final HandleFormValue<FileContentModel?>? onHandleForm;

  ///Controls if [AppDocumentationCameraFormField] has an error.
  final String? Function(FileContentModel?)? validator;

  ///Manipulates when validation should occur.
  final AutovalidateMode? autovalidateMode;

  ///The initial data to be processed as an [Image].
  final FileContentModel? initialPicture;

  ///Controls focus for the [AppDocumentationCameraFormField].
  final FocusNode? newFocusNode;

  final VoidCallback? onTap;

  final TapRegionCallback? onTapOutside;

  ///Executes if focus is moved to next element.
  final VoidCallback? onEditingComplete;

  ///Executes if submitting this.
  final ValueChanged<FileContentModel?>? onFieldSubmitted;

  final VoidCallback? onDeletePicture;

  final VoidCallback? onReplacePicture;

  final VoidCallback? onFocus;

  final String? helperText;

  final String? labelText;

  final String? errorText;

  final String? actionText;

  final String? hintText;

  final CameraInputDecoration? inputDecoration;

  final AppApiException? apiException;
}

abstract class BaseAppDocumentationCameraFormFieldState<
    T extends BaseAppDocumentationCameraFormField> extends State<T> {
  ///Controls this focus.
  FocusNode? focusNode;

  ///Controls [AppDocumentationCameraFormField] validation mode.
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String get requiredMark => widget.required ? '*' : '';

  //Declare a helperText.
  String? get helperText {
    if (widget.helperText.isNotNullEmpty) {
      return widget.helperText;
    }
    if (widget.required) {
      return context.localeMessage.requiredField;
    }
    return null;
  }

  //Declare a labelText, if this is [required]
  //mark it with * at the end.
  String? get labelText {
    if (widget.labelText.isNotNullEmpty) {
      return widget.labelText! + (widget.required ? '*' : '');
    }
    return null;
  }

  String get actionText =>
      widget.actionText ?? context.localeMessage.takeAPhoto;

  String get hintText => widget.hintText ?? '';

  @override
  void initState() {
    super.initState();
    //initializes the [focusNode] only if
    //[useInternalFocusNode] is true.
    if (widget.handleFocusNode) {
      focusNode = widget.newFocusNode;
    }
  }

  @override
  void dispose() {
    if (widget.handleFocusNode) {
      //Correctly removes and disposes the [focusNode]
      //listener.
      focusNode?.dispose();
    }

    super.dispose();
  }

  ///Handles the internal validator of the [AppDocumentationCameraFormField].
  String? validator(FileContentModel? value);

  ///Sets [autovalidateMode] to always after submitting once the form
  ///with [AppDocumentationCameraFormField].
  void onSaved(FileContentModel? value) {
    if (widget.onSaved != null) widget.onSaved?.call(value);
    //Pass value to parent call to store information
    //of the answers for the parent Form.
    widget.onHandleForm?.call(
      value: value,
      index: widget.index,
      required: widget.required,
    );
    if (autovalidateMode == AutovalidateMode.disabled ||
        autovalidateMode == AutovalidateMode.onUserInteraction)
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
  }

  ///Sets [autovalidateMode] to onUserInteraction only if it changes
  ///after the user has [submitted] once and an error on the
  ///[AppDocumentationCameraFormField]
  ///occurred.
  void onChanged(FileContentModel? value) {
    widget.onChanged?.call(value);
    //Pass value to parent call to store information
    //of the answers for the parent Form.
    widget.onHandleForm?.call(
      value: value,
      index: widget.index,
      required: widget.required,
    );
    if (autovalidateMode == AutovalidateMode.always)
      setState(() {
        autovalidateMode = AutovalidateMode.onUserInteraction;
      });
  }

  ///Handles the focus listener of [focusNode].
  void onFocus() => throw UnimplementedError();

  @override
  AppDocumentationCameraFormField build(BuildContext context);
}
