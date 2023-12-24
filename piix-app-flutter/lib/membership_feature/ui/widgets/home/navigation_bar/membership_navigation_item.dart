import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_icons.dart';
import 'package:piix_mobile/membership_feature/ui/widgets/home/navigation_bar/item_icon.dart';
import 'package:piix_mobile/utils/app_copies_barrel_file.dart';

///Use inside [MembershipNavigationBar] to show the membership home option
class MembershipNavigationItem extends BottomNavigationBarItem {
  const MembershipNavigationItem()
      : super(
          icon: const ItemIcon(icon: PiixIcons.membresias),
          backgroundColor: PiixColors.cloud,
          label: MembershipCopies.membership,
        );
}
