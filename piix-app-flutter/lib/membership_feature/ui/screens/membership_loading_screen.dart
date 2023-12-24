import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/auth_feature/ui/assets/auth_feature_assets.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/membership_feature/domain/provider/membership_provider.dart';
import 'package:piix_mobile/membership_feature/membership_model_barrel_file.dart';
import 'package:piix_mobile/membership_feature/membership_screen_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/app_loading_widget/app_loading_widget.dart';

///Screen widget that checks the [memberships]
///and shows the membership.
final class MembershipLoadingScreen extends AppLoadingWidget {
  static const routeName = '/membership_loading_screen';

  MembershipLoadingScreen(
    this.context, {
    super.key,
  }) : super(
          imagePath: membershipLoadingAssetPath,
          message: context.localeMessage.loadingMembershipInformation,
        );

  final BuildContext context;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MembershipLoadingScreenState();
}

class _MembershipLoadingScreenState
    extends AppLoadingWidgetState<MembershipLoadingScreen> {
  //TODO: Adapt the method once the updated getUserMembership service is deployed
  ///Common case where a user has a single [membership]
  ///
  ///The membership is set in the [membershipNotifierProvider]
  ///and then it navigates to the screen where the image of the
  ///membership card is loaded
  void _navigateToMembershipScreen(MembershipModel membership) {
    Future.microtask(() {
      ref
          .read(membershipNotifierPodProvider.notifier)
          .setMembership(membership);
      NavigatorKeyState().fadeInRoute(
        page: const MembershipHomeScreen(),
        routeName: MembershipHomeScreen.routeName,
        context: context,
        replaceAll: true,
      );
    });
    endRequest();

    return;
  }

  ///Navigates to the Blank Membership Screen
  void _navigateToBlankMembershipHomeScreen() {
    Future.microtask(
      () => NavigatorKeyState().fadeInRoute(
        page: const BlankMembershipHomeScreen(),
        routeName: BlankMembershipHomeScreen.routeName,
        context: context,
        replaceAll: true,
      ),
    );
    endRequest();
    return;
  }

  @override
  Future<void> whileIsRequesting() async => ref
      .watch(userMembershipPodProvider)
      .whenOrNull(
        data: (_) async {
          final membership = ref.read(membershipPodProvider);
          if (membership == null) return _navigateToBlankMembershipHomeScreen();
          return _navigateToMembershipScreen(membership);
        },
        error: (error, stackTrace) => _navigateToBlankMembershipHomeScreen(),
      );
}
