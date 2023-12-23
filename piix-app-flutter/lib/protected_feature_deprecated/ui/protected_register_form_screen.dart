import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/auth_feature/domain/provider/verification_code_provider_deprecated.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/data/repository/auth_service_repository.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_input_provider.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_service_provider_deprecated.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/utils/auth_method_enum.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/data/repository/auth_user_form_repository.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/domain/provider/auth_user_form_provider.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/ui/widgets/auth_user_form_widget.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/utils/auth_user_form_utils.dart';
import 'package:piix_mobile/form_feature/domain/model/form_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_answer_provider_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/date_util.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_events_constants.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_parameter_constants.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/state_machine.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/protected_feature_deprecated/data/repository/protected_form_repository.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/bloc/protected_form_provider.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/bloc/protected_provider.dart';
import 'package:piix_mobile/protected_feature_deprecated/utils/protected_copies.dart';
import 'package:piix_mobile/ui/common/piix_confirm_alert_deprecated.dart';
import 'package:piix_mobile/verification_code_feature/ui/verification_code_screen_builder_deprecated.dart';
import 'package:provider/provider.dart';

final protectedRegisterFormKey = GlobalKey<FormState>();

/// This screen shows the form to register a protected.
class ProtectedRegisterFormScreen extends ConsumerStatefulWidget {
  const ProtectedRegisterFormScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProtectedRegisterFormScreenState();
}

class _ProtectedRegisterFormScreenState
    extends ConsumerState<ProtectedRegisterFormScreen> {
  final screenFormKey = GlobalKey<FormState>();
  final scrollController = ScrollController();
  late ProtectedFormNotifier protectedFormNotifier;
  late AuthUserFormNotifier authUserFormNotifier;
  late FormNotifier formNotifier;

  Future<void> getProtectedRegisterForm() async {
    protectedFormNotifier = ref.read(protectedFormProvider);
    ref
        .read(authMethodStateProvider.notifier)
        .setAuthMethod(AuthMethod.protectedEmailSignUp);
    final membershipBLoC = context.read<MembershipProviderDeprecated>();
    final membershipId = membershipBLoC.selectedMembership?.membershipId ?? '';
    await protectedFormNotifier.getProtectedRegisterForm(
      membershipId: membershipId,
    );
  }

  void initializeScreen() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await getProtectedRegisterForm();
      },
    );
  }

  @override
  void initState() {
    initializeScreen();
    super.initState();
  }

  Future<StateMachine?> checkVerificationCodeProcess() async {
    final form = ref.read(formNotifierProvider.notifier).form;
    final phoneNumberField = form?.formFieldBy('protectedPhoneNumber');
    final emailField = form?.formFieldBy('email');
    if (phoneNumberField == null && emailField == null) {
      return null;
    }
    final credential = emailField?.stringResponse;
    //If the field has no response the execution finishes
    if (credential == null) {
      return null;
    }
    final usernameCredentialProviderNotifier =
        ref.read(usernameCredentialProvider.notifier);
    authUserFormNotifier = ref.read(authUserFormProvider);
    const authMethod = AuthMethod.protectedEmailSignUp;
    //Set the values that are needed for a verification of credentials
    ref.read(authMethodStateProvider.notifier).setAuthMethod(authMethod);
    ref.read(usernameCredentialProvider.notifier).set(
          credential,
        );
    final userCredentialStateProviderNotifier =
        ref.read(userCredentialStateProvider.notifier);
    //Send the credential to receive a verification code
    userCredentialStateProviderNotifier.send(
      usernameCredential:
          usernameCredentialProviderNotifier.completeUsernameCredential,
      authMethod: authMethod,
    );
    final credentialState = userCredentialStateProviderNotifier.state;
    //When a conflict occurs it means that the credential is already
    //registered in another account
    if (credentialState == CredentialState.conflict) {
      const authUserFormState = AuthUserFormState.emailAlreadyUsed;
      ref.read(formNotifierProvider.notifier).addResponseErrorTextToField(
            'email',
            text: authUserFormState.responseErrorText ?? '',
          );
      authUserFormNotifier.setAuthUserFormState(AuthUserFormState.sentError);
      return null;
    }
    //If the sending of the credential fails the execution finishes
    //and the form is marked with a sent error
    if (credentialState == CredentialState.notFound ||
        credentialState == CredentialState.error) {
      authUserFormNotifier.setAuthUserFormState(AuthUserFormState.sentError);
      return null;
    }
    //If the credential is successfuly sent, a completing state is set
    //so the verification code flow handles the specific case inside the '
    //widget
    ref
        .read(verificationModeProvider.notifier)
        .setVerificationModeState(VerificationModeStateDeprecated.adding);
    //Navigates to the corresponding VerificationCodeScreenBuilder to
    //build a VerificationCodeScreen and waits for the state value returned
    //when the screen is popped.
    return NavigatorKeyState().getNavigator()?.push<StateMachine?>(
          MaterialPageRoute<StateMachine?>(
            builder: (BuildContext context) =>
                const VerificationCodeScreenBuilderDeprecated(),
          ),
        );
  }

  void onSubmitForm() async {
    //If there is no key related to form do nothing
    if (screenFormKey.currentState == null) {
      return;
    }
    //If any field has an errorText set a generic error
    //that is shown at the end of the form
    if (!(screenFormKey.currentState!.validate())) {
      ref
          .read(formFieldErrorNotifierDeprecatedPodProvider.notifier)
          .setFormFieldError(FormFieldErrorDeprecated.generic);
      return;
    }
    //Unfocus any form field selected by the user when submitting the form
    FocusScope.of(context).unfocus();
    //Disables any submit button and the screen while the method is executing
    authUserFormNotifier.setAuthUserFormState(AuthUserFormState.sending);
    //Launch a check to see if the email or phone number submitted in the form
    //needs to be verified
    final state = await checkVerificationCodeProcess();
    if (!mounted || state == null || (state != StateMachine.three)) {
      authUserFormNotifier.setAuthUserFormState(AuthUserFormState.sentError);
      return;
    }
    final authServiceProvider = context.read<AuthServiceProvider>();
    //Transform the data of the fields to anwsers that can be sent via api
    final formFields = formNotifier.formFields;
    final leganAnswerNotifier = ref.read(formAnswersProvider);
    final newFormFields = await leganAnswerNotifier.checkFormForS3ImagesUploads(
      formFields,
    );
    final answers = leganAnswerNotifier.responsesToAnswers(newFormFields);
    final legalAnswers = await leganAnswerNotifier.getLegalAnswers();
    final mainUserInfoFormId =
        protectedFormNotifier.protectedRegisterForm?.formId ?? '';
    final user = authServiceProvider.user;
    final userId = user?.userId ?? '';
    final membershipBLoC = context.read<MembershipProviderDeprecated>();
    final membership = membershipBLoC.selectedMembership;
    final packageId = membership?.package.id ?? '';
    await authUserFormNotifier.sendProtectedRegisterForm(
      userId: userId,
      mainUserInfoFormId: mainUserInfoFormId,
      answers: answers,
      legalAnswers: legalAnswers,
      packageId: packageId,
    );
    //If the form could not be sent exit the method
    if (authUserFormNotifier.authUserFormState != AuthUserFormState.sent) {
      formNotifier
          .setForm(formNotifier.state?.copyWith(formFields: newFormFields));
      return;
    }
    final protectedInfo = protectedFormNotifier.getProtectedInfo(ref);
    final analyticsInstance = PiixAnalytics.instance;
    analyticsInstance.logEvent(
      eventName: PiixAnalyticsEvents.authProtectedInformation,
      eventParameters: {
        PiixAnalyticsParameters.age: age(protectedInfo.birthdate),
        PiixAnalyticsParameters.gender: protectedInfo.genderName ?? '',
        PiixAnalyticsParameters.country: protectedInfo.countryName ?? '',
        PiixAnalyticsParameters.state: protectedInfo.stateName ?? '',
        PiixAnalyticsParameters.plan: protectedInfo.planName ?? '',
        PiixAnalyticsParameters.communityName: user?.communityName ?? '',
        PiixAnalyticsParameters.communityType: user?.communityTypeId ?? '',
      },
    );
    authUserFormNotifier.setAuthUserFormState(AuthUserFormState.idle);
    final membershipId = membership?.membershipId ?? '';
    context.read<ProtectedProvider>().getAvailableProtected(
          membershipId: membershipId,
        );
    //If everything is correct pop the current route and return to last route
    NavigatorKeyState().getNavigator()?.pop();
  }

  void _onUnfocus() {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    setState(() {});
  }

  void _onPop(BuildContext context, BuildContext dialogContext) {
    Navigator.pop(dialogContext);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    authUserFormNotifier = ref.watch(authUserFormProvider);
    protectedFormNotifier = ref.watch(protectedFormProvider);
    formNotifier = ref.watch(formNotifierProvider.notifier);
    final authUserFormState = authUserFormNotifier.authUserFormState;
    final protectedFormState = protectedFormNotifier.protectedFormState;
    final isLoading = protectedFormState == ProtectedFormState.retrieving;
    final protectedRegisterForm = protectedFormNotifier.protectedRegisterForm;
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (dialogContext) => PiixConfirmAlertDialogDeprecated(
            title: PiixCopiesDeprecated.leaveForm,
            message: PiixCopiesDeprecated.leaveFormMessage,
            onConfirm: () => _onPop(context, dialogContext),
          ),
        );
        return true;
      },
      child: GestureDetector(
        onTap: _onUnfocus,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              PiixCopiesDeprecated.register,
            ),
          ),
          body: IgnorePointer(
            ignoring: authUserFormState == AuthUserFormState.sending ||
                authUserFormState == AuthUserFormState.sent,
            child: SizedBox(
              width: context.width,
              height: context.height,
              child: SingleChildScrollView(
                child: AuthUserFormWidget(
                  title: ProtectedCopies.registerOfProtected,
                  message: ProtectedCopies.registerOfProtectedInstructions,
                  screenFormKey: screenFormKey,
                  isLoading: isLoading,
                  form: protectedRegisterForm,
                  authFormType: AuthFormType.protected,
                  onSubmitForm: onSubmitForm,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
