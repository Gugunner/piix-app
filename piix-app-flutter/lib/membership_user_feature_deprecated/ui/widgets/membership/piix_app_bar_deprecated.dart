import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/navigation_feature/utils/routes_utils.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/detail_pack_bar.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/notification_bloc.dart';
import 'package:piix_mobile/ui/home/widgets/notification_buble_icon.dart';
import 'package:piix_mobile/ui/notifications/notification_screen_deprecated.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

@Deprecated('Use instead a DefinedAppBar')

/// Creates a custom app bar.
class PiixAppBarDeprecated extends ConsumerWidget
    implements PreferredSizeWidget {
  const PiixAppBarDeprecated({
    Key? key,
    this.title = '',
    this.isTabScreen = false,
    this.isMembership = false,
    this.automaticallyImplyLeading = true,
    this.onPressed,
  }) : super(key: key);

  final String title;
  final bool isTabScreen;
  final bool isMembership;
  final bool automaticallyImplyLeading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationBLoC = context.watch<NotificationBLoC>();
    final formNotifier = ref.watch(formNotifierProvider.notifier);
    return AppBar(
      leading: isTabScreen
          ? IconButton(
              icon: const Icon(Icons.style_outlined),
              onPressed: onPressed ??
                  () async {
                    try {
                      //Clean any forms and answers from the user
                      formNotifier.setForm(null);
                    } catch (e) {}
                    RegisteredRouteUtils.appBarNav(context: context);
                  },
            )
          : null,
      automaticallyImplyLeading: automaticallyImplyLeading,
      elevation: 0,
      centerTitle: true,
      actions: isTabScreen
          ? [
              IconButton(
                  icon: Stack(
                    alignment: Alignment.topRight,
                    children: <Widget>[
                      const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.notifications,
                          )),
                      if (notificationBLoC.totalNotifications > 0)
                        Bounce(
                          from: 15.h,
                          animate: false,
                          controller: (controller) => notificationBLoC
                              .closeSnackController = controller,
                          child: NotificationBubbleIcon(
                            notifications: notificationBLoC.totalNotifications,
                          ),
                        )
                    ],
                  ),
                  onPressed: () => Navigator.of(context)
                      .pushNamed(NotificationsScreenDeprecated.routeName))
            ]
          : null,
      title: title.isNotEmpty
          ? Text(
              title,
              style: context.headlineMedium?.copyWith(
                color: PiixColors.white,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
            )
          : null,
      bottom: isMembership
          ? const PreferredSize(
              preferredSize: Size.infinite,
              child: DetailPackBar(),
            )
          : null,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (isMembership ? 68 : 0));
}
