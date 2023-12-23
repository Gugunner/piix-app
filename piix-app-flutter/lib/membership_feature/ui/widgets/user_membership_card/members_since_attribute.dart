import 'package:flutter/material.dart';
import 'package:piix_mobile/membership_feature/membership_ui_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

///A predefined class that shows the user membership [memberSince].
final class MembershipSinceAttribute extends UserMembershipAttribute {
  MembershipSinceAttribute(
    this.context, {
    super.key,
    required this.memberSince,
  }) : super(
          keyAttribute: context.localeMessage.memberSince,
          value: DateLocalizationUtils.getDYM(context, memberSince),
        );

  ///The value that formatted to be shown.
  final DateTime memberSince;

  final BuildContext context;
}
