import 'package:flutter/material.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/utils/auth_user_copies.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

class LadaWidget extends StatelessWidget {
  const LadaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DropdownButtonFormField(
        value: ConstantsDeprecated.mexicanLada,
        //If more countries are added change this items value
        items: <DropdownMenuItem<String>>[
          const DropdownMenuItem(
            value: ConstantsDeprecated.mexicanLada,
            child: Text(
              ConstantsDeprecated.mexicanLada,
            ),
          ),
        ],
        //If the widget needs to be enabled, change this onChanged to an
        //anonymous function or a method
        onChanged: null,
        decoration: decoration(context),
      ),
    );
  }
}

extension _LadaWidgetDecoration on LadaWidget {
  InputDecoration decoration(BuildContext context) {
    TextStyle? labelStyle() => context.textTheme?.bodyMedium?.copyWith(
          color: PiixColors.secondary,
        );

    return InputDecoration(
      contentPadding: EdgeInsets.zero,
      helperText: '',
      helperStyle: context.textTheme?.labelMedium?.copyWith(
        color: Colors.transparent,
      ),
      errorText: null,
      errorStyle: context.textTheme?.labelMedium?.copyWith(
        color: PiixColors.error,
      ),
      labelText: AuthUserCopies.lada,
      labelStyle: labelStyle(),
      floatingLabelStyle: labelStyle(),
    );
  }
}
