import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'sign_in_or_sign_up/piix_app_bar_logo.dart';

class AuthAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AuthAppBarWidget({
    super.key,
    this.isFirstScreen = false,
  });

  final bool isFirstScreen;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: isFirstScreen ? const SizedBox() : null,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const PiixAppBarLogo(),
          SizedBox(
            width: 16.w,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
