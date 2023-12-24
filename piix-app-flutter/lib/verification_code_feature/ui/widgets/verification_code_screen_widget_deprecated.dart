import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_feature/domain/provider/verification_code_provider_deprecated.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/data/repository/auth_service_repository.dart';
import 'package:piix_mobile/auth_feature/domain/model/user_app_model.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_input_provider.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_service_provider_deprecated.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/ui/widgets/sign_in_or_sign_up/auth_generic_error.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/ui/widgets/sign_in_or_sign_up/auth_method_confirmation.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/ui/widgets/sign_in_or_sign_up/auth_method_title.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/ui/widgets/submit_button_builder_deprecated.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/utils/auth_user_copies.dart';
import 'package:piix_mobile/general_app_feature/api/local/app_shared_preferences.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_events_constants.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_parameter_constants.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/state_machine.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/memberships_screen_deprecated.dart';
import 'package:piix_mobile/membership_verification_feature/ui/membership_verification_screen_deprecated.dart';
import 'package:piix_mobile/onboarding_feature/ui/onboarding_screen.dart';
import 'package:piix_mobile/verification_code_feature/ui/widgets/verification_code/verification_code_input_deprecated.dart';
import 'package:piix_mobile/verification_code_feature/ui/widgets/verification_code/verification_timer_builder_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Use instead VerifyVerificationCodeScreen')
class VerificationCodeScreenWidgetDeprecated extends ConsumerStatefulWidget {
  const VerificationCodeScreenWidgetDeprecated({
    super.key,
    required this.onUnfocus,
  });
  final VoidCallback onUnfocus;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VerificationCodeScreenWidgetState();
}

class _VerificationCodeScreenWidgetState
    extends ConsumerState<VerificationCodeScreenWidgetDeprecated> {
  final screenFormKey = GlobalKey<FormState>();
  // late AuthInputCredentialUiProvider authInputCredentialProvider;
  late AuthServiceProvider authServiceProvider;
  late VerificationCode verificationCodeProviderNotifier;

  bool get disableCodeState =>
      authServiceProvider.verificationCodeState ==
          VerificationCodeState.verifying ||
      authServiceProvider.verificationCodeState ==
          VerificationCodeState.verified;

  bool get disableSubmitButton {
    final verificationCode = verificationCodeProviderNotifier.verificationCode;
    return verificationCode.isEmpty ||
        verificationCode.contains(-1) ||
        disableCodeState;
  }

  void _onVerifyCode() async {
    //Unfocus any input when submitting code
    widget.onUnfocus();
    //If there is no key that relates to the form or if any
    //value in the TextFormField are not valid, exit and
    //do nothing
    if (screenFormKey.currentState == null ||
        !(screenFormKey.currentState!.validate())) {
      return;
    }
    //Get a unix time that is used for a hashing key by the server
    //to help with automatic sign in. Only used if the user is signing
    //in or signing up
    final hashableUnixTime = DateTime.now().millisecondsSinceEpoch;
    //The verification mode state is used for determining if the
    //user is updating or not the credentials and to handle what
    //should happen after a successful verification of code
    final verificationModeState = ref.read(verificationModeProvider);
    //Get the possible auth user already stored
    final authUser = await AppSharedPreferences.recoverAuthUser();
    //Determine if the credential is being updated or not
    final updateCredential =
        verificationModeState == VerificationModeStateDeprecated.completing ||
            verificationModeState == VerificationModeStateDeprecated.updating;
    final credential = ref
        .read(usernameCredentialProvider.notifier)
        .completeUsernameCredential;
    final authMethod = ref.read(authMethodStateProvider);
    await authServiceProvider.sendVerificationCode(
      credential: credential,
      authMethod: authMethod,
      verificationCode: verificationCodeProviderNotifier.toString(),
      //If there is already a unix time stored used the stored one
      hashableUnixTime: authUser?.hashableUnixTime ?? hashableUnixTime,
      //User id is only used when updating credential and only happens
      //if the user has already signed in or signed up
      userId: authUser?.userId ?? '',
      //Pass if the method should execute and update or not
      updateCredential: updateCredential,
    );
    //Read the user which is updated after a successful verification code or
    final user = authServiceProvider.user;
    //If an error occurs with the verification or if no user is stored exit
    //In a sign up or sign in an error will always result in a null user,
    //otherwise the user will never be null
    if (authServiceProvider.verificationCodeState ==
            VerificationCodeState.conflict ||
        authServiceProvider.verificationCodeState ==
            VerificationCodeState.error) {
      return;
    }
    final analyticsInstance = PiixAnalytics.instance;
    //When the user is submitting a personal information form
    //the verification mode is completing and should return a
    //General StateMachine with value zero
    if (verificationModeState == VerificationModeStateDeprecated.completing) {
      analyticsInstance.logEvent(
        eventName: PiixAnalyticsEvents.verifyPersonalInformation,
        eventParameters: {
          PiixAnalyticsParameters.verificationMethod: authMethod.name,
        },
      );
      NavigatorKeyState().getNavigator()?.pop(StateMachine.one);
      return;
    }
    //When the user is updating credential from the profile,
    //the verification mode is profiling and should return a
    //General StateMachine with value two
    if (verificationModeState == VerificationModeStateDeprecated.updating) {
      analyticsInstance.logEvent(
        eventName: PiixAnalyticsEvents.updateCredential,
        eventParameters: {
          PiixAnalyticsParameters.verificationMethod: authMethod.name,
        },
      );
      NavigatorKeyState().getNavigator()?.pop(StateMachine.two);
      return;
    }
    //When the user is registering a protected
    //the verification mode is protectedAuthenticating and should return a
    //General StateMachine with value three
    if (verificationModeState == VerificationModeStateDeprecated.adding) {
      analyticsInstance.logEvent(
        eventName: PiixAnalyticsEvents.protectedSignUp,
        eventParameters: {
          PiixAnalyticsParameters.verificationMethod: authMethod.name,
        },
      );
      NavigatorKeyState().getNavigator()?.pop(StateMachine.three);
      return;
    }
    //If the user is signing in then it checks whether is an authorized user
    //or not, which means the verification of the user information has been
    //approved and has memberships
    if (authMethod.isSignIn) {
      //If the user is null the method exits
      //this can only happen if the code is changed and
      //creates this scenario
      if (user == null) return;
      //When the user is not authorized it should navigate to the
      //the builder that builds auth user forms or the waiting verification
      analyticsInstance.logEvent(
        eventName: PiixAnalyticsEvents.signIn,
        eventParameters: {
          PiixAnalyticsParameters.verificationMethod: authMethod.name,
        },
      );
      if (!user.approved) {
        NavigatorKeyState().getNavigator()?.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) {
              return const MembershipVerificationScreenDeprecated();
            },
          ),
          ModalRoute.withName(MembershipVerificationScreenDeprecated.routeName),
        );
        return;
      }
      final hasSeenTutorial =
          await AppSharedPreferences.recoverHasSeenOnboarding() ?? false;
      if (!hasSeenTutorial) {
        //If has seen tutorial flag is false navigate to Onboarding Screen
        NavigatorKeyState().getNavigator()?.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const OnboardingScreen(),
              ),
              ModalRoute.withName(OnboardingScreen.routeName),
            );
        return;
      }
      //If the user is authorized then it navigates to the memberships
      NavigatorKeyState().getNavigator()?.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const MembershipsScreenDeprecated(),
            ),
            ModalRoute.withName(MembershipsScreenDeprecated.routeName),
          );
      return;
    }
    analyticsInstance.logEvent(
      eventName: PiixAnalyticsEvents.signUp,
      eventParameters: {
        PiixAnalyticsParameters.verificationMethod: authMethod.name,
      },
    );
    //If the user is signing up, the builder which builds this widget
    //handles the case and shows a successful screen for signing up.
  }

  @override
  Widget build(BuildContext context) {
    authServiceProvider = context.watch<AuthServiceProvider>();
    verificationCodeProviderNotifier =
        ref.watch(verificationCodeProvider.notifier);
    final authMethod = ref.watch(authMethodStateProvider);
    final usernameCredentialProviderNotifier =
        ref.watch(usernameCredentialProvider.notifier);
    final credential =
        usernameCredentialProviderNotifier.completeUsernameCredential;
    return IgnorePointer(
      ignoring: disableCodeState,
      child: Container(
        //Do not add a constrained height,
        //let the scroll view handle it while building
        width: context.width,
        height: context.height,
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 40.h,
        ),
        child: Form(
          key: screenFormKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 4.w,
                ),
                child: const AuthTitle(
                  title: AuthUserCopies.enterSentCode,
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                ),
                child: AuthMessage(
                  message: authMethod.verificationSentTo(credential),
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                ),
                child: const VerificationCodeInputDeprecated(),
              ),
              SizedBox(
                height: 24.h,
              ),
              if (authServiceProvider.verificationCodeState ==
                  VerificationCodeState.error)
                Container(
                  margin: EdgeInsets.only(
                    bottom: 24.h,
                  ),
                  child: const AuthGenericErrorWidget(
                    text: AuthUserCopies.generalError,
                  ),
                ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                ),
                child: const VerificationTimerBuilderDeprecated(),
              ),
              SizedBox(
                height: 40.h,
              ),
              SubmitButtonBuilderDeprecated(
                //While sending the information, the button is disabled
                onPressed: !disableSubmitButton ? _onVerifyCode : null,
                text: PiixCopiesDeprecated.continueText.toUpperCase(),
                isLoading: disableCodeState,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
