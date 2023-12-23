import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')

///Builds a constrained dialog title
class AppDialogTitleDeprecated extends StatelessWidget {
  const AppDialogTitleDeprecated(this.title, {super.key, this.color});

  ///The header of the dialog
  final String title;

  ///The text color
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 240.w),
      child: Text(
        title,
        style: context.headlineSmall?.copyWith(
          color: color ?? PiixColors.infoDefault,
        ),
        textAlign: TextAlign.center,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
