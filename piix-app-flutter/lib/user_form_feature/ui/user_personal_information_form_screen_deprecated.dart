import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:piix_mobile/auth_feature/domain/provider/user_provider.dart';
import 'package:piix_mobile/auth_feature/domain/provider/verification_code_provider_deprecated.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_input_provider.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_events_constants.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_parameter_constants.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_values.dart';
import 'package:piix_mobile/user_form_feature/domain/user_form_provider_deprecated.dart';
import 'package:piix_mobile/utils/app_copies_barrel_file.dart';
import 'package:piix_mobile/utils/log_utils.dart';
import 'package:piix_mobile/widgets/screen/app_form_screen/app_user_form_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'user_personal_information_verification_code_screen.dart';

@Deprecated('The form is deprecated')
class UserPersonalInformationFormScreenDeprecated extends AppUserFormScreen {
  static const routeName = '/user_personal_information_form_screen';

  const UserPersonalInformationFormScreenDeprecated({super.key})
      : super(title: AuthUserFormCopies.completeYourInformation);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserPersonalInformationFormScreenState();
}

class _UserPersonalInformationFormScreenState extends AppUserFormScreenState
    with LogAnalytics {
  bool isSendingCredential = false;

  @override
  void onCheckForm() async {
    //If there is no key related to form do nothing
    if (screenFormKey.currentState == null) return;
    //If any field has an errorText set a generic error
    //that is shown at the end of the form
    if (!(screenFormKey.currentState!.validate())) {
      ref
          .read(formFieldErrorNotifierDeprecatedPodProvider.notifier)
          .setFormFieldError(FormFieldErrorDeprecated.generic);
      return;
    }
    //Unfocus any form field selected by the user when submitting the form
    onUnfocus();
    //Launch a check to see if the email or phone number submitted in the form
    //needs to be verified via code verification
    final shouldVerifyCredential = ref
        .read(personalInformationFormNotifierProvider.notifier)
        .getShouldVerifyCredential();
    //If the value is null it means that there has been an error and the form
    //can't be checked
    if (shouldVerifyCredential == null) return;
    //When the credential does not need to be verified
    //it starts the [whileIsSending] method inside the build logic
    //by setting [isSending] to true and exiting the method
    if (!shouldVerifyCredential) {
      setState(() {
        isSending = true;
      });
      return;
    }
    //If the credential needs to be verified
    //it starts [whileIsSendingCredential] by
    //setting the [isSendingCredential] to true to
    //send an SMS or email with the verification code
    setState(() {
      isSendingCredential = true;
    });
    return;
  }

  @override
  Future<bool> onWillPop() async {
    ref
        .read(userFormStateNotifierProvider.notifier)
        .setUserFormState(UserFormState.IDLE);
    return super.onWillPop();
  }

  @override
  Future<void> whileIsRequesting() async => ref
          .watch(userFormServiceNotifierProvider(formId: 'basicInsuredForm'))
          .whenOrNull(data: (_) {
        endRequest();
      }, error: (_, __) {
        endRequest();
      });

  void whileIsSendingCredential() =>
      ref.watch(sendCredentialServiceProvider).whenOrNull(
        data: (_) {
          Future.microtask(() {
            setState(() {
              isSendingCredential = false;
            });
            NavigatorKeyState().getNavigator()?.pushNamed(
                UserPersonalInformationVerificationCodeScreen.routeName);
          });
        },
        error: (error, stackTrace) {
          Future.microtask(() {
            setState(() {
              isSendingCredential = false;
            });
            if (error is! DioError) return;
            final statusCode = error.response?.statusCode ?? 500;
            if (statusCode == HttpStatus.conflict) {
              final isPhone = ref.read(authMethodStateProvider).isPhoneNumber;
              final formFieldId = isPhone ? 'phoneNumber' : 'email';
              //When there is a conflict it means that either the phone number
              //or email has been used and the UserFormState is set
              //so it can be shown on the formField
              if (isPhone) {
                ref
                    .read(userFormStateNotifierProvider.notifier)
                    .setUserFormState(UserFormState.PHONE_NUMBER_ALREADY_USED);
              } else {
                ref
                    .read(userFormStateNotifierProvider.notifier)
                    .setUserFormState(UserFormState.EMAIL_ALREADY_USED);
              }
              //After setting the UserFormState the responseErrorText of the
              //state is read and assigned to the formField
              ref
                  .read(formNotifierProvider.notifier)
                  .addResponseErrorTextToField(
                    formFieldId,
                    text: ref
                            .read(userFormStateNotifierProvider)
                            .responseErrorText ??
                        '',
                  );
            }
          });
        },
      );

  @override
  void whileIsSending() => ref
          .watch(userFormServiceNotifierProvider(send: true))
          .whenOrNull(data: (_) {
        Future.microtask(() {
          ref.read(userPodProvider.notifier).setUpPersonalInformation();
          logEvent(
            eventName: PiixAnalyticsEvents.submitAuthForm,
            eventParameters: {
              PiixAnalyticsParameters.formName:
                  PiixAnalyticsValues.personalInformationForm,
            },
          );
          setState(() {
            isSending = false;
          });
          NavigatorKeyState().getNavigator()?.pop();
        });
      }, error: (_, __) {
        Future.microtask(() => setState(() {
              isSending = false;
            }));
      });

  @override
  Widget build(BuildContext context) {
    if (isSendingCredential) whileIsSendingCredential();
    return super.build(context);
  }
}
