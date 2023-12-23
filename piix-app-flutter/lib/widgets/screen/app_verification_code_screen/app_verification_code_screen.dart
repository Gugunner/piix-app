import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_feature/domain/provider/verification_code_provider_deprecated.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_input_provider.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/utils/auth_user_copies.dart';
import 'package:piix_mobile/utils/providers/app_banner_provider.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/verification_code_feature/ui/widgets/verification_code/verification_codes_builder_deprecated.dart';
import 'package:piix_mobile/verification_code_feature/utils/verification_input_state.dart';
import 'package:piix_mobile/widgets/app_bar/logo_app_bar.dart';
import 'package:piix_mobile/widgets/banner/app_banner.dart';
import 'package:piix_mobile/widgets/button/elevated_app_button_deprecated/elevated_app_button_deprecated.dart';
import 'package:piix_mobile/widgets/button/text_app_button/text_app_button_deprecated.dart';
import 'package:piix_mobile/widgets/screen/app_screen/pop_app_screen.dart';

///The base class for the code verification screens.
///
///Use the class as a screen not as a widget inside a screen.
///This class is used with [AppVerificationCodeScreenState] classes
///to handle both the [context] and [ref].
abstract class AppVerificationCodeScreen extends ConsumerStatefulWidget {
  const AppVerificationCodeScreen({
    super.key,
  });
}

///The base class for a code verification screen stateful management.
///
///To use this class you must override [whileIsSubmitted] with an
///[AsyncValue] void or null method, preferably use [whenOrNull] and handle
///both the [data] and [error] cases.
///
abstract class AppVerificationCodeScreenState<
    T extends AppVerificationCodeScreen> extends ConsumerState<T> {
  ///The key used to identify and check the form where
  ///the code is input
  final formKey = GlobalKey<FormState>();

  ///An internal flag that triggers [whileIsSubmitted]
  ///asynchrnous call.
  bool isSubmitted = false;

  @override
  void initState() {
    Future.microtask(() => ref
        .read(verificationStatePodProvider.notifier)
        .setVerificationState(VerificationStateDeprecated.idle));
    super.initState();
  }

  ///Unfoucus the current element and refreshes the [Widget]
  void _onUnfocus() {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    setState(() {});
  }

  ///Checks if the form is mounted and has valid values
  ///in each input.
  bool get _invalidFormState =>
      formKey.currentState == null || !(formKey.currentState!.validate());

  ///Called any time the code is sent to unfocus any
  ///element check that the form can be sent and finally
  ///sets [isSubmmited] to true so at the next rebuild of the
  ///[Widget] it triggers [whileIsSubmitted]
  Future<void> _onVerifyCode() async {
    //Unfocus any input when submitting code
    _onUnfocus();
    //If there is no key that relates to the form or if any
    //value in the TextFormField are not valid, exit and
    //do nothing
    if (_invalidFormState) return;
    setState(() {
      isSubmitted = true;
    });
  }

  ///Use an AsyncValue call such as ref.watch with an
  ///[AsyncNotifier] remember to set [isSubmitted] to false
  ///when [data] or [error] callbacks finish.
  void whileIsSubmitted();

  ///Call all logic when popping the screen, by default
  ///it always removes any [banner] from context
  @mustCallSuper
  Future<bool> onWillPop() async {
    ///Removes any banner that may have been created when
    ///[onSendCode] is called in [_VerificationTimerBuilderState].
    ref.read(bannerPodProvider.notifier).removeBanner();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final authMethod = ref.watch(authMethodStateProvider);
    final credential = ref
        .watch(usernameCredentialProvider.notifier)
        .completeUsernameCredential;
    final disable = ref
        .read(verificationCodeProvider)
        .any((element) => element == null || element < 0);
    if (isSubmitted) whileIsSubmitted();
    return PopAppScreen(
      onWillPop: onWillPop,
      appBar: LogoAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 40.h,
          ),
          height: context.height * 0.8,
          child: _VerificationCodeForm(
            formKey,
            message: authMethod.verificationSentTo(credential),
            onVerifyCode: disable ? null : _onVerifyCode,
            isSubmitted: isSubmitted,
          ),
        ),
      ),
    );
  }
}

///The component where the codes live including the
///codes input title and generic error message
class _VerificationCodeForm extends ConsumerWidget {
  const _VerificationCodeForm(
    this.formKey, {
    required this.message,
    this.isSubmitted = false,
    this.onVerifyCode,
  });

  final String message;
  final GlobalKey<FormState> formKey;
  final bool isSubmitted;

  final VoidCallback? onVerifyCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verificationState = ref.watch(verificationStatePodProvider);
    final verificationCode = ref.watch(verificationCodeProvider);
    final validCode = verificationCode.every((element) => (element ?? -1) > -1);
    final disable = isSubmitted || !validCode;
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AuthUserCopies.enterSentCode,
            style: context.primaryTextTheme?.displayMedium?.copyWith(
              color: PiixColors.infoDefault,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            message,
            style: context.titleMedium?.copyWith(
              color: PiixColors.infoDefault,
            ),
            textAlign: TextAlign.justify,
          ),
          const _VerificationCodes(),
          if (verificationState.unexpectedError)
            Text(
              AuthUserCopies.generalError,
              style: context.titleSmall?.copyWith(
                color: PiixColors.error,
              ),
            ),
          const _VerificationTimer(),
          ElevatedAppButtonDeprecated(
            onPressed: !disable ? onVerifyCode : null,
            text: PiixCopiesDeprecated.continueText,
          ),
        ],
      ),
    );
  }
}

///The codes input that builds each code input and
///shows any wrong code message error
class _VerificationCodes extends ConsumerWidget {
  const _VerificationCodes();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verificationState = ref.watch(verificationStatePodProvider);
    final generalError = verificationState.generalError;

    return FocusScope(
      debugLabel: 'Focus Verification Code Input',
      child: Focus(
        child: Builder(builder: (context) {
          final focusNode = Focus.of(context);
          final hasFocus = focusNode.hasFocus;
          Color color;
          if (generalError)
            color = PiixColors.error;
          else if (hasFocus)
            color = PiixColors.active;
          else
            color = PiixColors.infoDefault;
          return GestureDetector(
            onTap: () {
              if (hasFocus) {
                focusNode.unfocus();
              } else {
                focusNode.requestFocus();
              }
            },
            child: SizedBox(
              width: context.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AuthUserCopies.codeInputLabel,
                    style: context.bodyMedium?.copyWith(
                      color: color,
                    ),
                  ),
                  SizedBox(
                    height: 8.w,
                  ),
                  SizedBox(
                    child: VerificationCodesBuilderDeprecated(
                      hasError: generalError,
                    ),
                  ),
                  if (verificationState.wrongCode)
                    Text(
                      AuthUserCopies.incorrectCode,
                      style: context.labelMedium?.copyWith(
                        color: PiixColors.error,
                      ),
                      textAlign: TextAlign.start,
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

///The component which handles both the timer between allowed
///resend code and [whileIsRetrying] asynchronous call.
class _VerificationTimer extends ConsumerStatefulWidget {
  const _VerificationTimer();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VerificationTimerBuilderState();
}

class _VerificationTimerBuilderState extends ConsumerState<_VerificationTimer> {
  ///The banner provider class to call all it's methods
  late BannerPod appBannerProviderNotifier;

  ///The timer which counts the time to send code again
  Timer? timer;

  ///The time for the [timer]
  late Duration sendCodeWaitDuration;

  ///A simple parser to add two decimals
  final strDigits = (int n) => n.toString().padLeft(2, '0');

  ///The flag that enables or disables [onSendCode]
  bool codeSent = true;

  ///A flag that triggers [whileIsRetrying]
  ///asynchrnous call.
  bool isRetrying = false;

  ///Initializes the [appBannerProviderNotifier] and the [timer]
  @override
  void initState() {
    appBannerProviderNotifier = ref.read(bannerPodProvider.notifier);
    startTimer();
    super.initState();
  }

  ///Starts the [timer]
  void startTimer() {
    sendCodeWaitDuration = const Duration(minutes: 2);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      countDown();
    });
  }

  ///Handles each second the new [tick] value of the [timer]
  void countDown() {
    //Each tick second reduction
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = sendCodeWaitDuration.inSeconds - reduceSecondsBy;
      sendCodeWaitDuration = Duration(seconds: seconds);
      if (seconds < 1) {
        timer?.cancel();
        codeSent = false;
        return;
      }
    });
  }

  ///Launches an error banner if the banner cannot be sent
  Future<void> onSendCodeError() async {
    final appBannerProviderNotifier = ref.read(bannerPodProvider.notifier);
    appBannerProviderNotifier.setBanner(
      context,
      description: AuthUserCopies.codeCouldNotBeSent,
      cause: BannerCause.error,
    );
    setState(() {
      isRetrying = false;
    });
  }

  ///Launches a successful banner if the code
  ///can be resend
  Future<void> onSendCodeSuccesful() async {
    final authMethod = ref.read(authMethodStateProvider);
    final verificationInputState = authMethod.isPhoneNumber
        ? VerificationInputState.resendByPhone
        : VerificationInputState.resendByEmail;
    appBannerProviderNotifier.setBanner(
      context,
      description: verificationInputState.bannerMessage,
      cause: BannerCause.success,
    );

    ///Resets the [timer]
    startTimer();
    setState(() {
      isRetrying = false;
    });
  }

  void onSendCode() async {
    retry();
  }

  void retry() {
    setState(() {
      codeSent = true;
      isRetrying = true;
    });
  }

  ///Makes sure to cancel the [timer]
  ///to avoid memory leak
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  ///An asynchronous call that handles when [data] (success) or [error] (fail)
  ///cases occur when sending the credentials again to get a new code.
  void whileIsRetrying() => ref.watch(sendCredentialServiceProvider).whenOrNull(
        data: (_) => Future.microtask(() => onSendCodeSuccesful()),
        error: (_, __) => Future.microtask(() => onSendCodeError()),
      );

  @override
  Widget build(BuildContext context) {
    final minutes = strDigits(sendCodeWaitDuration.inMinutes.remainder(60));
    final seconds = strDigits(sendCodeWaitDuration.inSeconds.remainder(60));
    if (isRetrying) whileIsRetrying();
    return Column(
      children: [
        SizedBox(
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: AuthUserCopies.timerTextSpans[0],
                ),
                TextSpan(
                  text: '$minutes:$seconds ',
                  style: context.textTheme?.labelMedium?.copyWith(
                    color: PiixColors.primary,
                  ),
                ),
                TextSpan(
                  text: AuthUserCopies.timerTextSpans[1],
                ),
              ],
              style: context.textTheme?.bodyMedium,
            ),
          ),
        ),
        TextAppButtonDeprecated(
          onPressed: !codeSent ? onSendCode : null,
          text: AuthUserCopies.requestNewCode,
        ),
      ],
    );
  }
}
