import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_icons.dart';
import 'package:piix_mobile/ui/common/logout_dialog/logout_dialog_deprecated.dart';
import 'package:piix_mobile/widgets/app_bar/static_app_bar_deprecated.dart';


///A simple [StaticAppBar] that shows a centered String [title]
///and an action to sign out using the [LogoutDialog]
@Deprecated('Do not use')
class SignOutAppBar extends StaticAppBar {
  const SignOutAppBar({super.key, required super.title})
      : assert(title != null && title.length > 0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StaticAppBarBuilder(
      title: title,
      actions: [const _SignOutAction()],
    );
  }
}

class _SignOutAction extends ConsumerWidget {
  const _SignOutAction();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () async =>
          showDialog(builder: (_) => const LogoutDialog(), context: context),
      icon: const Icon(
        PiixIcons.logout,
        color: PiixColors.space,
      ),
    );
  }
}
