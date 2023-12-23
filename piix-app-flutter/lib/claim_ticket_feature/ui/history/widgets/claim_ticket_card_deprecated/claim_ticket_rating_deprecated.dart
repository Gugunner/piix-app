import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/claim_ticket_feature/ui/history/widgets/claim_ticket_card_deprecated/claim_ticket_ratings_tooltip_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/model/ticket_model.dart';
import 'package:piix_mobile/ui/common/piix_rating_bar_deprecated.dart';
import 'package:piix_mobile/ui/common/piix_tooltip_deprecated.dart';

@Deprecated('Will be removed in 4.0')
class ClaimTicketRatingDeprecated extends StatelessWidget {
  ClaimTicketRatingDeprecated({
    super.key,
    required this.ticket,
    this.benefitName,
  });

  final TicketModel ticket;
  final String? benefitName;
  final ratingsTooltipKey = GlobalKey();

  void _showTooltip(
    BuildContext context, {
    String? benefitName,
  }) {
    PiixTooltipDeprecated(
      offsetKey: ratingsTooltipKey,
      content: Container(
        padding: EdgeInsets.all(10.w),
        width: 240.w,
        child: ClaimTicketRatingsTooltipDeprecated(
          benefitName: benefitName,
          ticket: ticket,
        ),
      ),
    ).controller?.showTooltip();
  }

  @override
  Widget build(BuildContext context) {
    final supplierRating = ticket.rating?.supplierRating ?? 0.0;
    final benefitPerSupplierRating =
        ticket.rating?.benefitPerSupplierRating ?? 0.0;
    final generalRating = (supplierRating + benefitPerSupplierRating) / 2;

    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PiixRatingBarDeprecated(
            ratingValue: generalRating,
            itemSize: 20.w,
          ),
          SizedBox(width: 4.w),
          GestureDetector(
            onTap: () => _showTooltip(
              context,
              benefitName: benefitName,
            ),
            child: Icon(
              Icons.info_outline,
              key: ratingsTooltipKey,
              color: PiixColors.clearBlue,
            ),
          ),
        ],
      ),
    );
  }
}
