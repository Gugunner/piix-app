import 'package:piix_mobile/src/features/authentication/application/auth_service_barrel_file.dart';
import 'package:piix_mobile/src/utils/verification_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_account_sign_in_page_controller.g.dart';

///The types of authentication the user can perform.
enum AuthenticationFormType {
  register,
  signIn,
}

///The controller used to create an account or sign in with email
///and verification code.
@riverpod
class CreateAccountSignInController extends _$CreateAccountSignInController {
  //Initialize with a null state.
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<void> sendVerificationCodeByEmail(String email, String languageCode,
      VerificationType verificationType) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(authServiceProvider).sendVerificationCodeByEmail(
              email,
              languageCode,
              verificationType,
            ));
  }

  Future<void> authenticateWithEmailAndVerificationCode(
      AuthenticationFormType formType,
      {required String email,
      required String verificationCode}) async {
    state = const AsyncLoading();
    switch (formType) {
      case AuthenticationFormType.register:
        state = await AsyncValue.guard(
          () => ref
              .read(authServiceProvider)
              .createAccountWithEmailAndVerificationCode(
                  email, verificationCode),
        );
        break;
      case AuthenticationFormType.signIn:
        state = await AsyncValue.guard(
          () =>
              ref.read(authServiceProvider).signInWithEmailAndVerificationCode(
                    email,
                    verificationCode,
                  ),
        );
        break;
    }
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    state =
        await AsyncValue.guard(() => ref.read(authServiceProvider).signOut());
  }
}
