import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/claim_sos_dialog_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_icons.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:provider/provider.dart';

/// Creates a custom Floating Action Button with a menu of options.
@Deprecated('No longer in use in 4.0')
class PiixFABDeprecated extends StatelessWidget {
  const PiixFABDeprecated({Key? key}) : super(key: key);

  Color get dialColor => PiixColors.tangerine;

  @override
  Widget build(BuildContext context) {
    final membershipInfoBLoC = context.watch<MembershipProviderDeprecated>();
    final whatsappNumber =
        membershipInfoBLoC.selectedMembership?.claimChatNumber;
    final callNumber = membershipInfoBLoC.selectedMembership?.claimPhoneNumber;

    if (whatsappNumber == null && callNumber == null) {
      return const SizedBox();
    }

    return SpeedDial(
        activeIcon: Icons.close,
        backgroundColor: dialColor,
        child: Text(
          PiixCopiesDeprecated.sos,
          style: context.accentTextTheme?.displayMedium?.copyWith(
            color: PiixColors.space,
          ),
        ),
        curve: Curves.bounceIn,
        elevation: 4.0,
        heroTag: 'speed-dial-hero-tag',
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        children: [
          if (whatsappNumber.isNotNullEmpty)
            SpeedDialChild(
              child: const Center(
                  child: Icon(PiixIcons.whatsapp, color: PiixColors.white)),
              backgroundColor: dialColor,
              labelWidget: Text(
                PiixCopiesDeprecated.whatsapp,
                style: context.primaryTextTheme?.titleSmall?.copyWith(
                  color: PiixColors.space,
                ),
              ),
              labelStyle: const TextStyle(fontSize: 18.0),
              onTap: () => handleDial(
                context: context,
                isPhoneClaim: false,
              ),
            ),
          if (callNumber.isNotNullEmpty)
            SpeedDialChild(
              child: const Center(
                  child: Icon(PiixIcons.phone, color: PiixColors.white)),
              backgroundColor: dialColor,
              labelWidget: Text(
                PiixCopiesDeprecated.call,
                style: context.primaryTextTheme?.titleSmall?.copyWith(
                  color: PiixColors.space,
                ),
              ),
              onTap: () => handleDial(
                context: context,
              ),
            ),
        ]);
  }

  void handleDial({required BuildContext context, bool isPhoneClaim = true}) =>
      showDialog<void>(
        context: context,
        builder: (_) {
          return ClaimSosDialogDeprecated(
            isPhoneClaim: isPhoneClaim,
          );
        },
      );
}
