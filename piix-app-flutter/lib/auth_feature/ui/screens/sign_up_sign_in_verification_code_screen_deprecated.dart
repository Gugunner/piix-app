import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/auth_feature/auth_provider_barrel_file.dart';
import 'package:piix_mobile/auth_feature/domain/provider/verification_code_provider_deprecated.dart';
import 'package:piix_mobile/auth_feature/ui/screens/user_loading_screen.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_input_provider.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_events_constants.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_parameter_constants.dart';
import 'package:piix_mobile/utils/log_utils.dart';
import 'package:piix_mobile/widgets/screen/app_verification_code_screen/app_verification_code_screen.dart';
import 'package:piix_mobile/verification_code_feature/ui/widgets/success_sign_up_verification_screen_deprecated.dart';

@Deprecated('Use instead SignInScreen or SignUpScreen')

///The screen for the verification process when the user is either signing up
///or signing in.
class SignUpSignInVerificationCodeScreenDeprecated
    extends AppVerificationCodeScreen {
  static const routeName = '/sign_up_sign_in_verification_code_screen';

  const SignUpSignInVerificationCodeScreenDeprecated({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SignUpSignInVerificationCodeScreenState();
}

class _SignUpSignInVerificationCodeScreenState
    extends AppVerificationCodeScreenState<
        SignUpSignInVerificationCodeScreenDeprecated> with LogAnalytics {
  ///Logs the method used for the sign in and navigates to the
  ///[UserLoadingScreen] to authenticate the user
  void onSignIn() {
    final authMethod = ref.read(authMethodStateProvider);
    logEvent(
      eventName: PiixAnalyticsEvents.signIn,
      eventParameters: {
        PiixAnalyticsParameters.verificationMethod: authMethod.name,
      },
    );
    Future.microtask(() => NavigatorKeyState().fadeInRoute(
          page: UserLoadingScreen(context),
          routeName: UserLoadingScreen.routeName,
          transitionDuration: const Duration(milliseconds: 600),
        ));
  }

  ///Logs the method used for the sign up and navigates to the
  ///[SuccessSignUpVerificationScreenDeprecated] to inform the user
  void onSignUp() {
    final authMethod = ref.read(authMethodStateProvider);
    logEvent(
      eventName: PiixAnalyticsEvents.signUp,
      eventParameters: {
        PiixAnalyticsParameters.verificationMethod: authMethod.name,
      },
    );
    Future.microtask(
        () => NavigatorKeyState().getNavigator()?.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) {
                  return const SuccessSignUpVerificationScreenDeprecated();
                },
              ),
              ModalRoute.withName(
                  SuccessSignUpVerificationScreenDeprecated.routeName),
            ));
  }

  @override
  void whileIsSubmitted() => ref.watch(verifyCodeServiceProvider()).whenOrNull(
        data: (_) {
          final user = ref.read(userPodProvider);
          final authMethod = ref.read(authMethodStateProvider);
          //While the user is not set it will not stop running the watch request
          if (user == null) return;
          //Set the state to avoid any memory leak
          setState(() {
            isSubmitted = false;
          });
          //Checks the correct flow to sign the user through
          if (authMethod.isSignIn) {
            return onSignIn();
          }
          return onSignUp();
        },
        error: (_, __) => setState(() {
          //Set the state to avoid any more calls
          //if an error when verifying code happens
          isSubmitted = false;
        }),
      );
}
