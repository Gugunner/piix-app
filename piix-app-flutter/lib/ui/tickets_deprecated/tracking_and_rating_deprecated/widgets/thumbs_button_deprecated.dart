import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/providers/claim_ticket_provider.dart';
import 'package:piix_mobile/claim_ticket_feature/ui/tracking_and_rating_deprecated/ratings_screen_deprecated.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/model/ticket_model.dart';
import 'package:provider/provider.dart';

@Deprecated('No longer in use')

///A widget to show thumbs up and thumbs down buttons.
class ThumbsButtonDeprecated extends StatelessWidget {
  const ThumbsButtonDeprecated({Key? key, required this.ticket})
      : super(key: key);
  final TicketModel ticket;

  @override
  Widget build(BuildContext context) {
    final claimTicketProvider = context.watch<ClaimTicketProvider>();
    return Column(
      children: [
        ...claimTicketProvider.thumbs.map((thumbs) {
          return Column(
            children: [
              InkWell(
                splashColor: PiixColors.clearBlue.withOpacity(0.3),
                onTap: () {
                  claimTicketProvider.setSelectedThumbs(thumbs['status']);
                  if (claimTicketProvider.thumbsStatus ==
                      ThumbsStatus.thumbsUp) {
                    claimTicketProvider.selectedTicket = ticket;
                    Navigator.popAndPushNamed(
                        context, RatingsScreenDeprecated.routeName);
                  }
                },
                child: Container(
                  width: 192.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(
                        color: PiixColors.clearBlue,
                        width: 1.0,
                      ),
                      color: thumbs[ConstantsDeprecated.selectedKey]
                          ? PiixColors.clearBlue
                          : Colors.transparent),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 16.w,
                      ),
                      Icon(
                          thumbs[ConstantsDeprecated.statusKey] ==
                                  ThumbsStatus.thumbsUp
                              ? Icons.thumb_up_alt_outlined
                              : thumbs[ConstantsDeprecated.statusKey] ==
                                      ThumbsStatus.thumbsDown
                                  ? Icons.thumb_down_alt_outlined
                                  : null,
                          color: thumbs[ConstantsDeprecated.selectedKey]
                              ? PiixColors.white
                              : PiixColors.clearBlue),
                      SizedBox(width: 16.w),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          thumbs[ConstantsDeprecated.statusKey] ==
                                  ThumbsStatus.thumbsUp
                              ? PiixCopiesDeprecated.finishDone.toUpperCase()
                              : thumbs[ConstantsDeprecated.statusKey] ==
                                      ThumbsStatus.thumbsDown
                                  ? PiixCopiesDeprecated.haveAProblem
                                      .toUpperCase()
                                  : '',
                          style: thumbs[ConstantsDeprecated.selectedKey]
                              ? context.primaryTextTheme?.titleMedium?.copyWith(
                                  color: PiixColors.space,
                                )
                              : context.primaryTextTheme?.titleMedium?.copyWith(
                                  color: PiixColors.active,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
            ],
          );
        }).toList()
      ],
    );
  }
}
