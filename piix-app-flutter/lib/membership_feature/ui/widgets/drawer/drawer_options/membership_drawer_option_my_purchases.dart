import 'package:flutter/material.dart';
import 'package:piix_mobile/membership_feature/membership_ui_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

///An [IDrawerOptionNavigation] class that builds a [MembershipDrawerOption]
///that shows "My purchases" option and navigates to [MyPurchasesScreen].
final class MembershipDrawerOptionMyPurchases extends StatelessWidget
    implements IDrawerOptionNavigation {
  const MembershipDrawerOptionMyPurchases({super.key});

  ///Return the AppLocalization message of "My purchases".
  @override
  String getOptionMessage(BuildContext context) =>
      context.localeMessage.myPurchases;

  ///Navigates to [MyPurchasesScreen].
  @override
  void navigateTo(BuildContext context) {
    // TODO: implement navigateTo
  }

  @override
  Widget build(BuildContext context) {
    return MembershipDrawerOption(getOptionMessage(context), () => navigateTo);
  }
}
