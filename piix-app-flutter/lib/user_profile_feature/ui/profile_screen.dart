import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/route_utils.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/piix_app_bar_deprecated.dart';
import 'package:piix_mobile/ui/common/clamping_scale_deprecated.dart';
import 'package:piix_mobile/ui/common/logout_button_deprecated.dart';
import 'package:piix_mobile/user_profile_feature/ui/widgets/invoice_information.dart';
import 'package:piix_mobile/user_profile_feature/ui/widgets/general_information.dart';
import 'package:piix_mobile/user_profile_feature/ui/widgets/membership_information.dart';
import 'package:piix_mobile/user_profile_feature/ui/widgets/owner_information.dart';
import 'package:piix_mobile/user_profile_feature/ui/widgets/profile_card.dart';
import 'package:piix_mobile/user_profile_feature/ui/widgets/subtitle_card.dart';
import 'package:piix_mobile/user_profile_feature/ui/widgets/claims_information.dart';
import 'package:provider/provider.dart';

//TODO: Remake the Screen
/// This is a profile screen, here shows all information for the user, such as
/// owner info, general info, membership info and payment info.
class ProfileScreen extends ConsumerWidget {
  static const routeName = '/profile';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membershipBLoC = context.watch<MembershipProviderDeprecated>();
    return WillPopScope(
      onWillPop: () async => goToMemberships(context, ref),
      child: ClampingScaleDeprecated(
        child: Scaffold(
          appBar: PiixAppBarDeprecated(
            title: PiixCopiesDeprecated.profileText,
            isTabScreen: true,
            onPressed: () => goToMemberships(context, ref),
          ),
          backgroundColor: PiixColors.paleGrey,
          body: Stack(
            children: [
              ListView(
                children: [
                  const ProfileCard(),
                  const SubtitleCard(
                    subtitle: PiixCopiesDeprecated.ownerInformation,
                  ),
                  const OwnerInformation(),
                  const SubtitleCard(
                      subtitle: PiixCopiesDeprecated.generalInformation),
                  const GeneralInformation(),
                  const SubtitleCard(
                    subtitle: PiixCopiesDeprecated.claimsLabel,
                  ),
                  const ClaimsInformation(),
                  if (membershipBLoC.isMainUserOfSelectedMembership &&
                      membershipBLoC.activateStore) ...[
                    const SubtitleCard(
                        subtitle: PiixCopiesDeprecated.shoppingInStore),
                    const InvoiceInformation()
                  ],
                  const SubtitleCard(
                    subtitle: PiixCopiesDeprecated.membershipInfo,
                  ),
                  const MembershipInformation(),
                  const LogoutButtonOld(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
