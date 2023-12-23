import 'package:flutter/material.dart';
import 'package:piix_mobile/membership_feature/membership_ui_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

///A predefined class that shows the user [shortName].
final class ShortNameAttribute extends UserMembershipAttribute {
  ShortNameAttribute(this.context, {
    super.key,
    required this.shortName,
  }) : super(
          keyAttribute: context
              .localeMessage
              .mainHolder,
          value: shortName,
        );

  ///The value that is shown.
  final String shortName;

  final BuildContext context;
}
