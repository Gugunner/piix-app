import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/model/ticket_model.dart';
import 'package:piix_mobile/ui/common/piix_rating_bar_deprecated.dart';

@Deprecated('Will be removed in 4.0')
class ClaimTicketRatingsTooltipDeprecated extends StatelessWidget {
  const ClaimTicketRatingsTooltipDeprecated({
    Key? key,
    required this.ticket,
    this.benefitName,
  }) : super(key: key);

  final TicketModel ticket;
  final String? benefitName;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          PiixCopiesDeprecated.benefitQualification(benefitName ?? ''),
          style: context.bodySmall?.copyWith(
            color: PiixColors.white,
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        PiixRatingBarDeprecated(
          ratingValue: ticket.rating?.benefitPerSupplierRating ?? 0,
          itemSize: 20.w,
        ),
        SizedBox(
          height: 4.h,
        ),
        Text(
          PiixCopiesDeprecated.supplierQualification(ticket.supplierName),
          style: context.bodySmall?.copyWith(
            color: PiixColors.white,
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        PiixRatingBarDeprecated(
          ratingValue: ticket.rating?.supplierRating ?? 0,
          itemSize: 20.w,
        ),
      ],
    );
  }
}
