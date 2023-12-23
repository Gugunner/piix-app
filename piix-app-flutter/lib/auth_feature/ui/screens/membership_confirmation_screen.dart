import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_feature/auth_provider_barrel_file.dart';
import 'package:piix_mobile/auth_feature/auth_ui_barrel_file.dart';
import 'package:piix_mobile/auth_feature/auth_ui_screen_barrel_file.dart';
import 'package:piix_mobile/auth_feature/auth_utils_barrel_file.dart';
import 'package:piix_mobile/auth_feature/user_app_model_barrel_file.dart';
import 'package:piix_mobile/file_feature/file_model_barrel_file.dart';
import 'package:piix_mobile/form_feature/form_provider_barrel.file.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/navigation_feature/navigation_utils_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/banner/banner_barrel_file.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';
import 'package:piix_mobile/widgets/stepper/app_stepper_barrel_file.dart';
import 'package:piix_mobile/widgets/widgets_barrel_file.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

///The screen that shows all the information entered in the
///[PersonalInformationFormScreen] and [DocumentationFormScreen]
///with the rendered images.
///
///This screen allows to navigate back to either the
///[PersonalInformationFormScreen] or the [DocumentationFormScreen]
///to edit the entered information.
///
///It also submits the membership information to start the process
///of verifying the information. The user cannot return to this screen
///unless there is an error with the information submitted or it is
///rejected.
final class MembershipConfirmationScreen extends AppLoadingWidget {
  static const routeName = '/membership_confirmation_screen';

  const MembershipConfirmationScreen({super.key, required this.pictures});

  final List<FileContentModel> pictures;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MembershipConfirmationScreenState();
}

final class _MembershipConfirmationScreenState
    extends AppLoadingWidgetState<MembershipConfirmationScreen>
    with ExitPrompt {
  ///Controls the gestures of elements that act as buttons
  ///but do not have all the button components.
  late TapGestureRecognizer? _onTapRecognizer;

  VerificationType get _verificationType => VerificationType.signUp;

  int get _currentStep => 5;

  UserAppModel? get _user => ref.read(userPodProvider);

  @override
  void initState() {
    super.initState();
    isRequesting = false;
    //Intitialize a gesture by assigning a callback to execute.
    _onTapRecognizer = TapGestureRecognizer()
      ..onTapDown = _navigateToTermsAndConditionsScreen;
  }

  @override
  void dispose() {
    _onTapRecognizer?.dispose();
    super.dispose();
  }

  ///Shows a specific error when the information
  ///cannot be confirmed.
  void _launchErrorBanner() {
    final localeMessage = context.localeMessage;
    final description = localeMessage.confirmInformationError;
    Future.microtask(() {
      ref.read(bannerPodProvider.notifier)
        ..setBanner(
          context,
          cause: BannerCause.error,
          description: description,
          actionText: localeMessage.retry,
          action: () {
            if (mounted) {
              setState(() {
                if (submitError) {
                  isSubmitting = true;
                  submitError = false;
                }
              });
            }
          },
        )
        ..build();
    });
  }

  void _onSubmit() {
    startSubmit();
  }

  void _navigateToTermsAndConditionsScreen(TapDownDetails? details) {
    NavigatorKeyState().fadeInRoute(
      page: const TermsAndConditionsScreen(),
      routeName: TermsAndConditionsScreen.routeName,
    );
  }

  void _goBackToPersonalInformationFormScreen() {
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void _goBackToDocumentationFormScreen() {
    Navigator.pop(context);
  }

  void _navigateToWaitingMembershipVerificationScreen() {
    Future.microtask(
      () => NavigatorKeyState().fadeInRoute(
        page: SuccessfulMembershipVerificationSubmissionScreen(),
        routeName: SuccessfulMembershipVerificationSubmissionScreen.routeName,
        context: context,
        replaceAll: true,
      ),
    );
  }

  @override
  Future<void> whileIsSubmitting() async =>
      ref.watch(confirmUserMainFormsPodProvider).whenOrNull(data: (_) {
        _navigateToWaitingMembershipVerificationScreen();
        endSubmit();
      }, error: (error, stackTrace) {
        Future.microtask(() => setState(() {
              submitError = true;
              _launchErrorBanner();
              endSubmit();
            }));
      });

  @override
  Widget build(BuildContext context) {
    if (isSubmitting) whileIsSubmitting();
    return IgnorePointer(
      ignoring: isSubmitting,
      child: Scaffold(
        body: SafeArea(
          child: AppFilledStepperScrollView(
            totalSteps: _verificationType.totalSteps,
            currentStep: _currentStep,
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  width: context.width,
                  padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 28.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: context.width,
                        child: Text(
                          context.localeMessage.confirmTheEnteredInformation,
                          style:
                              context.accentTextTheme?.headlineLarge?.copyWith(
                            color: PiixColors.infoDefault,
                            letterSpacing: 0.1,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      if (_user != null) UserPersonalInformationCard(_user!),
                      SizedBox(height: 4.h),
                      SizedBox(
                        width: context.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AppTextSizedButton.title(
                                text: context.localeMessage.edit,
                                onPressed:
                                    _goBackToPersonalInformationFormScreen),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      UserPicturesCard(widget.pictures),
                      SizedBox(height: 4.h),
                      SizedBox(
                        width: context.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AppTextSizedButton.title(
                                text: context.localeMessage.edit,
                                onPressed: _goBackToDocumentationFormScreen),
                          ],
                        ),
                      ),
                      SizedBox(height: 32.h),
                      SizedBox(
                        width: 192.w,
                        child: AppFilledSizedButton(
                          text: context.localeMessage.confirm.toUpperCase(),
                          onPressed: _onSubmit,
                          loading: isSubmitting,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text.rich(
                        TextSpan(
                          text: context
                              .localeMessage.acceptByConfirmingInformation,
                          style: context.labelMedium?.copyWith(
                            color: PiixColors.infoDefault,
                          ),
                          children: [
                            TextSpan(
                              text: context.localeMessage.termsAndConditions,
                              style: context.labelLarge?.copyWith(
                                color: PiixColors.primary,
                              ),
                              recognizer: _onTapRecognizer,
                            ),
                            TextSpan(
                              text: context
                                  .localeMessage.ofTheMembershipCreatedForYou,
                              recognizer: _onTapRecognizer,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
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
