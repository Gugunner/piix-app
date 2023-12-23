import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')

///This is a PIIX footer, contains a piix text, and  used at the bottom of the
///membership screen
///
class PiixFooterDeprecated extends StatelessWidget {
  const PiixFooterDeprecated({super.key, this.backgroundColor});
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: context.width,
        color: backgroundColor ?? Colors.transparent,
        margin: EdgeInsets.only(
          bottom: 10.h,
        ),
        child: Center(
          child: Text(
            PiixCopiesDeprecated.piix,
            style: context.textTheme?.bodyMedium?.copyWith(
              color: PiixColors.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
