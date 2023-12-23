import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/auth_feature/auth_ui_barrel_file.dart';
import 'package:piix_mobile/auth_feature/auth_utils_barrel_file.dart';
import 'package:piix_mobile/auth_feature/domain/provider/sign_in_provider.dart';
import 'package:piix_mobile/widgets/app_loading_widget/app_loading_widget.dart';

///The starting screen when the user decides to sign in into the app.
final class SignInScreen extends AppLoadingWidget {
  static const routeName = '/sign_in_screen';
  const SignInScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInScreenState();
}

///The State implementation which handles any request made by the user when
///submitting information.
final class _SignInScreenState extends UserPhoneAuthentication
    with NavigateToWelcomeScreen {
  @override
  VerificationType get verificationType => VerificationType.signIn;

  @override
  int get currentStep => 1;

  ///Makes sure that when popping it navigates to the
  ///WelcomeScreen instead of the current [Navigator] routes stack.
  @override
  Future<bool> onPop() async {
    navigateToWelcomeScreen(context);
    return false;
  }

  @override
  Future<void> whileIsRequesting() async =>
      ref.watch(signInPodProvider(phoneNumber)).whenOrNull(
            data: (_) {
              return navigateToVerifyVerificationCodeScreen(
                VerificationType.signIn,
              );
            },
            error: onError,
          );
}
