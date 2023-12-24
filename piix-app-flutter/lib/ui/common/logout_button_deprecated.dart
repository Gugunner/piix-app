import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_icons.dart';
import 'package:piix_mobile/ui/common/logout_dialog/logout_dialog_deprecated.dart';
import 'package:piix_mobile/widgets/button/text_app_button/text_app_button_deprecated.dart';

@Deprecated('Use instead SignOutButton')

/// This widget shows a logout button
class LogoutButtonOld extends StatelessWidget {
  const LogoutButtonOld({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextAppButtonDeprecated(
      onPressed: () async =>
          showDialog(builder: (_) => const LogoutDialog(), context: context),
      icon: PiixIcons.logout,
      text: PiixCopiesDeprecated.logout,
      type: 'two',
      iconSize: 24.sp,
    );
  }
}
