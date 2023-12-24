import 'package:flutter/material.dart';
import 'package:piix_mobile/membership_feature/membership_ui_barrel_file.dart';

import 'package:piix_mobile/utils/utils_barrel_file.dart';

///An [IDrawerOptionNavigation] class that builds a [MembershipDrawerOption]
///that shows "Contact us" option and navigates to [ContactScreen].
final class MembershipDrawerOptionContact extends StatelessWidget
    implements IDrawerOptionNavigation {
  const MembershipDrawerOptionContact({super.key});

  ///Return the AppLocalization message of "Contact us".
  @override
  String getOptionMessage(BuildContext context) =>
      context.localeMessage.contact;

  ///Navigates to [ContactScreen].
  @override
  void navigateTo(BuildContext context) {
    // TODO: implement navigateTo
  }

  @override
  Widget build(BuildContext context) {
    return MembershipDrawerOption(getOptionMessage(context), () => navigateTo);
  }
}
