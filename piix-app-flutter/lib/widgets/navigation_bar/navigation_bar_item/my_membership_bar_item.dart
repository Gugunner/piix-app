import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_icons.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/navigation_bar/navigation_bar_item/app_navigation_bar_item.dart';

///A defined membership icon and text to use as a [BottomNavigationBarItem]
///inside a [BottomNavigationBar].
final class MyMembershipBarItem extends AppNavigationBarItem {
  MyMembershipBarItem(this.context, {super.notificationsCount})
      : super(
          iconData: PiixIcons.membresias,
          label: context
              .localeMessage
              .membership,
        );

  final BuildContext context;
}
