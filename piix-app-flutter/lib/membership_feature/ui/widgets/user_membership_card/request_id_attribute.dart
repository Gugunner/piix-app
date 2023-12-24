import 'package:flutter/material.dart';
import 'package:piix_mobile/membership_feature/membership_ui_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

///A predefined class to show the [requestId].
final class RequestIdAttribute extends UserMembershipAttribute {
  RequestIdAttribute(this.context, {
    super.key,
    required this.requestId,
  }) : super(
          keyAttribute:
              context.localeMessage.requestId,
          value: requestId,
        );

  ///The id used by the membership.
  final String requestId;

  final BuildContext context;
}
