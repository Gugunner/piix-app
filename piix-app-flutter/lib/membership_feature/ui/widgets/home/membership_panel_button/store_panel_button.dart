import 'package:flutter/material.dart';
import 'package:piix_mobile/utils/theme/theme_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';

///A predefined Material Button that invites the user to explore inside the
///Piix store.
final class StorePannelButton extends AppPanelButton {
  StorePannelButton(this.context, {super.key, required super.onPressed})
      : super(
          title: Text(
            context
                .localeMessage
                .meetTheStore,
          ),
          description: Text(
            context
                .localeMessage
                .complementYourCoverage,
            style: BaseTextTheme().textTheme.bodyMedium,
          ),
        );

  final BuildContext context;
}
