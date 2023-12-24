import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/auth_feature/auth_provider_barrel_file.dart';
import 'package:piix_mobile/auth_feature/auth_ui_screen_barrel_file.dart';
import 'package:piix_mobile/auth_feature/domain/model/user_app_model.dart';
import 'package:piix_mobile/auth_feature/domain/provider/auth_service_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/api/local/app_shared_preferences.dart';
import 'package:piix_mobile/navigation_feature/navigation_utils_barrel_file.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/membership_feature/ui/screens/membership_loading_screen.dart';
import 'package:piix_mobile/onboarding_feature/ui/onboarding_screen.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/app_loading_widget/app_loading_widget.dart';
import 'package:piix_mobile/utils/app_assets_barrel_file.dart';

///Screen widget that checks if the [user] memberships
///have been approved to either send him to the
///[WaitingMembershipReviewScreen],
///[WaitingMembershipReviewScreen],
///or to send him to the [MembershipLoadingScreen]
final class UserLoadingScreen extends AppLoadingWidget {
  static const routeName = '/user_loading_screen';
  UserLoadingScreen(this.context, {super.key})
      : super(
          imagePath: userLoadingAssetPath,
          message: context.localeMessage.loadingUserInformation,
        );

  final BuildContext context;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserLoadingScreenState();
}

class _UserLoadingScreenState extends AppLoadingWidgetState<UserLoadingScreen> {
  ///Navigates to the [OnboardingScreen]
  void _navigateToOnboardingScreen() {
    Future.microtask(
      () => NavigatorKeyState().fadeInRoute(
        page: const OnboardingScreen(),
        routeName: OnboardingScreen.routeName,
        context: context,
        replaceAll: true,
      ),
    );
  }

  void _navigateToPersonalInformationFormScreen() {
    Future.microtask(
      () => NavigatorKeyState().fadeInRoute(
        page: const PersonalInformationFormScreen(),
        routeName: PersonalInformationFormScreen.routeName,
        context: context,
        replaceAll: true,
      ),
    );
  }

  ///Case when a user's membership has not been aproved
  void _navigateToWaitingMembershipRevisionScreen() {
    Future.microtask(
      () => NavigatorKeyState().fadeInRoute(
        page: const WaitingMembershipReviewScreen(),
        routeName: WaitingMembershipReviewScreen.routeName,
        context: context,
        replaceAll: true,
      ),
    );
  }

  void _navigateToMembershipLoadingScreen() {
    //If the user has already seen the onboardin then
    //she navigates and loads the membership
    Future.microtask(
      () => NavigatorKeyState().fadeInRoute(
        page: MembershipLoadingScreen(context),
        routeName: MembershipLoadingScreen.routeName,
        context: context,
        replaceAll: true,
      ),
    );
  }

  ///Case when a user's membership
  void _onAprovedMembership() async {
    final hasSeenTutorial =
        await AppSharedPreferences.recoverHasSeenOnboarding() ?? false;
    if (!hasSeenTutorial) {
      //If has seen tutorial flag is false navigate to Onboarding Screen
      return _navigateToOnboardingScreen();
    }
    _navigateToMembershipLoadingScreen();
  }

  ///User is denied access to the app
  void _onError([Object? error]) => Future.microtask(() {
        //Deny any current auth service request
        ref.read(customTokenServiceProvider.notifier).deny(error);
      });

  @override
  Future<void> whileIsRequesting() async {
    return ref.watch(customTokenPodProvider).whenOrNull(
      data: (_) {
        //Set the state to avoid any memory leak
        endRequest();
        final user = ref.read(userPodProvider);
        //If there is no user after the request finishes, there
        //has been an error
        if (user == null) return _onError();
        if (!user.userAlreadyHasBasicMainInfoForm || user.idle)
          return _navigateToPersonalInformationFormScreen();
        if (!user.approved) {
          return _navigateToWaitingMembershipRevisionScreen();
        }
        return _onAprovedMembership();
      },
      error: (error, stackTrace) {
        //If an error occurs it stops any watch check
        endRequest();
        _onError(error);
      },
    );
  }
}
