import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_feature/auth_ui_barrel_file.dart';
import 'package:piix_mobile/auth_feature/auth_ui_screen_barrel_file.dart';
import 'package:piix_mobile/auth_feature/auth_utils_barrel_file.dart';
import 'package:piix_mobile/navigation_feature/navigation_utils_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/welcome_screen.dart';
import 'package:piix_mobile/widgets/app_loading_widget/app_loading_widget.dart';
import 'package:piix_mobile/widgets/banner/banner_barrel_file.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';
import 'package:piix_mobile/widgets/stepper/app_stepper_barrel_file.dart';

///A common class containing [SendVerificationCodeForm] and is controlled
///by its [verificationType].
///
///It always stores the [phoneNumber] to be sent via the [whileIsRequesting]
///method execution and if any [apiException] is detected when [isRequesting]
///is true it is passed over to the [SendVerificationCodeForm]. Each time the
///[Form] executes [_onSend] or [onChanged] it will [_resetException].
abstract class UserPhoneAuthentication extends AppLoadingWidgetState {
  ///The state where the phone number is stored.
  String phoneNumber = '';

  ///If an error happens after executign [whileIsRequesting] it will be
  ///handled by this state.
  ///
  ///Each time [_onSend] or [_onChanged] is executed it will
  ///[_resetException].
  AppApiException? apiException;

  ///Changes the information inside to indicate the app what type
  ///of verification is starting.
  VerificationType get verificationType;

  int get currentStep;

  @override
  void initState() {
    super.initState();
    //To avoid any loading of a request before the user submits
    //initialize the value with false.
    isRequesting = false;
  }

  void launchErrorBanner() {
    Future.microtask(() {
      ref.read(bannerPodProvider.notifier)
        ..setBanner(context,
            cause: BannerCause.error,
            description: context.localeMessage.sendCodeError,
            action: () {})
        ..build();
      endRequest();
    });
  }

  void navigateToVerifyVerificationCodeScreen(
      VerificationType verificationType) {
    Future.microtask(
      () => Navigator.of(context).pushNamed(
        VerifyVerificationCodeScreen.routeName,
        arguments: (
          phoneNumber,
          verificationType,
        ),
      ),
    );
    endRequest();
  }

  void _navigateToSignInScreen() {
    Future.microtask(() {
      NavigatorKeyState().slideToTopRoute(
        page: const SignInScreen(),
        routeName: SignInScreen.routeName,
      );
    });
  }

  void _navigateToCreateAccountScreen() {
    Future.microtask(() {
      NavigatorKeyState().slideToTopRoute(
        page: const CreateAccountScreen(),
        routeName: CreateAccountScreen.routeName,
        replaceAll: true,
      );
    });
  }

  void _toggleAuthScreen() {
    if (verificationType == VerificationType.signUp)
      return _navigateToSignInScreen();
    return _navigateToCreateAccountScreen();
  }

  void _resetException() {
    setState(() {
      if (apiException != null) apiException = null;
    });
  }

  ///Stores the phone number passed by the [SendVerificationCodeForm].
  ///
  ///Resets any error when resending the form to avoid
  ///confusing the user.
  void _onSend(String value) {
    setState(() {
      phoneNumber = value;
      _resetException();
    });
    startRequest();
  }

  void onError(Object error, StackTrace stackTrace) {
    if (error is! AppApiException ||
        error.errorCodes.isNullOrEmpty ||
        error.errorCodes!.contains(apiInvalidAppFlow) ||
        error.errorCodes!.contains(apiInvalidBodyRequest)) {
      launchErrorBanner();
    } else {
      Future.microtask(() => setState(() {
            apiException = error;
          }));
    }
    endRequest();
  }

  @override
  Future<void> whileIsRequesting();

  Future<bool> onPop() async => true;

  @override
  Widget build(BuildContext context) {
    if (isRequesting) whileIsRequesting();
    return WillPopScope(
      onWillPop: onPop,
      child: Scaffold(
        body: SafeArea(
          child: IgnorePointer(
            ignoring: isRequesting,
            child: AppFilledStepperScrollView(
              totalSteps: verificationType.totalSteps,
              currentStep: currentStep,
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    width: context.width,
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SendVerificationCodeForm(
                          onSend: _onSend,
                          onChanged: _resetException,
                          apiException: apiException,
                          loading: isRequesting,
                          verificationType: verificationType,
                        ),
                        SizedBox(height: 16.h),
                        AppTextSizedButton.headline(
                          text: verificationType == VerificationType.signIn
                              ? context.localeMessage.createAccount
                              : context.localeMessage.signIn,
                          onPressed: _toggleAuthScreen,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

///A special mixin that is used for both
///the [SignInScreen] and [CreateAccountScreen].
///
///This mixin calls the navigation to the [WelcomeScreen]
///and replaces all other routes in the stack.
mixin NavigateToWelcomeScreen {
  void navigateToWelcomeScreen(BuildContext context) {
    NavigatorKeyState().slideToRightRoute(
      context: context,
      page: const WelcomeScreen(),
      routeName: WelcomeScreen.routeName,
      replaceAll: true,
    );
  }
}
