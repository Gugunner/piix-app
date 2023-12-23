import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/notification_bloc.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/piix_app_bar_deprecated.dart';
import 'package:piix_mobile/ui/common/clamping_scale_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Use instead NotificationsHubScreen')

///This a notification screens, shows in profile module.
class NotificationsScreenDeprecated extends StatelessWidget {
  const NotificationsScreenDeprecated({Key? key}) : super(key: key);
  static const routeName = '/notification';

  @override
  Widget build(BuildContext context) {
    final notificationBLoC = context.watch<NotificationBLoC>();
    return ClampingScaleDeprecated(
      child: Scaffold(
        appBar: const PiixAppBarDeprecated(
            title: PiixCopiesDeprecated.notificationLabel),
        backgroundColor: PiixColors.veryLightPink2,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 22.w,
                right: 22.w,
                top: 20.h,
                bottom: 6.h,
              ),
              child: Text(
                PiixCopiesDeprecated.notificationHistory,
                textAlign: TextAlign.start,
                style: context.textTheme?.headlineSmall,
              ),
            ),
            if (notificationBLoC.totalNotifications == 0)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        PiixCopiesDeprecated.noNotificationsLabel,
                        style: context.textTheme?.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
