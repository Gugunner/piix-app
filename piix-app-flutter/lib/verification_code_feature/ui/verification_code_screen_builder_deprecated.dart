import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/data/repository/auth_service_repository.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_input_provider.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_service_provider_deprecated.dart';
import 'package:piix_mobile/verification_code_feature/ui/widgets/verification_code_screen_widget_deprecated.dart';
import 'package:piix_mobile/widgets/app_bar/logo_app_bar.dart';
import 'package:piix_mobile/widgets/screen/app_screen/pop_app_screen.dart';
import 'package:provider/provider.dart';

@Deprecated('Use instead AppVerificationCodeScreen')
class VerificationCodeScreenBuilderDeprecated extends ConsumerStatefulWidget {
  static const routeName = '/verification-code';

  const VerificationCodeScreenBuilderDeprecated({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VerificationCodeScreenBuilderState();
}

class _VerificationCodeScreenBuilderState
    extends ConsumerState<VerificationCodeScreenBuilderDeprecated> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authServiceProvider = context.read<AuthServiceProvider>();
      authServiceProvider.setVerificationCodeState(VerificationCodeState.idle);
    });
    super.initState();
  }

  void _onUnfocus() {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    setState(() {});
  }

  Future<bool> _onWillPop() async {
    final authServiceProvider = context.read<AuthServiceProvider>();
    authServiceProvider.clearProvider();
    ref.read(authMethodStateProvider.notifier).clearProvider();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopAppScreen(
      onWillPop: _onWillPop,
      onUnfocus: _onUnfocus,
      appBar: LogoAppBar(),
      body: SingleChildScrollView(
        child: VerificationCodeScreenWidgetDeprecated(
          onUnfocus: _onUnfocus,
        ),
      ),
    );
  }
}
