import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/theme/theme_barrel_file.dart';

///A defined [ListTile] used for the [AppDrawer] to populate its children 
///where the [leading] property is a [Text] and tapping on this will
///[navigateTo] the screen passed in the callback.
final class MembershipDrawerOption extends ListTile {
  MembershipDrawerOption(this.optionMessage, this.navigateTo, {super.key})
      : super(
          leading: Text(
            optionMessage,
            style: PrimaryTextTheme().headlineSmall?.copyWith(
                  color: PiixColors.space,
                ),
          ),
          onTap: navigateTo,
          
        );
  ///The value to show as a [Text] in the option.
  final String optionMessage;
  ///A callback execution that should include a [Navigation]
  ///to another screen.
  final VoidCallback navigateTo;
  
}
