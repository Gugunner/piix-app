import 'package:flutter/material.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/navigation_bar/navigation_bar_barrel_file.dart';

///A defined group icon and text to use as a [BottomNavigationBarItem]
///inside a [BottomNavigationBar].
final class MyGroupBarItem extends AppNavigationBarItem {
  MyGroupBarItem(this.context, {super.notificationsCount})
      : super(
          iconData: Icons.diversity_3,
          label:
              context.localeMessage.myGroup,
        );

  final BuildContext context;
}
