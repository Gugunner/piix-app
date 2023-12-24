import 'package:flutter/material.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/data/repository/benefit_per_supplier_repository.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/ui/benefit_per_supplier_detail/existing_claim_ticket_buttons_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/ui/benefit_per_supplier_detail/new_claim_ticket_buttons_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/providers/claim_ticket_provider.dart';
import 'package:piix_mobile/utils/shimmer/shimmer.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_loading.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/bloc/protected_provider.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget shows a claim buttons.
class ClaimColumnButtonsDeprecated extends StatelessWidget {
  const ClaimColumnButtonsDeprecated({Key? key, required this.isBenefit})
      : super(key: key);
  final bool isBenefit;

  @override
  Widget build(BuildContext context) {
    final benefitPerSupplierBLoC =
        context.watch<BenefitPerSupplierBLoCDeprecated>();
    final claimTicketProvider = context.watch<ClaimTicketProvider>();
    final protectedProvider = context.watch<ProtectedProvider>();
    final benefitPerSupplier =
        benefitPerSupplierBLoC.selectedCobenefitPerSupplier ??
            benefitPerSupplierBLoC.selectedBenefitPerSupplier;
    final ticket =
        benefitPerSupplier?.ticket ?? claimTicketProvider.selectedTicket;
    final isProtected = protectedProvider.selectedProtected != null;
    if (isProtected) return const SizedBox();
    final hasClaimTicket = ticket != null && !isProtected;
    return Shimmer(
      child: ShimmerLoading(
        isLoading: benefitPerSupplierBLoC.benefitPerSupplierState ==
            BenefitPerSupplierStateDeprecated.retrieving,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: double.infinity,
            ),
            if (hasClaimTicket)
              ExistingClaimTicketButtonsDeprecated(
                isBenefit: isBenefit,
              )
            else
              NewClaimTicketButtonsDeprecated(
                isBenefit: isBenefit,
              )
          ],
        ),
      ),
    );
  }
}
