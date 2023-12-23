import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_icons.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/navigation_bar/navigation_bar_barrel_file.dart';

///A defined profile icon and text to use as a [BottomNavigationBarItem]
///inside a [BottomNavigationBar].
final class MyProfileBarItem extends AppNavigationBarItem {
  MyProfileBarItem(this.context, {super.notificationsCount})
      : super(
          iconData: PiixIcons.perfil,
          label:
              context.localeMessage.profile,
        );

  final BuildContext context;
}
