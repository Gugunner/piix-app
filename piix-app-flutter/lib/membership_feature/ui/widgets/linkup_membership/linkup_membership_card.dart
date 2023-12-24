import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/membership_feature/membership_ui_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/app_card/app_card.dart';
import 'package:piix_mobile/widgets/button/text_app_button/app_text_sized_button.dart';

final class LinkupMembershipCard extends StatelessWidget {
  const LinkupMembershipCard({
    super.key,
    this.canEditCode = false,
    this.onEditCode,
    this.onChanged,
    this.onSaved,
    this.apiError,
    this.focusNode,
  });

  final bool canEditCode;

  final VoidCallback? onEditCode;

  final ValueChanged<String>? onChanged;

  final Function(String?)? onSaved;

  final AppApiException? apiError;

  final FocusNode? focusNode;

  String _getHowToLinkupMyMembershipMessage(BuildContext context) =>
      context.localeMessage.howToLinkupMyMembership;

  void _launchHowToLinkupMyMembershipDialog(BuildContext context) async =>
      showDialog(
          context: context,
          builder: (buildContext) => const HowToLinkupMyMembershipDialog());

  @override
  Widget build(BuildContext context) {
    return AppCard(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: context.width,
          child: Text(
            context.localeMessage.linkupYourMembershipInstructions,
            style: context.titleMedium?.copyWith(color: PiixColors.infoDefault),
            textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: 12.h),
        AppTextSizedButton.title(
          text: _getHowToLinkupMyMembershipMessage(context),
          onPressed: () => _launchHowToLinkupMyMembershipDialog(context),
        ),
        SizedBox(height: 50.h),
        LinkupMembershipField(
          onChanged: onChanged,
          onSaved: onSaved,
          apiError: apiError,
          focusNode: focusNode,
          enabled: canEditCode,
          onEditCode: onEditCode,
        ),
      ],
    ));
  }
}
