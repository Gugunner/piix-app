import 'package:flutter/src/widgets/framework.dart';
import 'package:piix_mobile/membership_feature/membership_ui_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

///An [IDrawerOptionNavigation] class that builds a [MembershipDrawerOption]
///that shows "Manage my group" option and navigates to [MyGroupHomeScreen].
final class MembershipDrawerOptionMyGroup
    extends StatelessWidget implements IDrawerOptionNavigation {
  const MembershipDrawerOptionMyGroup({super.key});

  ///Return the AppLocalization message of "Manage my group".
  @override
  String getOptionMessage(BuildContext context) =>
      context.localeMessage.manageMyGroup;

  ///Navigates to [MyGroupHomeScreen].
  @override
  void navigateTo(BuildContext context) {
    // TODO: implement navigateTo
  }

  @override
  Widget build(BuildContext context) {
    return MembershipDrawerOption(getOptionMessage(context), () => navigateTo);
  }
}
