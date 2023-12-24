import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_input_provider.dart';
import 'package:piix_mobile/verification_code_feature/utils/verification_code_copies.dart';
import 'package:piix_mobile/widgets/screen/app_screen/success_screen_deprecated.dart';

@Deprecated('Will be removed in 4.0')
class SuccessSignUpVerificationScreenDeprecated extends ConsumerWidget {
  static const routeName = '/success_sign_up_verification_screen';
  const SuccessSignUpVerificationScreenDeprecated({super.key});

  void _onContinue() {
    // NavigatorKeyState().fadeInRoute(
    //   page:  UserLoadingScreen(),
    //   routeName: UserLoadingScreen.routeName,
    // );
    return;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authMethod = ref.watch(authMethodStateProvider);
    final usernameCredentialProviderNotifier =
        ref.watch(usernameCredentialProvider.notifier);
    final credential =
        usernameCredentialProviderNotifier.completeUsernameCredential;
    final authMessage = authMethod.isPhoneNumber
        ? VerificationCodeCopies.successSignUpPhoneVerification(credential)
        : VerificationCodeCopies.succesSignUpEmailVerification(credential);
    return SuccessAppScreen(
      title: VerificationCodeCopies.successVerification,
      message: authMessage,
      onSuccess: _onContinue,
    );
  }
}
