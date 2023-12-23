import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_input_provider.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

///Contains a specific text
class AuthMethodDisclaimer extends ConsumerWidget {
  const AuthMethodDisclaimer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authMethod = ref.watch(authMethodStateProvider);
    return SizedBox(
      child: Text(
        authMethod.authDisclaimer,
        style: context.accentTextTheme?.labelSmall,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
