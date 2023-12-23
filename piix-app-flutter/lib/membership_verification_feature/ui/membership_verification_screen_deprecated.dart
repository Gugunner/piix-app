import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_feature/domain/provider/user_provider.dart';
import 'package:piix_mobile/auth_feature/domain/model/user_app_model.dart';
import 'package:piix_mobile/membership_verification_feature/ui/waiting_membership_verification_screen_deprecated.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/date_util.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_events_constants.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_parameter_constants.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_values.dart';
import 'package:piix_mobile/membership_verification_feature/domain/provider/membership_verification_provider.dart';
import 'package:piix_mobile/ui/common/logout_button_deprecated.dart';
import 'package:piix_mobile/user_form_feature/ui/user_documentation_form_screen_deprecated.dart';
import 'package:piix_mobile/user_form_feature/ui/user_personal_information_form_screen_deprecated.dart';
import 'package:piix_mobile/utils/app_copies_barrel_file.dart';
import 'package:piix_mobile/utils/log_utils.dart';
import 'package:piix_mobile/widgets/app_bar/logo_app_bar.dart';

import 'package:piix_mobile/widgets/button/card_app_button/card_app_button.dart';
import 'package:piix_mobile/widgets/button/elevated_app_button_deprecated/elevated_app_button_deprecated.dart';
import 'package:piix_mobile/widgets/screen/app_screen/pop_app_screen.dart';

@Deprecated('This class is no longer in use')

///Contains the cards to navigate to the [UserPersonalInformationFormScreenDeprecated] and
///[UserDocumentationFormScreenDeprecated] as well as start membership verification
class MembershipVerificationScreenDeprecated extends ConsumerStatefulWidget {
  static const routeName = '/membership_verification_screen';
  const MembershipVerificationScreenDeprecated({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MembershipVerificationScreenState();
}

class _MembershipVerificationScreenState
    extends ConsumerState<MembershipVerificationScreenDeprecated>
    with LogAnalytics {
  ///Controls the request to start membership verification
  bool isSubmitted = false;

  ///Handles any error occuring when the request to start membership
  ///verification fails
  bool sentError = false;

  ///Logs the event and navigates to [UserPersonalInformationFormScreenDeprecated]
  void onOpenPersonalInformationForm() {
    //Clean the community type to none and avoid showing
    //any instructions
    ref
        .read(communityDeprecatedPodProvider.notifier)
        .setCommunityType(CommunityType.none);
    logEvent(
      eventName: PiixAnalyticsEvents.enterAuthForm,
      eventParameters: {
        PiixAnalyticsParameters.formName:
            PiixAnalyticsValues.personalInformationForm,
      },
    );
    NavigatorKeyState().getNavigator()?.pushNamed(
          UserPersonalInformationFormScreenDeprecated.routeName,
        );
  }

  ///Logs the event and navigates to [UserDocumentationFormScreenDeprecated]
  void onOpenDocumentationForm() {
    logEvent(
      eventName: PiixAnalyticsEvents.enterAuthForm,
      eventParameters: {
        PiixAnalyticsParameters.formName: PiixAnalyticsValues.documentationForm,
      },
    );
    NavigatorKeyState().getNavigator()?.pushNamed(
          UserDocumentationFormScreenDeprecated.routeName,
        );
  }

  ///Watches for success or error when starting membership verification
  void whileIsSubmitted() =>
      ref.watch(membershipVerificationServicePodProvider).whenOrNull(
        data: (_) {
          ///Avoids any memory leak by returning the state to
          ///original values
          Future.microtask(() => setState(() {
                isSubmitted = false;
                sentError = false;
              }));
          logEvent(
            eventName: PiixAnalyticsEvents.submitMembershipVerification,
          );
          final user = ref.read(userPodProvider);
          if (user != null) {
            logEvent(
                eventName: PiixAnalyticsEvents.authPersonalInformation,
                eventParameters: {
                  PiixAnalyticsParameters.age: age(user.birthdate),
                  PiixAnalyticsParameters.gender: user.genderName ?? '',
                  PiixAnalyticsParameters.country: user.countryName ?? '',
                  PiixAnalyticsParameters.state: user.stateName ?? '',
                  PiixAnalyticsParameters.plan: user.planId ?? '',
                  PiixAnalyticsParameters.communityName:
                      user.communityName ?? '',
                  PiixAnalyticsParameters.communityType:
                      user.communityTypeId ?? '',
                });
          }
          Future.microtask(() => NavigatorKeyState().fadeInRoute(
                page: const WaitingMembershipVerificationScreenDeprecated(),
                routeName:
                    WaitingMembershipVerificationScreenDeprecated.routeName,
              ));
        },
        error: (error, stackTrace) {
          ///Stops any future watch action and
          ///activates the flag to alert of an error
          ///when starting membership verification
          Future.microtask(() => setState(() {
                isSubmitted = false;
                sentError = true;
              }));
        },
      );

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userPodProvider);
    final completePersonalInformation =
        user?.completePersonalInformation ?? false;
    final completeDocumentation = user?.completeDocumentation ?? false;
    final rejected = user?.rejected ?? false;
    if (isSubmitted) whileIsSubmitted();
    return PopAppScreen(
      onWillPop: () async => false,
      appBar: LogoAppBar(),
      body: SingleChildScrollView(
        child: Container(
          height: context.remainingHeight * 0.92,
          padding: EdgeInsets.fromLTRB(24.w, 40.h, 24.w, 8.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AuthUserFormCopies.oneMoreStep,
                style: context.primaryTextTheme?.displayMedium?.copyWith(
                  color: PiixColors.infoDefault,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                AuthUserFormCopies.getYourPiixMembership,
                style: context.titleMedium?.copyWith(
                  color: PiixColors.infoDefault,
                ),
                textAlign: TextAlign.center,
              ),
              _MembershipVerificationFormCardAppButton(
                onPressed: onOpenPersonalInformationForm,
                title: AuthUserFormCopies.personalInformation,
                subtitle: AuthUserFormCopies.uniqueInPiix,
                prefixIcon: Icons.person_outline_outlined,
                isSubmitted: completePersonalInformation,
                isRejected: rejected,
                isDisabled: false,
              ),
              _MembershipVerificationFormCardAppButton(
                onPressed: onOpenDocumentationForm,
                title: AuthUserFormCopies.documentation,
                subtitle: AuthUserFormCopies.identifyInPiix,
                prefixIcon: Icons.people_outline_outlined,
                isSubmitted: completeDocumentation,
                isRejected: rejected,
                isDisabled: !completePersonalInformation,
              ),
              if (rejected)
                Container(
                  margin: EdgeInsets.only(
                    bottom: 12.h,
                  ),
                  child: Text(
                    AuthUserFormCopies.errorWithSubmittedInformation,
                    style: context.accentTextTheme?.titleSmall?.copyWith(
                      color: PiixColors.error,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              Flexible(
                child: SizedBox(
                  width: context.width,
                  height: 40.h,
                  child: ElevatedAppButtonDeprecated(
                    onPressed: completeDocumentation && !rejected
                        ? () {
                            setState(() {
                              isSubmitted = true;
                              sentError = false;
                            });
                          }
                        : null,
                    text: PiixCopiesDeprecated.continueText,
                    loading: isSubmitted,
                  ),
                ),
              ),
              if (sentError)
                Container(
                  margin: EdgeInsets.only(
                    bottom: 16.h,
                  ),
                  child: Text(
                    PiixCopiesDeprecated.sorryPleaseTryAgain,
                    style: context.primaryTextTheme?.labelMedium?.copyWith(
                      color: PiixColors.errorText,
                      letterSpacing: 0.1,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              const LogoutButtonOld(),
            ],
          ),
        ),
      ),
    );
  }
}

///A defined card button that chooses the [suffixIcon], [suffixIconColor] and
///[color] by reading the [isSubmitted], [isRejected] and [isDisabled] values.
class _MembershipVerificationFormCardAppButton extends StatelessWidget {
  const _MembershipVerificationFormCardAppButton({
    required this.onPressed,
    required this.title,
    required this.prefixIcon,
    this.isSubmitted = false,
    this.isDisabled = false,
    this.isRejected = false,
    this.subtitle,
  });

  IconData? get suffixIcon {
    if (isRejected) return Icons.info_outline_rounded;
    if (isDisabled) return null;
    if (isSubmitted) return Icons.check_circle;
    return Icons.arrow_right;
  }

  Color get suffixIconColor {
    if (isRejected) return PiixColors.error;
    if (isSubmitted) return PiixColors.success;
    if (!isDisabled) return PiixColors.active;
    return PiixColors.infoDefault;
  }

  Color get color {
    if (isRejected) return PiixColors.error;
    if (isDisabled) return PiixColors.infoDefault;
    if (!isSubmitted) return PiixColors.active;
    return PiixColors.infoDefault;
  }

  final VoidCallback onPressed;
  final bool isSubmitted;
  final bool isDisabled;
  final bool isRejected;
  final String title;
  final IconData prefixIcon;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return FormCardAppButton.icons(
      onPressed: onPressed,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      prefixIconColor: color,
      suffixIconColor: suffixIconColor,
      size: 24.w,
      isDisabled: isDisabled,
      isHighlighted: isRejected || (!isSubmitted && !isDisabled),
      title: title,
      subtitle: subtitle,
      color: color,
    );
  }
}
