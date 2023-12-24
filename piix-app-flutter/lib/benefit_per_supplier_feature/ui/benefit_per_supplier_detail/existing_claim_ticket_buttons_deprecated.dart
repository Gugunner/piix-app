import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/providers/claim_ticket_provider.dart';
import 'package:piix_mobile/claim_ticket_feature/ui/history/claim_ticket_history_screen_builder_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/ui/history/widgets/cancel_claim_ticket_screen.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_wrap.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/ui/common/piix_fullscreen_dialog_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')
class ExistingClaimTicketButtonsDeprecated extends StatelessWidget {
  const ExistingClaimTicketButtonsDeprecated(
      {super.key, this.isBenefit = false});
  final bool isBenefit;

  @override
  Widget build(BuildContext context) {
    final benefitPerSupplierBLoC =
        context.watch<BenefitPerSupplierBLoCDeprecated>();
    final claimTicketProvider = context.watch<ClaimTicketProvider>();
    final ticket =
        benefitPerSupplierBLoC.selectedAdditionalBenefitPerSupplier?.ticket ??
            benefitPerSupplierBLoC.selectedCobenefitPerSupplier?.ticket ??
            benefitPerSupplierBLoC.selectedCobenefitPerSupplier?.ticket ??
            claimTicketProvider.selectedTicket;
    return Column(
      children: [
        ShimmerWrap(
          child: Text(
            PiixCopiesDeprecated.openRequest.toUpperCase(),
            style: context.accentTextTheme?.labelMedium?.copyWith(
              color: PiixColors.warning,
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShimmerWrap(
              child: SizedBox(
                height: 32.h,
                child: OutlinedButton(
                  onPressed: () {
                    claimTicketProvider.selectedTicket = ticket;
                    Navigator.push(
                      context,
                      PiixFullScreenDialogDeprecated(
                        child: CancelClaimTicketScreen(
                          fromHistory: false,
                          isBenefit: isBenefit,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    PiixCopiesDeprecated.cancelRequest,
                    style: context.accentTextTheme?.labelMedium?.copyWith(
                      color: PiixColors.active,
                    ),
                  ),
                ),
              ),
            ),
            ShimmerWrap(
              child: SizedBox(
                height: 32.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                        ClaimTicketHistoryScreenBuilderDeprecated.routeName);
                  },
                  child: Text(
                    PiixCopiesDeprecated.viewRequest,
                    style: context.accentTextTheme?.labelMedium?.copyWith(
                      color: PiixColors.space,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
      ],
    );
  }
}
