import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_string_text_form_field_deprecated/piix_string_text_form_field_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/icon_utils.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/id_utils.dart';

@Deprecated('No longer in use in 4.0')

///The widget can only be used inside a [PiixStringTextFormFieldDeprecated] since it needs both the message of the [tooltip]
///and the [id] which both are obtained from a [FormFieldModel].
class PiixStringTextFormFieldTooltipDeprecated extends StatelessWidget {
  const PiixStringTextFormFieldTooltipDeprecated({
    Key? key,
    this.tooltip,
    required this.id,
  }) : super(key: key);

  ///The message to be shown in the tooltip
  final String? tooltip;

  ///An Id needed to recover the Icon to be used as the trigger
  final FieldIdDeprecated id;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      showDuration: const Duration(minutes: 2),
      margin: EdgeInsets.symmetric(horizontal: 13.6.w),
      padding: EdgeInsets.symmetric(
        horizontal: 10.h,
        vertical: 16.h,
      ),
      decoration: const BoxDecoration(
        color: PiixColors.contrast,
      ),
      triggerMode: TooltipTriggerMode.tap,
      textStyle: context.bodySmall?.copyWith(
        color: PiixColors.white,
      ),
      message: tooltip,
      child: Icon(
        IconUtils.toIcon(id),
        color: PiixColors.clearBlue,
      ),
    );
  }
}
