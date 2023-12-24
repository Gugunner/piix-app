import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_icons.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/ui/common/logout_dialog/logout_dialog_deprecated.dart';
import 'package:piix_mobile/utils/app_copies_barrel_file.dart';

@Deprecated('Use instead SignOutButton')
class CloseSessionAction extends StatelessWidget {
  const CloseSessionAction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async =>
          showDialog(builder: (_) => const LogoutDialog(), context: context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            PiixCopiesDeprecated.closeSession,
            style: context.accentTextTheme?.headlineLarge?.copyWith(
              color: PiixColors.space,
            ),
          ),
          Icon(
            PiixIcons.logout,
            color: PiixColors.space,
            size: 32.w,
          ),
        ],
      ),
    );
  }
}
