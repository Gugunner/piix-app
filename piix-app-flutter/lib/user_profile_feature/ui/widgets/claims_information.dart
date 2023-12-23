import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/claim_ticket_feature/ui/history/claim_ticket_history_screen_builder_deprecated.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/notification_bloc.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/user_profile_feature/ui/widgets/navigation_row.dart';
import 'package:provider/provider.dart';

/// This widget contains buttons to make a claims.
class ClaimsInformation extends StatelessWidget {
  const ClaimsInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificationBLoC = context.watch<NotificationBLoC>();
    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          NavigationRow(
            onTap: () {
              Navigator.pushNamed(
                context,
                ClaimTicketHistoryScreenBuilderDeprecated.routeName,
              );
            },
            label: PiixCopiesDeprecated.historyClaims,
            icon: SizedBox(
              width: 25.w,
              child: Stack(
                children: [
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.perm_phone_msg_outlined,
                          color: PiixColors.mainText)),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: EdgeInsets.only(top: 5.h),
                      width: 20.w,
                      child: Container(
                        height: 7.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: notificationBLoC.ticketNotifications > 0
                              ? PiixColors.errorText
                              : Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
