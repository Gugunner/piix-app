import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_input_provider.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/ui/sign_in_or_sign_up_screen_deprecated.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/ui/widgets/startup_deprecated/startup_slogan_deprecated.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/utils/auth_method_enum.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/utils/auth_user_copies.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/widgets/button/elevated_app_button_deprecated/elevated_app_button_deprecated.dart';
import 'package:piix_mobile/widgets/button/outlined_app_button/outlined_app_button_deprecated.dart';

@Deprecated('Remove in 4.0')
class SignInOrSignUpControlsDeprecated extends ConsumerWidget {
  const SignInOrSignUpControlsDeprecated({super.key});

  void _onStart(
    WidgetRef ref, {
    required AuthMethod authMethod,
  }) async {
    ref
        .read(authMethodStateProvider.notifier)
        .clearProvider(authMethod: authMethod);
    NavigatorKeyState()
        .getNavigator()
        ?.pushNamed(SignInOrSignUpScreenDeprecated.routeName);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const StartupSloganDeprecated(),
        SizedBox(
          height: 28.h,
        ),
        SizedBox(
          width: context.width * 0.8,
          child: ElevatedAppButtonDeprecated(
            onPressed: () => _onStart(
              ref,
              authMethod: AuthMethod.phoneSignUp,
            ),
            text: AuthUserCopies.wantToSignUp,
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
        SizedBox(
          width: context.width * 0.8,
          child: OutlinedAppButtonDeprecated(
            onPressed: () => _onStart(
              ref,
              authMethod: AuthMethod.phoneSignIn,
            ),
            text: AuthUserCopies.signInWithAccount,
          ),
        ),
      ],
    );
  }
}
