import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/utils/auth_input_state_enum.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/utils/auth_method_enum.dart';
import 'package:piix_mobile/utils/regex.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_input_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthInput extends _$AuthInput {
  @override
  AuthInputState build() => AuthInputState.idle;

  void setAuthInputState(AuthInputState value) {
    state = value;
  }

  AuthInputState get authInputState => state;
}

@Riverpod(keepAlive: true)
class AuthMethodState extends _$AuthMethodState {
  @override
  AuthMethod build() => AuthMethod.none;

  void setAuthMethod(AuthMethod method) {
    state = method;
  }

  //Switched the authMethod email to phone number but
  //keeps the same sign in or sign up mode
  void switchEmailOrPhone() {
    AuthMethod newMethod;
    if (state.isSignIn) {
      newMethod = state == AuthMethod.phoneSignIn
          ? AuthMethod.emailSignIn
          : AuthMethod.phoneSignIn;
    } else {
      newMethod = state == AuthMethod.phoneSignUp
          ? AuthMethod.emailSignUp
          : AuthMethod.phoneSignUp;
    }
    //Cleans any state when switching
    clearProvider(authMethod: newMethod);
  }

  //Switches mode from sign in to sign up
  //but keeps the same authMethod of phone or email
  void switchSignInOrSignUp() {
    AuthMethod newMethod;
    if (state.isSignIn) {
      newMethod = state == AuthMethod.phoneSignIn
          ? AuthMethod.phoneSignUp
          : AuthMethod.emailSignUp;
    } else {
      newMethod = state == AuthMethod.phoneSignUp
          ? AuthMethod.phoneSignIn
          : AuthMethod.emailSignIn;
    }
    //Cleans any state when switching
    clearProvider(authMethod: newMethod);
  }

  ///Checks what type of service error it should assign to the [authInputState]
  void checkForInputErrors() {
    final authInputStateNotifier = ref.read(authInputProvider.notifier);
    if (state.isPhoneNumber) {
      if (state.isSignIn) {
        authInputStateNotifier
            .setAuthInputState(AuthInputState.unregisteredPhone);
        return;
      }
      //By default if it is not sign in, it is sign up
      authInputStateNotifier.setAuthInputState(AuthInputState.alreadyUsedPhone);
      return;
    }
    //By default if it is not phone is email
    if (state.isSignIn) {
      authInputStateNotifier
          .setAuthInputState(AuthInputState.unregisteredEmail);
      return;
    }
    //By default if it is not sign in, it is sign up
    authInputStateNotifier.setAuthInputState(AuthInputState.alreadyUsedEmail);
  }

  ///Cleans all the states handled by this provider.
  ///
  ///A new [authMethod] can be optionally passed when cleaning all states.
  void clearProvider({AuthMethod? authMethod}) {
    final authInputStateNotifier = ref.read(authInputProvider.notifier);
    final userNameCredentialProvider =
        ref.read(usernameCredentialProvider.notifier);
    authInputStateNotifier.setAuthInputState(AuthInputState.idle);
    if (authMethod != null) {
      state = authMethod;
    }
    userNameCredentialProvider.set(null);
  }
}

@Riverpod(keepAlive: true)
class UsernameCredential extends _$UsernameCredential {
  @override
  String? build() => null;

  void check(String? usernameCredential) {
    final authInputStateNotifier = ref.read(authInputProvider.notifier);
    final isPhoneNumber = ref.read(authMethodStateProvider).isPhoneNumber;
    if (usernameCredential.isEmptyNull) {
      authInputStateNotifier.setAuthInputState(isPhoneNumber
          ? AuthInputState.emptyPhone
          : AuthInputState.emptyEmail);
    } else if (!(RegExp(noLadaPhoneRegex).hasMatch(usernameCredential!)) &&
        !(RegExp(emailRegex).hasMatch(usernameCredential))) {
      authInputStateNotifier.setAuthInputState(isPhoneNumber
          ? AuthInputState.invalidPhone
          : AuthInputState.invalidEmail);
    } else {
      authInputStateNotifier.setAuthInputState(AuthInputState.idle);
    }
  }

  void set(String? usernameCredential) {
    state = usernameCredential;
    if (usernameCredential.isNull) return;
    check(
      usernameCredential,
    );
    return;
  }

  String get completeUsernameCredential {
    final authMethod = ref.read(authMethodStateProvider.notifier).state;
    final usernameCredential = state ?? '';
    if (!authMethod.isPhoneNumber ||
        //Prevents concatenating the lada again if the phone number
        //value already has it
        usernameCredential.contains(ConstantsDeprecated.mexicanLada)) {
      return usernameCredential;
    }
    return '${ConstantsDeprecated.mexicanLada}$usernameCredential';
  }
}
