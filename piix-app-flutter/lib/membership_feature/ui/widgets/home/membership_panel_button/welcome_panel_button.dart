import 'package:flutter/material.dart';
import 'package:piix_mobile/utils/theme/theme_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';

///A predefined Material Button that invites the user to explor
///the assistances included on its membership.
final class WelcomePanelButton extends AppPanelButton {
  WelcomePanelButton(this.context, {super.key, required super.onPressed})
      : super(
          title: Text(
            context.localeMessage.hiAgain,
          ),
          description: Text(
            context
                .localeMessage
                .exploreMyAssistances,
            style: BaseTextTheme().textTheme.bodyMedium,
          ),
        );

  final BuildContext context;
}
