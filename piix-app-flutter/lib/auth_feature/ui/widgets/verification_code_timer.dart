import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_feature/domain/provider/sign_in_provider.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_icons.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/app_loading_widget/app_loading_widget.dart';
import 'package:piix_mobile/widgets/banner/banner_barrel_file.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';

///The different channels that can be used to send a verification code.
enum _VerificationRetryChannel {
  sms,
  whatsApp,
}

///A special [Widget] that contains an internal timer defaulting to 2 minutes
///that can be reset by sending a new verification code each time it resets
///the counter is back at 2 minutes. To be able to send a new verification code
///the [phoneNumber] is required to request sending the new verification code.
final class VerificationCodeTimerRetry extends AppLoadingWidget {
  const VerificationCodeTimerRetry({
    super.key,
    required this.phoneNumber,
  });

  final String phoneNumber;

  @override
  ConsumerState<VerificationCodeTimerRetry> createState() =>
      _VerificationCodeTimerRetryState();
}

///The implementation of the [timer] which controls different aspect of the
///possible actions that can be done when sending again the verification code.
///
///By default [_canResendCode] is set to false and once the timer finishes
///counting the 2 minutes it stops and the [_canResendCode] is set to true
///so a new verification code can be send again. Each time the code is sent
///a [_retryCount] decreases starting at 2 once it reaches zero the app allows
///the verification code to be sent via WhatsApp by enabling the button.
class _VerificationCodeTimerRetryState
    extends AppLoadingWidgetState<VerificationCodeTimerRetry> {
  ///The timer that sets each time a code is sent including the first time the
  ///app loads and each time a new code is sent.
  Timer? _timer;

  ///A new code cannot be send again until the timer reaches 0
  ///and once it reaches zero it automatically sets to true
  ///and if the [_sendVerificationCode] is executed the value
  ///returns to false.
  bool _canResendCode = false;

  ///Starts at 2 and each time [_sendVerificationCode] executes it decreases by
  ///one and once it reaches 0 the [_retryChannel] can be set to whatsApp.
  int _retryCount = 2;

  ///Depending on whether [_sendVerificationCodeViaSMS] or
  ///[_sendVerificationCodeViaWhatsapp] is executed the value changes.
  ///
  ///Note that the value whatsApp is not available until [_retryCount] reaches
  ///0.
  _VerificationRetryChannel _retryChannel = _VerificationRetryChannel.sms;

  ///A mutable value that is set each time the timer goes down
  ///by [_oneSecondWait].
  late Duration _remainingDuration;

  ///A constant value that has a duration of one second.
  Duration get _oneSecondWait => const Duration(seconds: 1);

  ///Parses the value in [_remainingDuration] by obtaining the minutes
  ///and seconds returning a 'mm:ss' format.
  String get _timeText {
    final minutes =
        _remainingDuration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds =
        _remainingDuration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds ';
  }

  @override
  void initState() {
    _startTime();
    isRequesting = false;
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  ///Each time is called the [_remainingDuration] resets to
  ///2 minutes and restarts the [_timer] and each [_oneSecondWait]
  ///it executes [_countDown].
  void _startTime() {
    _remainingDuration = const Duration(minutes: 2);
    _timer = Timer.periodic(_oneSecondWait, (timer) => _countDown());
  }

  ///Sets a new value in [_remainingDuration] by reducing by one
  ///the second each [_oneSecondWait].
  ///
  ///When the [_remainingDuration] reaches 0 it cancels the [_timer]
  ///and sets [_canResendCode] to true while reducing [_retryCount]
  ///if it hasn't reached 0.
  void _countDown() {
    const reduceBy = 1;
    final remainingSeconds = _remainingDuration.inSeconds - reduceBy;
    setState(() {
      //Makes sure that it never goes below 0
      if (remainingSeconds >= 0) {
        _remainingDuration = Duration(seconds: remainingSeconds);
      }
      if (remainingSeconds == 0) {
        _timer?.cancel();
        _canResendCode = true;
        if (_retryCount > 0) {
          _retryCount--;
        }
      }
    });
  }

  ///Blocks tha app from being able to send a verification code
  ///again. It also executes [_startTime].
  void _sendVerificationCode() {
    setState(() {
      _canResendCode = false;
    });
    _startTime();
    startRequest();
  }

  ///Sets the [_retryChannel] to sms value and executes
  ///[_sendVerificationCode].
  void _sendVerificationCodeViaSMS() {
    setState(() {
      _retryChannel = _VerificationRetryChannel.sms;
    });
    _sendVerificationCode();
  }

  ///Sets the [_retryChannel] to whatsApp value and executes
  ///[_sendVerificationCode].
  void _sendVerificationCodeViaWhatsapp() {
    //TODO: Implement api call to Whatsapp
    //TODO If successful call _sendVerificationCode
    setState(() {
      _retryChannel = _VerificationRetryChannel.whatsApp;
    });
    _sendVerificationCode();
  }

  ///Shows a specific error when an error prevents sending a new
  ///verification code.
  void _launchErrorBanner() {
    Future.microtask(() {
      ref.read(bannerPodProvider.notifier)
        ..setBanner(
          context,
          cause: BannerCause.error,
          description: context.localeMessage.sendCodeError,
          action: () {
            if (mounted) {
              //Since it failed the app is allowed to request a new code
              //right away.
              setState(() {
                _canResendCode = true;
                //cancels current timer
                _remainingDuration = const Duration(seconds: 0);
              });
            }
          },
        )
        ..build();
    });
  }

  ///Shows a banner message when the code is sent either via SMS
  ///or via WhatsApp.
  void _launchSuccessBanner() {
    final description = _retryChannel == _VerificationRetryChannel.sms
        ? context.localeMessage.codeWasSuccessfullySentAgain
        : context.localeMessage.whatsAppCodeWasSuccessfullySent;
    Future.microtask(() {
      ref.read(bannerPodProvider.notifier)
        ..setBanner(
          context,
          cause: BannerCause.success,
          description: description,
          action: () {},
        )
        ..build();
    });
  }

  ///Executes the request to send a new verification code
  ///via sms [_retryChannel].
  Future<AsyncValue> _whileIsRequestingViaSMS() async {
    final requestViaSMSAsyncValue =
        ref.watch(signInPodProvider(widget.phoneNumber)).when(data: (_) {
      return const AsyncValue.data(null);
    }, error: (error, stackTrace) {
      return AsyncValue.error(error, stackTrace);
    }, loading: () {
      return const AsyncValue.loading();
    });
    return requestViaSMSAsyncValue;
  }

  ///Executes the request to send a new verification code
  ///via whatsApp [_retryChannel].
  Future<AsyncValue> _whileIsRequestingViaWhatsApp() async {
    //TODO: Implement sendVerificationCodeViaWhatsapp
    final requestViaWhatsappAsyncValue =
        ref.watch(signInPodProvider(widget.phoneNumber)).when(data: (_) {
      return const AsyncValue.data(null);
    }, error: (error, stackTrace) {
      return AsyncValue.error(error, stackTrace);
    }, loading: () {
      return const AsyncValue.loading();
    });
    return requestViaWhatsappAsyncValue;
  }

  @override
  Future<void> whileIsRequesting() async {
    AsyncValue asyncValue;
    if (_retryChannel == _VerificationRetryChannel.whatsApp) {
      asyncValue = await _whileIsRequestingViaWhatsApp();
    } else {
      asyncValue = await _whileIsRequestingViaSMS();
    }

    if (asyncValue is AsyncLoading) {
      return;
    }

    if (asyncValue is AsyncData) {
      //Each time the code is succcessfuly sent a banner is shown.
      _launchSuccessBanner();
    }

    if (asyncValue is AsyncError) {
      //Each time the code cannot be sent a banner is shown.
      _launchErrorBanner();
    }

    return endRequest();
  }

  @override
  Widget build(BuildContext context) {
    if (isRequesting) whileIsRequesting();
    final inXTimeTextList =
        context.localeMessage.inXTimeYouCan(_timeText).split(' ');
    final startText = inXTimeTextList.first;
    final xTime = inXTimeTextList[1];
    final endText = inXTimeTextList.sublist(2).join(' ');
    return Column(
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text.rich(
              TextSpan(
                text: '$startText ',
                children: [
                  TextSpan(
                    text: '$xTime ',
                    style: context.labelMedium
                        ?.copyWith(color: PiixColors.primary),
                  ),
                  TextSpan(
                    text: '$endText ',
                  )
                ],
              ),
              style:
                  context.bodyMedium?.copyWith(color: PiixColors.infoDefault),
            ),
            AppTextSizedButton.headline(
              text: context.localeMessage.requestAnotherCode,
              onPressed: _canResendCode ? _sendVerificationCodeViaSMS : null,
            ),
          ],
        ),
        SizedBox(height: 32.h),
        if (_retryCount == 0)
          SizedBox(
            width: 188.w,
            child: AppTextSizedButton.headline(
              text: context.localeMessage.sendByWhatsApp,
              onPressed: _sendVerificationCodeViaWhatsapp,
              iconData: PiixIcons.whatsapp,
              keepSelected: true,
            ),
          )
      ],
    );
  }
}
