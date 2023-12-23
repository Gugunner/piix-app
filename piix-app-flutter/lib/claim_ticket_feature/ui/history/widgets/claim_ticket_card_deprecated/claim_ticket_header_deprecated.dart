import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/ui/benefit_per_supplier_detail/benefit_per_supplier_detail_screen_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/ui/history/widgets/claim_ticket_card_deprecated/claim_ticket_rating_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/utils/claim_ticket_utils.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/model/ticket_model.dart';
import 'package:piix_mobile/ui/common/piix_tag_store.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

/// Creates the header of the [TicketCard] widget that shows the general information of the ticket.
class ClaimTicketHeaderDeprecated extends StatelessWidget {
  const ClaimTicketHeaderDeprecated({
    Key? key,
    required this.ticket,
  }) : super(key: key);

  final TicketModel ticket;

  void _toBenefitPerSupplier(BuildContext context) {
    final membershipInfoBLoC = context.read<MembershipProviderDeprecated>();
    final benefitPerSupplierBLoC =
        context.read<BenefitPerSupplierBLoCDeprecated>();
    final benefitsPerSupplier =
        membershipInfoBLoC.selectedMembership?.benefitsPerSupplier ?? [];
    final currentTicketBenefitIndex = benefitsPerSupplier.indexWhere(
        (benefitPerSupplier) =>
            benefitPerSupplier.benefitPerSupplierId ==
            ticket.benefitPerSupplierId);
    if (currentTicketBenefitIndex < 0) return;
    final currentTicketBenefit = membershipInfoBLoC
        .selectedMembership?.benefitsPerSupplier[currentTicketBenefitIndex];
    benefitPerSupplierBLoC.setSelectedBenefitPerSupplier(currentTicketBenefit);
    Navigator.of(context).pushNamed(
      BenefitPerSupplierDetailScreenDeprecated.routeName,
      arguments: currentTicketBenefit,
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<MembershipProviderDeprecated>();
    final hasRatings = ticket.rating?.benefitPerSupplierRating != null &&
        ticket.rating?.supplierRating != null;
    final benefitName = ticket.cobenefitName.isEmpty
        ? ticket.benefitName
        : ticket.cobenefitName;
    return SizedBox(
      child: Row(
        crossAxisAlignment:
            hasRatings ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (hasRatings) ...[
                  ClaimTicketRatingDeprecated(
                    ticket: ticket,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                ],
                InkWell(
                  onTap: () => _toBenefitPerSupplier(context),
                  child: Text(
                    '${getNameOfTicket(benefitName: benefitName)} >>',
                    style: context.accentTextTheme?.headlineLarge?.copyWith(
                      color: PiixColors.active,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
            width: context.width * 0.25,
            child: PiixTagStoreDeprecated(
              isClaims: true,
              text: getTicketStatusName(status: ticket.status),
              backgroundColor: getTicketStatusColor(status: ticket.status),
            ),
          ),
        ],
      ),
    );
  }
}
