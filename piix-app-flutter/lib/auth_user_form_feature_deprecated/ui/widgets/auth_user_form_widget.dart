import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/ui/widgets/sign_in_or_sign_up/auth_method_title.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/data/repository/auth_user_form_repository.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/domain/provider/auth_user_form_provider.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/ui/widgets/auth_user_form_instructions.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/utils/auth_user_form_copies.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/utils/auth_user_form_utils.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/utils/shimmer/shimmer.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_loading.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_wrap.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/bottom_form_action_bar_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/form_generic_error_text.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/load_error_widget_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_icons.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_events_constants.dart';
import 'package:piix_mobile/form_feature/domain/model/form_model_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/form_field_utils.dart';

@Deprecated('Do not use')
class AuthUserFormWidget extends ConsumerWidget {
  const AuthUserFormWidget({
    Key? key,
    required this.title,
    required this.screenFormKey,
    required this.isLoading,
    required this.form,
    required this.authFormType,
    this.message,
    this.onSubmitForm,
  }) : super(key: key);

  final String title;
  final GlobalKey<FormState> screenFormKey;
  final bool isLoading;
  final AuthFormType authFormType;
  final FormModelOld? form;
  final VoidCallback? onSubmitForm;
  final String? message;

  List<FormFieldModelOld> get formFields => form?.formFields ?? [];

  double get loadPadding => isLoading ? 24.w : 0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formNotifier = ref.watch(formNotifierProvider.notifier);
    final authUserFormNotifier = ref.watch(authUserFormProvider);
    final authUserFormState = authUserFormNotifier.authUserFormState;
    final formFieldError =
        ref.read(formFieldErrorNotifierDeprecatedPodProvider);
    final formStateDisable = authUserFormState == AuthUserFormState.sending ||
        authUserFormState == AuthUserFormState.sent;
    final submitDisable =
        formStateDisable || !formNotifier.requiredFieldsFilled(formFields);
    if (form == null && !isLoading) {
      return LoadErrorWidgetDeprecated(
        message: AuthUserFormCopies.errorLoadingForm,
        onPressed: () {
          Navigator.pop(context);
        },
      );
    }
    return SizedBox(
      width: context.width,
      child: Form(
        key: screenFormKey,
        child: Shimmer(
          child: ShimmerLoading(
            isLoading: isLoading,
            child: ShimmerWrap(
              child: Container(
                padding: EdgeInsets.only(
                  top: 40.h,
                  left: loadPadding,
                  right: loadPadding,
                ),
                width: context.width,
                height: isLoading ? 32.h : null,
                child: Column(
                  children: [
                    AuthTitle(
                      isLoading: isLoading,
                      title: title,
                    ),
                    if (authFormType == AuthFormType.protected) ...[
                      SizedBox(
                        height: 12.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                        ),
                        child: Text(
                          message ?? '',
                          style: context.textTheme?.bodyMedium,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                    SizedBox(
                      height: 20.h,
                    ),
                    if (form != null)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                        ),
                        child: AuthUserFormInstructions(
                          child: Column(
                            children: [
                              ...buildFormFields(
                                formFields,
                                isLoading,
                              ),
                            ],
                          ),
                        ),
                      ),
                    //Either a generic form field error or an error
                    //sending the form shows this message
                    if (formFieldError == FormFieldErrorDeprecated.generic ||
                        authUserFormNotifier.authUserFormState ==
                            AuthUserFormState.sentError)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                        ),
                        child: FormGenericErroText(
                          text: formFieldError.errorMessage ??
                              PiixCopiesDeprecated.sorryPleaseTryAgain,
                        ),
                      ),
                    if (!isLoading) ...[
                      SizedBox(
                        height: 8.h,
                      ),
                      BottomFormActionBarDeprecated(
                        actionOneText: PiixCopiesDeprecated.continueText,
                        actionTwoText: PiixCopiesDeprecated.help,
                        hasSecondAction: true,
                        icon: PiixIcons.whatsapp,
                        onActionTwoPressed: () =>
                            handleLaunchHelp(context, ref),
                        onActionOnePressed: submitDisable ? null : onSubmitForm,
                        isLoading: formStateDisable,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void handleLaunchHelp(BuildContext context, WidgetRef ref) {
    launchWhatsapp(context, ref);
    final analyticsInstance = PiixAnalytics.instance;
    analyticsInstance.logEvent(
      eventName: PiixAnalyticsEvents.getAuthFormHelp,
      eventParameters: {
        PiixAnalyticsEvents.submitAuthForm: authFormType.analyticsFormType,
      },
    );
  }
}
