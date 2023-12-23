import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/auth_feature/auth_ui_screen_barrel_file.dart';
import 'package:piix_mobile/auth_feature/ui/screens/user_loading_screen.dart';
import 'package:piix_mobile/general_app_feature/api/local/app_shared_preferences.dart';
import 'package:piix_mobile/welcome_screen.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/widgets/app_loading_widget/app_loading_widget.dart';

///Screen widget that checks if the [authUser] is already
///stored in the device to either auto sign in and navigate to
///[UserLoadingScreen] in or open [WelcomeScreen]
final class HomeLoadingScreen extends AppLoadingWidget {
  static const routeName = '/home_loading_screen';

  const HomeLoadingScreen({
    super.key,
  }) : super(
          //Name and message are not used so the default value will be an
          //empty String
          imagePath: '',
          message: '',
        );

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HomeLoadingScreenState();
}

class _HomeLoadingScreenState extends AppLoadingWidgetState<HomeLoadingScreen> {
  void _navigateToWelcomeScreen() {
    Future.microtask(
      () => NavigatorKeyState().fadeInRoute(
        context: context,
        page: const WelcomeScreen(),
        routeName: WelcomeScreen.routeName,
        replaceAll: true,
      ),
    );
    return endRequest();
  }

  void _navigateToUserLoadingScreen() {
    Future.microtask(
      () => NavigatorKeyState().fadeInRoute(
        context: context,
        page: UserLoadingScreen(context),
        routeName: UserLoadingScreen.routeName,
        replaceAll: true,
      ),
    );
    return endRequest();
  }

  ///Checks for the [authUser] stored in the device if either the [authUser]
  ///is null or there is no [userId] navigates to [SignInScreen] otherwise
  ///navigates to [UserLoadingScreen].
  @override
  Future<void> whileIsRequesting() async {
    final authUser = await AppSharedPreferences.recoverAuthUser()
        .onError((error, stackTrace) => null);
    if (authUser == null) {
      //TODO: Call clear all states and shared preferences

      AppSharedPreferences.clear();
      return _navigateToWelcomeScreen();
    }

    //If there is an [authUser] it navigates to [UserLoadingScreen]
    //to retrieve the current user from the server
    return _navigateToUserLoadingScreen();
  }

  //The base widget screen is override
  //to show a blank screen instead
  @override
  Widget build(BuildContext context) {
    if (isRequesting) whileIsRequesting();
    return Scaffold(
      body: Container(
        height: context.height,
        width: context.width,
        color: PiixColors.space,
      ),
    );
  }
}
