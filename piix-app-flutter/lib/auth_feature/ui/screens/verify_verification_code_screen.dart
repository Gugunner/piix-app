import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_feature/auth_ui_barrel_file.dart';
import 'package:piix_mobile/auth_feature/auth_utils_barrel_file.dart';
import 'package:piix_mobile/auth_feature/domain/provider/verification_code_provider.dart';
import 'package:piix_mobile/auth_feature/ui/screens/user_loading_screen.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/app_loading_widget/app_loading_widget.dart';
import 'package:piix_mobile/widgets/banner/banner_barrel_file.dart';
import 'package:piix_mobile/widgets/stepper/app_stepper_barrel_file.dart';

///The screen used when a [phoneNumber] is being verified.
///
///This screen changes the [_totalSteps] and [_currentStep] shown
///in the [AppFilledStepperScrollView] depending on the [verificationType].
final class VerifyVerificationCodeScreen extends AppLoadingWidget {
  static const routeName = '/verify_verification_code_screen';

  const VerifyVerificationCodeScreen({
    super.key,
    required this.phoneNumber,
    this.verificationType = VerificationType.signIn,
  });

  ///The phone number where the verification code was sent and
  ///it is also used if a new verification code needs to be send.
  final String phoneNumber;

  ///Changes how many [_totalSteps] and the [_currentStep] of
  ///the [AppFilledStepperScrollView].
  final VerificationType verificationType;

  @override
  ConsumerState<VerifyVerificationCodeScreen> createState() =>
      _VerifyVerificationCodeScreenState();
}

class _VerifyVerificationCodeScreenState
    extends AppLoadingWidgetState<VerifyVerificationCodeScreen> {
  ///The code that is send when requesting to verify the verification code.
  String _code = '';

  ///The error which can occur if the service is not
  AppApiException? _apiException;

  bool _hasSubmitted = false;

  int get _currentStep {
    switch (widget.verificationType) {
      case VerificationType.signIn:
        return 2;
      case VerificationType.signUp:
        return 2;
      case VerificationType.update:
        return 2;
      case VerificationType.recover:
        return 4;
    }
  }

  @override
  void initState() {
    super.initState();
    isRequesting = false;
  }

  ///Shows a specific error when an error prevents from
  ///verifying the verification code.
  void _launchErrorBanner() {
    Future.microtask(() {
      ref.read(bannerPodProvider.notifier)
        ..setBanner(
          context,
          cause: BannerCause.error,
          description: context.localeMessage.unknownVerificationCodeError,
          action: () {
            if (mounted) {
              setState(() {
                //Clears any error once the user acknowledges the error.
                if (_apiException != null) _apiException = null;
              });
            }
          },
        )
        ..build();
    });
  }

  void _onSend(String value) {
    setState(() {
      _code = value;
      if (_apiException != null) _apiException = null;
      if (!_hasSubmitted) _hasSubmitted = true;
    });
    startRequest();
  }

  void _onCodeChanged() {
    setState(() {
      if (_apiException != null) _apiException = null;
    });
  }

  String? _validator(String? value) {
    final localeMessage = context.localeMessage;
    final apiException = _apiException;
    //If no api error is found then no error is shown.
    if (apiException == null) return null;
    if (apiException.errorCodes.isNullOrEmpty) return null;
    //Checks for specific error codes.
    if (apiException.errorCodes!.contains(apiWrongVerificationCode))
      return localeMessage.wrongVerificationCode;
    return null;
  }

  void _navigateToUserLoadingScreen() {
    Future.microtask(() => NavigatorKeyState().fadeInRoute(
          page:  UserLoadingScreen(context),
          routeName: UserLoadingScreen.routeName,
          //Replaces all screens in the stack
          replaceAll: true,
        ));
    endRequest();
  }

  @override
  Future<void> whileIsRequesting() async => ref
          .watch(verifyVerificationCodePodProvider(
        phoneNumber: widget.phoneNumber,
        verificationCode: _code,
        verificationType: widget.verificationType,
      ))
          .whenOrNull(data: (_) {
        _navigateToUserLoadingScreen();
      }, error: (error, stackTrace) {
        //The error banner launches always unless the error
        //is an AppApiException and the error code is handled by
        //the VerificationCodeForm.
        if (error is! AppApiException ||
            error.errorCodes.isNullOrEmpty ||
            !error.errorCodes!.contains(apiWrongVerificationCode)) {
          _launchErrorBanner();
        } else {
          Future.microtask(() => setState(() {
                _apiException = error;
              }));
        }
        endRequest();
      });

  @override
  Widget build(BuildContext context) {
    if (isRequesting) whileIsRequesting();
    return Scaffold(
      body: SafeArea(
        child: IgnorePointer(
          ignoring: isRequesting,
          child: AppFilledStepperScrollView(
            totalSteps: widget.verificationType.totalSteps,
            currentStep: _currentStep,
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  width: context.width,
                  padding:
                      EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      VerifyVerificationCodeForm(
                        phoneNumber: widget.phoneNumber,
                        onSend: _onSend,
                        onCodeChanged: _onCodeChanged,
                        validator: _hasSubmitted ? _validator : null,
                        loading: isRequesting,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
