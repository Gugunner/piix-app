import 'package:flutter/material.dart';
import 'package:piix_mobile/widgets/modal/modal_barrel_file.dart';
import 'package:piix_mobile/form_feature/ui/widgets/text_form_field/text_form_field_barrel_file.dart';

///Base class to build a modal [Dialog].
///
///There are two versions of the modal that
///can be used. One that is a simple [Dialog] with
///an [onAccept] button and may also contain an [onCancel] button.
///And an [input] factory constructor used
///for second degree confirmation when a user makes an interaction
base class AppModal extends Modal {
  const AppModal({
    super.key,
    required super.title,
    super.loading,
    super.onAccept,
    super.onAcceptText,
    super.onCancel,
    super.onCancelText,
    super.child,
    super.childGap,
    super.actionGap,
  });

  ///Call this constructor when a second degree
  ///confirmation is needed in the app.
  const factory AppModal.input({
    required Widget title,
    bool loading,
    String? onAcceptText,
    VoidCallback? onAccept,
    String? onCancelText,
    VoidCallback? onCancel,
    Widget? child,
    double? childGap,
    double? actionGap,
  }) = _AppModalInput;
}

///The modal with an input for a second degree confirmation
///by default uses an [BaseAppTextFormField].
final class _AppModalInput extends AppModal {
  const _AppModalInput({
    required super.title,
    super.loading = false,
    super.onAcceptText,
    super.onAccept,
    super.onCancelText,
    super.onCancel,
    super.childGap,
    super.actionGap,
    Widget? child,
  }) : super(
          child: child ?? const GeneralTextFormField(),
        );
}
