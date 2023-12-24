import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/ui/common/piix_text_form_field_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/validators.dart';

///This widget is a change credential input, contains a phone and email input
class ChangeCredentialInput extends StatefulWidget {
  const ChangeCredentialInput({
    Key? key,
    required this.isEmail,
    required this.refresh,
    this.controller,
  }) : super(key: key);
  final bool isEmail;
  final VoidCallback refresh;
  final TextEditingController? controller;

  @override
  State<ChangeCredentialInput> createState() => _ChangeCredentialInputState();
}

class _ChangeCredentialInputState extends State<ChangeCredentialInput> {
  String? otherResponse = ConstantsDeprecated.ladas.first;

  //Use if the lada can be selected
  void _onUpdateStringResponse(String? value) {
    setState(() {
      otherResponse = value;
    });
  }

  TextStyle labelStyle(BuildContext context) =>
      context.labelSmall?.copyWith(
        color: otherResponse.isNotNullEmpty
            ? PiixColors.azure
            : PiixColors.brownishGrey,
      ) ??
      const TextStyle();

  TextStyle floatingLabelStyle(BuildContext context) =>
      context.labelSmall?.copyWith(
        color: otherResponse.isNotNullEmpty
            ? PiixColors.azure
            : PiixColors.brownishGrey,
      ) ??
      const TextStyle();

  TextStyle helperStyle(BuildContext context) =>
      context.bodySmall?.copyWith(
        color: otherResponse.isNotNullEmpty
            ? PiixColors.azure
            : PiixColors.mainText,
      ) ??
      const TextStyle();

  TextStyle style(BuildContext context) =>
      context.titleSmall?.copyWith(
        color: PiixColors.black,
      ) ??
      const TextStyle();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!widget.isEmail)
          Container(
            margin: EdgeInsets.only(
              right: context.width * 0.05,
            ),
            width: context.width * 0.15,
            padding: EdgeInsets.only(
              top: 3.6.sp,
            ),
            child: DropdownButtonFormField<String>(
              isDense: true,
              value: ConstantsDeprecated.ladas.first,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: otherResponse.isNotNullEmpty
                        ? PiixColors.azure
                        : PiixColors.gunMetal,
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: PiixColors.azure,
                  ),
                ),
                contentPadding: EdgeInsets.only(
                  top: 5.4.sp,
                  bottom: 11.2.sp,
                ),
                labelStyle: labelStyle(context),
                floatingLabelStyle: floatingLabelStyle(context),
                labelText: '${PiixCopiesDeprecated.areaCode}*',
                helperStyle: helperStyle(context),
              ),
              items: ConstantsDeprecated.ladas
                  .map(
                    (lada) => DropdownMenuItem<String>(
                      child: Text(lada),
                      value: lada,
                      alignment: Alignment.center,
                    ),
                  )
                  .toList(),
              onChanged: null,
            ),
          ),
        const SizedBox(width: 4),
        Flexible(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: PiixTextFormFieldDeprecated(
              refreshUI: () {
                widget.refresh();
              },
              controller: widget.controller,
              keyboardType: widget.isEmail
                  ? TextInputType.emailAddress
                  : TextInputType.phone,
              helperText: widget.isEmail
                  ? PiixCopiesDeprecated.checkYourEmail
                  : PiixCopiesDeprecated.checkYourPhone,
              labelText: widget.isEmail
                  ? PiixCopiesDeprecated.email
                  : PiixCopiesDeprecated.phone,
              validator: (val) {
                if (widget.isEmail) {
                  if (!RegExp(Validators.emailValidator).hasMatch(val!)) {
                    return PiixCopiesDeprecated.typeValidateEmail;
                  }
                  return null;
                } else {
                  if ((val ?? '').length != 10 ||
                      !RegExp(Validators.noLadaPhoneValidator).hasMatch(val!)) {
                    return PiixCopiesDeprecated.typeValidPhone;
                  }
                  return null;
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
