import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_feature/domain/provider/auth_service_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/app_bloc.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_values.dart';
import 'package:provider/provider.dart';

@Deprecated('Use instead SignOutDialog')

///This widget shows cancel and ok button
///The ok button clean shared preferences and blocs and make logout.
///
class LogoutDialogButtons extends ConsumerWidget {
  const LogoutDialogButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonStyle = Theme.of(context).textButtonTheme.style;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextButton(
              style: buttonStyle,
              onPressed: () => Navigator.pop(context),
              child: Text(
                PiixCopiesDeprecated.cancelButton.toUpperCase(),
                style: context.primaryTextTheme?.titleMedium
                    ?.copyWith(color: PiixColors.active),
              ),
            ),
            TextButton(
              style: buttonStyle,
              onPressed: () => handleLogout(context, ref),
              child: Text(
                PiixCopiesDeprecated.okButton.toUpperCase(),
                style: context.primaryTextTheme?.titleMedium
                    ?.copyWith(color: PiixColors.active),
              ),
            )
          ]),
    );
  }

  void handleLogout(BuildContext context, WidgetRef ref) async {
    ref.read(customTokenServiceProvider.notifier).signOut();
    final appBLoC = context.read<AppBLoC>();
    appBLoC.signOut(
      userTriggered: true,
      trigger: PiixAnalyticsValues.userSignOut,
    );
  }
}
