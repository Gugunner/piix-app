import 'package:flutter/material.dart';
import 'package:piix_mobile/auth_feature/ui/widgets/sign_out_button.dart';
import 'package:piix_mobile/user_profile_feature/user_profile_ui_barrel_file.dart';

///A predefined footer [Column] subclass to be used as the 
///child of [AppDrawerFooter].
final class MembershipFooter extends Column {
  MembershipFooter({super.key})
      : super(children: [
          const SignOutButton(),
          const CopyRightLabel(),
        ]);
}
