import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_feature/domain/provider/user_provider.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_feature/ui/widgets/user_membership_card/user_membership_card_barrel_file.dart';
import 'package:piix_mobile/navigation_feature/navigation_ui_barrel_file.dart';
import 'package:piix_mobile/widgets/membership_card/app_pannable_membership_card.dart';

class BlankMembershipHomeScreen extends ConsumerWidget {
  static const routeName = '/blank_membership_home_screen';
  const BlankMembershipHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userPodProvider);

    if (user == null) return const SizedBox();

    return AppMembershipNavigationHomeScreen(
      user: user,
      onWillPop: () async => true,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            height: context.height,
            width: context.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 68.h,
                ),
                Text(
                  'Lo sentimos, no hemos encontrado información '
                  'para esta membresía. Por favor comunícate con el '
                  'equipo de PIIX para mayor información.',
                  style: context.titleMedium?.copyWith(
                    color: PiixColors.infoDefault,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const AppPannableMembershipCard(
              color: PiixColors.secondaryLight,
              logoColor: PiixColors.contrast,
              child: BlankMembershipCardContent()),
        ],
      ),
    );
  }
}
