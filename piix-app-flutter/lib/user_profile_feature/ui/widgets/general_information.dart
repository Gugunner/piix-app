import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/notification_bloc.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_icons.dart';
import 'package:piix_mobile/ui/notifications/notification_screen_deprecated.dart';
import 'package:piix_mobile/user_profile_feature/ui/widgets/navigation_row.dart';
import 'package:provider/provider.dart';

/// It shows general information about the user, such as their emergency contacts
/// and if they have notifications.
class GeneralInformation extends StatelessWidget {
  const GeneralInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificationBLoC = context.watch<NotificationBLoC>();
    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //TODO: Uncomment after august release.
          //const AnimatedEmergencyContactRow(),
          NavigationRow(
            onTap: () => Navigator.pushNamed(
                context, NotificationsScreenDeprecated.routeName),
            label: PiixCopiesDeprecated.notificationLabel,
            icon: SizedBox(
              width: 25.w,
              child: Stack(
                children: [
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(PiixIcons.notificaciones,
                          color: PiixColors.infoDefault)),
                  Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      width: 20.w,
                      child: Container(
                        height: 7.h,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: notificationBLoC.totalNotifications > 0
                                ? PiixColors.error
                                : Colors.transparent),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
