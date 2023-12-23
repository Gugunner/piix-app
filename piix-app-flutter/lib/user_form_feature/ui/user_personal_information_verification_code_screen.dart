import 'package:flutter_riverpod/src/consumer.dart';
import 'package:piix_mobile/auth_feature/domain/provider/auth_service_provider_deprecated.dart';
import 'package:piix_mobile/auth_feature/domain/provider/user_provider.dart';
import 'package:piix_mobile/auth_feature/domain/provider/verification_code_provider_deprecated.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_events_constants.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_parameter_constants.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_values.dart';
import 'package:piix_mobile/membership_verification_feature/ui/membership_verification_screen_deprecated.dart';
import 'package:piix_mobile/user_form_feature/domain/user_form_provider_deprecated.dart';
import 'package:piix_mobile/utils/log_utils.dart';
import 'package:piix_mobile/widgets/screen/app_verification_code_screen/app_verification_code_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

//TODO: Analyze and decide if removed in 4.0
class UserPersonalInformationVerificationCodeScreen
    extends AppVerificationCodeScreen {
  static const routeName =
      '/user_personal_information_verification_code_screen';
  const UserPersonalInformationVerificationCodeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserPersonalInformationVerificationCodeScreenState();
}

class _UserPersonalInformationVerificationCodeScreenState
    extends AppVerificationCodeScreenState<
        UserPersonalInformationVerificationCodeScreen> with LogAnalytics {
  @override
  Future<bool> onWillPop() async {
    ///If the user pops the screen it means
    ///there was an error sending the form
    ref
        .read(userFormStateNotifierProvider.notifier)
        .setUserFormState(UserFormState.SENT_ERROR);
    return super.onWillPop();
  }

  @override
  void whileIsSubmitted() {
    void endSubmit() => Future.microtask(() => setState(() {
          isSubmitted = false;
        }));
    //To concatenate multiple providers each AsyncValue is stored
    final verifiedCode =
        ref.watch(verifyCodeServiceProvider(updateCredential: true));
    //If the response of the AsyncNotifier [verifyCodeServiceProvider]
    //throws an error the execution ends the loop and exits
    if (verifiedCode is AsyncError) {
      endSubmit();
      return;
    }
    //While it is loading it just exits the method
    //without ending the loop
    if (verifiedCode is AsyncLoading) return;

    ///Declares and launches second chained provider only if
    ///there is data on the AsyncNotifier [verifyCodeServiceProvider]
    final customToken = ref.watch(customTokenServiceProvider);
    //If the response of the AsyncNotifier [customTokenServiceProvider]
    //throws an error the execution ends the loop and exits the method
    if (customToken is AsyncError) {
      endSubmit();
      return;
    }
    //While it is loading it just exits the method
    //without ending the loop
    if (customToken is AsyncLoading) return;

    ///Finally calls the AsyncNotifier to request to send the user
    ///personal information form if there is data in
    ///AsyncNotifier [customTokenServiceProvider]
    return ref.watch(userFormServiceNotifierProvider(send: true)).whenOrNull(
        data: (_) {
      endSubmit();
      Future.microtask(() {
        ///Updates locally the information submitted in the form if it
        ///is succesfully sent
        ref.read(userPodProvider.notifier).setUpPersonalInformation();
        logEvent(
          eventName: PiixAnalyticsEvents.submitAuthForm,
          eventParameters: {
            PiixAnalyticsParameters.formName:
                PiixAnalyticsValues.personalInformationForm,
          },
        );
        NavigatorKeyState().fadeInRoute(
            page: const MembershipVerificationScreenDeprecated(),
            routeName: MembershipVerificationScreenDeprecated.routeName);
      });
    }, error: (_, __) {
      //If there is an error it returns to the form screen
      endSubmit();
      Future.microtask(() {
        ref
            .read(userFormStateNotifierProvider.notifier)
            .setUserFormState(UserFormState.SENT_ERROR);
        NavigatorKeyState().getNavigator()?.pop();
      });
    });
  }
}
