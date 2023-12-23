import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_input_provider.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/ui/widgets/auth_input_widget.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/ui/widgets/sign_in_or_sign_up/phone_number/phone_number_builder.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/utils/auth_method_enum.dart';

class AuthInputBuilder extends ConsumerWidget {
  const AuthInputBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authMethod = ref.watch(authMethodStateProvider);
    //Uses builder to manage what widget to build
    return Builder(
      builder: (context) {
        if (authMethod == AuthMethod.phoneSignUp ||
            authMethod == AuthMethod.phoneSignIn) {
          return const PhoneNumberBuilder();
        }
        return const AuthInputWidget(
          textInputType: TextInputType.emailAddress,
        );
      },
    );
  }
}
