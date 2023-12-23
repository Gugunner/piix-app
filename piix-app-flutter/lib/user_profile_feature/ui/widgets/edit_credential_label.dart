import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_feature/domain/provider/verification_code_provider_deprecated.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/data/repository/auth_service_repository.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_input_provider.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_service_provider_deprecated.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/utils/auth_method_enum.dart';
import 'package:piix_mobile/utils/regex.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/general_app_feature/api/local/app_shared_preferences.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/app_bloc.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/ui_bloc.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_banner_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_banner_content_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/state_machine.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/user_repository_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:piix_mobile/ui/common/piix_confirm_alert_deprecated.dart';
import 'package:piix_mobile/user_profile_feature/ui/widgets/change_credential_input.dart';
import 'package:piix_mobile/user_profile_feature/utils/edit_credential_utils.dart';
import 'package:piix_mobile/verification_code_feature/ui/verification_code_screen_builder_deprecated.dart';
import 'package:provider/provider.dart';

///This widget handles all the states needed to submit
///a new user credential whether a password or an email.
class EditCredentialLabel extends ConsumerStatefulWidget {
  const EditCredentialLabel({
    Key? key,
    this.isEmail = false,
  }) : super(key: key);
  final bool isEmail;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditCredentialLabelState();
}

class _EditCredentialLabelState extends ConsumerState<EditCredentialLabel> {
  late UiBLoC uiBLoC;
  late UserBLoCDeprecated userBLoC;
  late AuthServiceProvider authServiceProvider;
  // late VerificationCode verificationCodeProviderNotifier;
  //A UI state that changes if the user succesfully updates the user credential
  //A UI state that changes when the user submits information
  bool submit = false;
  //A UI state uses to show a circular progress indicator
  bool isLoading = false;
  //The controller for the password value
  final passwordController = TextEditingController();
  //The controller for the email or phone value
  final credentialController = TextEditingController();

  EditCredentialType get editCredentialType {
    if (widget.isEmail) {
      return EditCredentialType.email;
    }
    return EditCredentialType.phone;
  }

  Future<void> onUpdatePhoneNumber(BuildContext context) async {
    final user = userBLoC.user;
    //If no user is stored in the provider do not update credential
    //(this condition) is for protection in dev and will never occur
    //in production
    if (user == null) return;
    //If the phone is not valid, exit the method
    //and do nothing
    final isCheckPhone =
        RegExp(noLadaPhoneRegex).hasMatch(credentialController.text);
    if (!isCheckPhone) return;
    //If the phone number is the same the user already has, exit
    //the method and do nothing
    if (user.phoneNumber == credentialController.text) return;
    const authMethod = AuthMethod.phoneUpdate;
    final credential =
        '${ConstantsDeprecated.ladas.first}${credentialController.text}';
    ref.read(authMethodStateProvider.notifier).setAuthMethod(authMethod);
    ref.read(usernameCredentialProvider.notifier).set(
          credential,
        );

    final state = await _onVerifyCode(authMethod);
    //Checks if the state is is different from the correct one
    //or the user exit the verification without verifying
    if (state == null || state != StateMachine.two) {
      setUserActionStateAndBanner(userBLoC.userActionState);
      return;
    }
    uiBLoC.loadText = user.phoneNumber.isNotNullEmpty
        ? PiixCopiesDeprecated.edittingPhone
        : PiixCopiesDeprecated.addingPhone;
    await userBLoC.updateUserPhoneNumber(
      userId: user.userId,
      newPhoneNumber: credential,
    );
  }

  Future<void> onUpdateEmail(BuildContext context) async {
    final user = userBLoC.user;
    //If no user is stored in the provider do not update credential
    //(this condition) is for protection in dev and will never occur
    //in production
    if (user == null) return;
    //If the email is not valid, exit the method
    //and do nothing
    final isCheckEmail = RegExp(emailRegex).hasMatch(credentialController.text);
    if (!isCheckEmail) return;
    //If the email is the same the user already has, exit
    //the method and do nothing
    if (user.email == credentialController.text) return;
    //Set the values that are needed for a verification of credentials
    const authMethod = AuthMethod.emailUpdate;
    ref.read(authMethodStateProvider.notifier).setAuthMethod(authMethod);
    ref.read(usernameCredentialProvider.notifier).set(
          credentialController.text,
        );
    final stateMachine = await _onVerifyCode(authMethod);
    if (stateMachine == null || stateMachine != StateMachine.two) {
      setUserActionStateAndBanner(userBLoC.userActionState);
      return;
    }
    uiBLoC.loadText = user.email.isNotNullEmpty
        ? PiixCopiesDeprecated.edittingEmail
        : PiixCopiesDeprecated.addingEmail;
    await userBLoC.updateUserEmail(
      userId: user.userId,
      currentEmail: user.email,
      newEmail: credentialController.text,
    );
  }

  Future<void> onUpdateUserCredential(BuildContext context) async {
    final bannerInstance = PiixBannerDeprecated.instance;
    userBLoC.userActionState = UserActionStateDeprecated.idle;
    uiBLoC.loadText = PiixCopiesDeprecated.startUpdatingProcess;
    PiixBannerContentDeprecated? banner;
    if (editCredentialType == EditCredentialType.phone) {
      await onUpdatePhoneNumber(context);
    } else {
      await onUpdateEmail(context);
    }
    if (userBLoC.userActionState == UserActionStateDeprecated.updated) {
      //Set the values for the user in the provider
      if (editCredentialType == EditCredentialType.phone) {
        userBLoC..setUserPhone = credentialController.text;
      } else {
        userBLoC..setUserEmail = credentialController.text;
      }
      //Get the current auth user stored in the device as the custom access
      //token and unix time is needed to reauthenticate if credentials change
      final authUser = await AppSharedPreferences.recoverAuthUser();
      //If no authUser is stored do not update credential (this condition)
      //is for protection in dev and will never occur in production
      if (authUser == null) return;
      await authServiceProvider.sendHashableAuthValues(
        userId: authUser.userId ?? '',
        hashableCustomAuthToken: authUser.customAccessToken ?? '',
        hashableUnixTime: authUser.hashableUnixTime ?? -1,
      );
      final authMethod = ref.read(authMethodStateProvider);
      final credential = ref
          .read(usernameCredentialProvider.notifier)
          .completeUsernameCredential;
      if (userBLoC.user == null) return;
      authServiceProvider.storeAuthUser(userBLoC.user!,
          authMethod: authMethod, credential: credential);
      clearAndCloseDialog();
    }
    //If the user action state is the same as in the beginning of the
    //method then exit without showing the banner.
    if (userBLoC.userActionState == UserActionStateDeprecated.idle) return;
    banner = PiixBannerContentDeprecated(
      title: editCredentialType.credentialTitle ?? '',
      subtitle: editCredentialType.credentialSubtitle ?? '',
      iconData: credentialIcon,
      cardBackgroundColor: credentialColor ?? Colors.transparent,
      height: 68.h,
    );
    //Once the response is received it triggers the creation for a banner
    bannerInstance.builder(
      context,
      children: banner.build(context),
    );
  }

  void clearAndCloseDialog() {
    credentialController.clear();
    NavigatorKeyState().getNavigator()?.pop();
  }

  void setUserActionStateAndBanner(
    UserActionStateDeprecated userActionState,
  ) {
    userBLoC.userActionState = userActionState;
    clearAndCloseDialog();
  }

  //Send credential service, set verification mode state
  Future<StateMachine?> _onVerifyCode(AuthMethod authMethod) async {
    authServiceProvider.setVerificationCodeState(VerificationCodeState.idle);
    final credential = editCredentialType == EditCredentialType.email
        ? credentialController.text
        : '${ConstantsDeprecated.ladas.first}${credentialController.text}';
    final userCredentialStateProviderNotifier =
        ref.read(userCredentialStateProvider.notifier);
    await userCredentialStateProviderNotifier.send(
      usernameCredential: credential,
      authMethod: authMethod,
    );
    final credentialState = userCredentialStateProviderNotifier.state;
    if (credentialState == CredentialState.notFound ||
        credentialState == CredentialState.error) {
      userBLoC.userActionState = UserActionStateDeprecated.error;
      return null;
    }
    if (credentialState == CredentialState.conflict) {
      userBLoC.userActionState = UserActionStateDeprecated.alreadyExists;
      return null;
    }
    ref
        .read(verificationModeProvider.notifier)
        .setVerificationModeState(VerificationModeStateDeprecated.updating);
    final stateMachine =
        await NavigatorKeyState().getNavigator()?.push<StateMachine?>(
              MaterialPageRoute<StateMachine?>(
                builder: (BuildContext context) =>
                    const VerificationCodeScreenBuilderDeprecated(),
              ),
            );
    return stateMachine;
  }

  ///A wider scope method that handles the submit and updated states
  ///by using a setDialogState inside the [Dialog]
  void _onConfirm(
      BuildContext context, Function(void Function()) setDialogState) async {
    setDialogState(() {
      submit = true;
    });
    isLoading = true;
    await onUpdateUserCredential(context);
    isLoading = false;
    if (mounted) {
      setDialogState(() {
        submit = false;
      });
    }
  }

  @override
  void initState() {
    uiBLoC = context.read<UiBLoC>();
    authServiceProvider = context.read<AuthServiceProvider>();
    super.initState();
  }

  @override
  void dispose() {
    final bannerInstance = PiixBannerDeprecated.instance;
    bannerInstance.removeEntry();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userBLoC = context.watch<UserBLoCDeprecated>();
    final appBLoC = context.watch<AppBLoC>();
    return Row(
      children: [
        Flexible(
          child: Text(
            editCredentialType.credentialLabel,
            textAlign: TextAlign.left,
            style: context.textTheme?.bodyMedium?.copyWith(
              color: editCredentialType.credentialLabel.contains('Agregar')
                  ? PiixColors.active
                  : PiixColors.infoDefault,
            ),
          ),
        ),
        SizedBox(width: ScreenUtil().setWidth(10)),
        GestureDetector(
          onTap: () async {
            await showDialog<void>(
              barrierDismissible: false,
              context: context,
              builder: (_) {
                return StatefulBuilder(
                  builder: (__, setDialogState) {
                    final isDisable = userBLoC.userActionState ==
                            UserActionStateDeprecated.updating ||
                        appBLoC.signInState == SignInState.signingIn ||
                        submit;

                    return PiixConfirmAlertDialogDeprecated(
                      title: editCredentialType.dialogTitle,
                      message: editCredentialType.dialogMessage,
                      hasLoader: isLoading,
                      isDisable: isDisable,
                      onConfirm: !isDisable
                          ? () {
                              _onConfirm(context, setDialogState);
                            }
                          : null,
                      onCancel: () {
                        credentialController.clear();
                        NavigatorKeyState().getNavigator()?.pop();
                      },
                      child: ChangeCredentialInput(
                        isEmail: widget.isEmail,
                        refresh: () => setDialogState(() {}),
                        controller: credentialController,
                      ),
                    );
                  },
                );
              },
            );
          },
          child: Icon(
            Icons.edit,
            size: 15.h,
            color: PiixColors.clearBlue,
          ),
        )
      ],
    );
  }
}
