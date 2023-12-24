import 'package:flutter/material.dart';
import 'package:piix_mobile/widgets/banner/banner_barrel_file.dart';

class BannerBuilder extends StatelessWidget {
  const BannerBuilder({
    super.key,
    required this.description,
    this.cause = BannerCause.success,
    this.addIcon = true,
    this.title,
    this.action,
    this.actionText,
  });

  ///The message inside the banner.
  final String description;

  ///The cause that triggered a banner either.
  final BannerCause cause;

  ///Choos whether to show or not the banner cause icon.
  final bool addIcon;

  ///The header inside the banner.
  final String? title;

  ///The callback to execute if the button is pressed.
  final VoidCallback? action;

  ///The text shown in the button.
  final String? actionText;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = cause.backgroundColor;
    final icon = cause.icon;

    ///Uses null assert to check each nullable value if not null then it
    ///matches and checks for the constant value of addIcon.
    return switch ((title, action, actionText, addIcon)) {
      (final title?, final action?, final actionText?, true) => BannerTypeTwo(
          title: title,
          description: description,
          icon: icon,
          action: action,
          actionText: actionText,
          color: backgroundColor,
        ),
      (_, final action?, final actionText?, true) => BannerTypeOne(
          description: description,
          icon: icon,
          action: action,
          actionText: actionText,
          color: backgroundColor,
        ),
      (_, _, _, _) => BannerTypeThree(
          description: description,
          icon: addIcon ? icon : null,
          action: action,
          actionText: actionText,
          color: backgroundColor,
        )
    };
  }
}
