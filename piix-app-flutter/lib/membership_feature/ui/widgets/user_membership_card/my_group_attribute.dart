import 'package:flutter/material.dart';
import 'package:piix_mobile/membership_feature/membership_ui_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

///A predefined class that shows the user [userCount].
final class MyGroupAttribute extends UserMembershipAttribute {
  MyGroupAttribute(this.context, {
    super.key,
    required this.userCount,
  }) : super(
          keyAttribute:
             context.localeMessage.myGroup,
          value: context
              .localeMessage
              .totalUsers(userCount),
        );

  ///The value that is shown.
  final int userCount;

  final BuildContext context;
}
