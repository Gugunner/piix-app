import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/data/repository/auth_service_repository.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_input_provider.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_service_provider_deprecated.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/utils/auth_user_copies.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/app_text_button_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_banner_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_banner_content_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/verification_code_feature/utils/verification_input_state.dart';
import 'package:provider/provider.dart';

@Deprecated('Use instead VerificationCodeTimer')
class VerificationTimerBuilderDeprecated extends ConsumerStatefulWidget {
  const VerificationTimerBuilderDeprecated({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VerificationTimerBuilderState();
}

class _VerificationTimerBuilderState
    extends ConsumerState<VerificationTimerBuilderDeprecated> {
  Timer? timer;
  late Duration sendCodeWaitDuration;
  PiixBannerContentDeprecated? banner;
  final strDigits = (int n) => n.toString().padLeft(2, '0');
  bool codeSent = true;

  void _startTimer() {
    sendCodeWaitDuration = const Duration(minutes: 2);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _countDown();
    });
  }

  void _countDown() {
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

  void _onSendCodeError() {
    banner = const PiixBannerContentDeprecated(
      title: AuthUserCopies.codeCouldNotBeSent,
      iconData: Icons.info,
      cardBackgroundColor: PiixColors.error,
    );
  }

  void _onSendCodeSuccesful() {
    final authMethod = ref.read(authMethodStateProvider);
    final verificationInputState = authMethod.isPhoneNumber
        ? VerificationInputState.resendByPhone
        : VerificationInputState.resendByEmail;

    banner = PiixBannerContentDeprecated(
      title: verificationInputState.bannerMessage,
    );
    _startTimer();
  }

  void _onSendCode() async {
    setState(() {
      codeSent = true;
    });
    final authMethod = ref.read(authMethodStateProvider);
    final credential = ref
        .read(usernameCredentialProvider.notifier)
        .completeUsernameCredential;
    final authServiceProvider = context.read<AuthServiceProvider>();
    final userCredentialStateProviderNotifier =
        ref.read(userCredentialStateProvider.notifier);
    if (kDebugMode) {
      authServiceProvider.setAppTest(false);
    }
    await userCredentialStateProviderNotifier.send(
      usernameCredential: credential,
      authMethod: authMethod,
    );
    final credentialState = userCredentialStateProviderNotifier.state;
    if (credentialState.hasError) {
      _onSendCodeError();
      setState(() {
        codeSent = false;
      });
    } else if (credentialState == CredentialState.sent) {
      _onSendCodeSuccesful();
    }
    if (banner != null) {
      PiixBannerDeprecated.instance.builder(
        context,
        children: banner!.build(context),
        seconds: 5,
      );
    }
  }

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = strDigits(sendCodeWaitDuration.inMinutes.remainder(60));
    final seconds = strDigits(sendCodeWaitDuration.inSeconds.remainder(60));
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
        AppTextButtonDeprecated(
          onPressed: !codeSent ? _onSendCode : null,
          text: AuthUserCopies.requestNewCode,
        ),
      ],
    );
  }
}
