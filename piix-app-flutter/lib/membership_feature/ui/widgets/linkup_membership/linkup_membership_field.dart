import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';
import 'package:piix_mobile/form_feature/ui/widgets/text_form_field/text_form_field_barrel_file.dart';

///The [FormField] use to enter the [linkupCode].
///
///This field should set to false [enabled] when the [linkupCode]
///has been checked and is ready to be submitted.
///
///Pass on an [apiError] to check for the specific error codes
///used to set the error text of this.
final class LinkupMembershipField extends StatefulWidget {
  const LinkupMembershipField({
    super.key,
    this.enabled = true,
    this.onChanged,
    this.onSaved,
    this.apiError,
    this.onEditCode,
    this.focusNode,
  });

  final bool enabled;

  final ValueChanged<String>? onChanged;

  final Function(String?)? onSaved;

  final AppApiException? apiError;

  final FocusNode? focusNode;

  final VoidCallback? onEditCode;

  @override
  State<LinkupMembershipField> createState() => _LinkupMembershipFieldState();
}

class _LinkupMembershipFieldState extends State<LinkupMembershipField>
    with AppRegex {
  late FocusNode focusNode;

  int get _minLength => 6;

  @override
  void initState() {
    super.initState();
    focusNode = widget.focusNode ?? FocusNode();
  }

  String _getEnterInvitationCodeMessage(BuildContext context) =>
      context.localeMessage.enterInvitationCode;

  String _getEnteredInvitationCodeMessage(BuildContext context) =>
      context.localeMessage.enteredInvitationCode;

  String _getHasSubmittedMessage(BuildContext context) {
    if (!widget.enabled) return _getEnteredInvitationCodeMessage(context);
    return _getEnterInvitationCodeMessage(context);
  }

  String _getEditCodeMessage(BuildContext context) =>
      context.localeMessage.editCode;

  String? _validator(String? value) {
    final localeMessage = context.localeMessage;
    if (value.isNullOrEmpty) return localeMessage.emptyField;
    if (!validInvitationCode(value!)) return localeMessage.invalidCodeFormat;
    if (value.characters.length < _minLength)
      return localeMessage.wrongMinLength(_minLength);

    ///If no api error is found then no error is shown.
    if (widget.apiError == null) return null;
    if (widget.apiError!.errorCodes.isNullOrEmpty) return null;

    ///Checks for specific community linkup error codes
    if (widget.apiError!.errorCodes!.contains(apiInvalidLinkupCode))
      //TODO: Change copy
      return localeMessage.invalidLinkupCode;

    if (widget.apiError!.errorCodes!.contains(apiUserIsAlreadyInTheCommunity) ||
        widget.apiError!.errorCodes!.contains(apiUserIsAlreadyInACommunity))
      return localeMessage.userIsAlreadyInCommunity;

    ///Checks for specific family group linkup error codes
    if (widget.apiError!.errorCodes!.contains(apiInvalidInvitationCode))
      return localeMessage.invalidLinkupCode;

    if (widget.apiError!.errorCodes!.contains(apiUserCannotUseSlot))
      return localeMessage.userCannotUseSlot;

    if (widget.apiError!.errorCodes!.contains(apiUserIsAlreadyInGroup))
      return localeMessage.userIsAlreadyInGroup;

    if (widget.apiError!.errorCodes!.contains(apiSlotIsNotOpen))
      return localeMessage.slotIsNotOpen;

    return null;
  }

  void _onEditCode() {
    widget.onEditCode?.call();
    //A small delayed is needed to allow the previous code to run
    //before requesting focus, this is because when a rebuild happens
    //no focus can be requested.
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        focusNode.requestFocus();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GeneralTextFormField(
          enabled: widget.enabled,
          handleFocusNode: true,
          onChanged: widget.onChanged,
          onSaved: widget.onSaved,
          newFocusNode: focusNode,
          errorMaxLines: 3,
          helperMaxLines: 3,
          labelText: _getHasSubmittedMessage(context),
          validator: _validator,
          textInputAction: TextInputAction.done,
        ),
        SizedBox(height: 20.h),
        if (!widget.enabled)
          Center(
            child: AppTextSizedButton.title(
              text: _getEditCodeMessage(context),
              onPressed: _onEditCode,
            ),
          ),
      ],
    );
  }
}
