import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_feature/domain/provider/auth_service_provider_deprecated.dart';
import 'package:piix_mobile/auth_feature/domain/provider/user_provider.dart';
import 'package:piix_mobile/auth_feature/ui/screens/sign_up_sign_in_verification_code_screen_deprecated.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_input_provider.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/ui/widgets/auth_input_builder.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/ui/widgets/sign_in_or_sign_up/auth_generic_error.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/ui/widgets/sign_in_or_sign_up/auth_method_confirmation.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/ui/widgets/sign_in_or_sign_up/auth_method_disclaimer.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/ui/widgets/sign_in_or_sign_up/auth_method_title.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/utils/auth_input_state_enum.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/utils/auth_user_copies.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/widgets/app_bar/logo_app_bar.dart';
import 'package:piix_mobile/widgets/button/elevated_app_button_deprecated/elevated_app_button_deprecated.dart';
import 'package:piix_mobile/widgets/button/text_app_button/text_app_button_deprecated.dart';
import 'package:piix_mobile/widgets/screen/app_screen/pop_app_screen.dart';

@Deprecated('Will be removed in 4.0')
///Can be used as the sign up or sign in screen by reading the [authMethod].
class SignInOrSignUpScreenDeprecated extends ConsumerStatefulWidget {
  static const routeName = '/sign-in-or-sign-up';
  const SignInOrSignUpScreenDeprecated({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SignInOrSignUpScreenState();
}

class _SignInOrSignUpScreenState
    extends ConsumerState<SignInOrSignUpScreenDeprecated> {
  final screenFormKey = GlobalKey<FormState>();
  bool isSubmitted = false;

  void _onSubmit() async {
    //If there is no key associated with the form
    //exit and do nothing
    if (screenFormKey.currentState == null) return;
    //Execute the key save method to execute the onSave method of each
    //TextFormField in the form.
    screenFormKey.currentState!.save();
    //Exit and do nothing if any TextFormField has errors or if the
    //AuthInputState is not idle as this means it has not been reset for a new
    //onSubmit call.
    if (!screenFormKey.currentState!.validate() ||
        ref.read(authInputProvider) != AuthInputState.idle) return;
    onUnfocus();
    setState(() {
      isSubmitted = true;
    });
  }

  //A disclaimer is shown when the user is signing up so the user knows that
  //acknowledges that the credential used must be owned or have the rights of
  //using them.
  bool get showDisclaimer =>
      ref.read(authMethodStateProvider).name.toLowerCase().contains('signup');

  ///When primary focus changes to another component, it unfocuses any
  ///component inside [this]
  void onUnfocus() {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    setState(() {});
  }

  void whileIsSubmitted() => ref.watch(signUpSignInServiceProvider).whenOrNull(
        data: (_) => Future.microtask(() {
          setState(() {
            isSubmitted = false;
          });
          NavigatorKeyState().getNavigator()?.pushNamed(
              SignUpSignInVerificationCodeScreenDeprecated.routeName);
        }), //Navigates to the verification code part
        error: (error, stackTrace) {
          setState(() {
            isSubmitted = false;
          });
        },
      );

  Future<bool> onWillPop() async {
    //Clear states
    ref.read(authMethodStateProvider.notifier).clearProvider();
    ref.read(userPodProvider.notifier).set(null);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final authMethod = ref.watch(authMethodStateProvider);
    final authInputState =
        ref.watch(authInputProvider.select((value) => value));
    if (isSubmitted) whileIsSubmitted();
    return PopAppScreen(
      shouldIgnore: isSubmitted,
      onWillPop: onWillPop,
      onUnfocus: onUnfocus,
      appBar: LogoAppBar(),
      body: SingleChildScrollView(
        child: Container(
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
                  child: AuthTitle(
                    title: authMethod.authSignInOrUpTitle,
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
                    message: authMethod.authSignInOrUpMessage,
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                  ),
                  child: const AuthInputBuilder(),
                ),
                if (authInputState != AuthInputState.error)
                  SizedBox(
                    height: 52.h,
                  ),
                //Shows a general error for the user to see
                if (authInputState == AuthInputState.error) ...[
                  Container(
                    margin: EdgeInsets.only(
                      top: 20.h,
                      bottom: 28.h,
                    ),
                    child: const AuthGenericErrorWidget(
                      text: AuthUserCopies.generalError,
                    ),
                  ),
                ],
                ElevatedAppButtonDeprecated(
                  onPressed: !isSubmitted ? _onSubmit : null,
                  text: AuthUserCopies.send,
                ),
                SizedBox(
                  height: 8.h,
                ),
                if (showDisclaimer)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                    ),
                    child: const AuthMethodDisclaimer(),
                  ),
                SizedBox(
                  height: 32.h,
                ),
                TextAppButtonDeprecated(
                  text: authMethod.authActionBy,
                  onPressed: ref
                      .read(authMethodStateProvider.notifier)
                      .switchEmailOrPhone,
                ),
                SizedBox(
                  height: 8.h,
                ),
                TextAppButtonDeprecated(
                  text: authMethod.authMode,
                  onPressed: ref
                      .read(authMethodStateProvider.notifier)
                      .switchSignInOrSignUp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
