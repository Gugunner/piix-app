import 'package:flutter/material.dart';
import 'package:piix_mobile/utils/theme/theme_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';

///A predefined Material Button that invites the user to link
///its membership to a family group or community.
final class LinkMembershipPanelButton extends AppPanelButton {
  LinkMembershipPanelButton(this.context, {super.key, required super.onPressed})
      : super(
          title: Text(
            context
                .localeMessage
                .linkYourMembership,
          ),
          description: Text(
            context
                .localeMessage
                .linkToYourGroupOrCommunity,
            style: BaseTextTheme().textTheme.bodyMedium,
          ),
        );

  final BuildContext context;
}
