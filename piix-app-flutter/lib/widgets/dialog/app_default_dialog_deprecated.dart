import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/widgets/dialog/app_dialog_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///The most basic dialog where the content is just a
///plain String [title] and can have a [message] body.
abstract class AppDefaultDialogDeprecated extends AppDialogDeprecated {
  AppDefaultDialogDeprecated({
    super.key,
    required super.title,
    this.message,
    super.isCompact,
  }) : super(
          maxWidth: 272.w,
          minHeight: 150.h,
          maxHeight: 480.h,
          dialogContent: _AppDefaultDialogMessageDeprecated(message),
        );

  ///A detailed explanation of what is happening when the dialog was
  ///shown
  final String? message;
}

@Deprecated('Will be removed in 4.0')

///The message body of the dialog
class _AppDefaultDialogMessageDeprecated extends StatelessWidget {
  const _AppDefaultDialogMessageDeprecated(this.message);

  ///A detailed explanation of what is happening when the dialog was
  ///shown
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Text(
      message ?? '',
      style: context.bodyMedium?.copyWith(color: PiixColors.infoDefault),
      textAlign: TextAlign.center,
    );
  }
}
