import 'package:flutter/material.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/navigation_bar/navigation_bar_barrel_file.dart';

///A defined store icon and text to use as a [BottomNavigationBarItem]
///inside a [BottomNavigationBar].
final class StoreBarItem extends AppNavigationBarItem {
  StoreBarItem(this.context, {super.notificationsCount})
      : super(
          iconData: Icons.storefront_outlined,
          label: context.localeMessage.store,
        );

  final BuildContext context;
}
