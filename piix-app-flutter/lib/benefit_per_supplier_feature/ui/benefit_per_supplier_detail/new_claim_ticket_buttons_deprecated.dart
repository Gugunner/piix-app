import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_wrap.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/ui/tickets_deprecated/guide/ticket_guide_deprecated.dart';
import 'package:piix_mobile/ui/tickets_deprecated/widgets_deprecated/claim_dialog_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')
class NewClaimTicketButtonsDeprecated extends StatelessWidget {
  const NewClaimTicketButtonsDeprecated({super.key, this.isBenefit = false});
  final bool isBenefit;

  @override
  Widget build(BuildContext context) {
    final benefitPerSupplierBLoC =
        context.watch<BenefitPerSupplierBLoCDeprecated>();
    final membershipBLoC = context.watch<MembershipProviderDeprecated>();
    final benefitPerSupplier =
        benefitPerSupplierBLoC.selectedBenefitPerSupplier;
    final cobenefitPerSupplier =
        benefitPerSupplierBLoC.selectedCobenefitPerSupplier;
    final additionalBenefitPerSupplier =
        benefitPerSupplierBLoC.selectedAdditionalBenefitPerSupplier;
    final claimName = benefitPerSupplierBLoC.additionalBenefitName ??
        benefitPerSupplierBLoC.cobenefitName ??
        benefitPerSupplierBLoC.benefitName ??
        '';
    final claimImage = additionalBenefitPerSupplier?.benefitImageMemory ??
        cobenefitPerSupplier?.benefitImageMemory ??
        benefitPerSupplier?.benefitImageMemory;
    final userHasBenefitForm = isBenefit
        ? additionalBenefitPerSupplier?.hasBenefitForm ??
            benefitPerSupplier?.hasBenefitForm ??
            false
        : cobenefitPerSupplier?.hasBenefitForm ?? false;
    final userHasAlreadySignedTheBenefitForm = isBenefit
        ? additionalBenefitPerSupplier?.userHasAlreadySignedTheBenefitForm ??
            benefitPerSupplier?.userHasAlreadySignedTheBenefitForm ??
            false
        : cobenefitPerSupplier?.userHasAlreadySignedTheBenefitForm ?? false;

    return Column(
      children: [
        ShimmerWrap(
          child: SizedBox(
            height: 33.h,
            child: ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(10),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled))
                    return PiixColors.inactiveTangerine;
                  return PiixColors.warning;
                }),
                foregroundColor: MaterialStateProperty.all(PiixColors.white),
                visualDensity: VisualDensity.compact,
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(
                    horizontal: 32.w,
                  ),
                ),
              ),
              onPressed: !membershipBLoC.isActiveMembership ||
                      (userHasBenefitForm &&
                          !userHasAlreadySignedTheBenefitForm)
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TicketGuideDeprecated(
                            isBenefit: isBenefit,
                          ),
                        ),
                      );
                    },
              child: FittedBox(
                child: Text(
                  PiixCopiesDeprecated.requestBenefitGuide.toUpperCase(),
                  style: context.accentTextTheme?.labelMedium?.copyWith(
                    color: PiixColors.space,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        ShimmerWrap(
          color: Colors.transparent,
          child: TextButton(
            style: Theme.of(context).textButtonTheme.style?.copyWith(
                  textStyle: MaterialStatePropertyAll(
                    context.accentTextTheme?.headlineLarge?.copyWith(
                      color: PiixColors.active,
                    ),
                  ),
                ),
            onPressed: !membershipBLoC.isActiveMembership ||
                    (userHasBenefitForm && !userHasAlreadySignedTheBenefitForm)
                ? null
                : () => showDialog(
                      context: context,
                      builder: (_) => ClaimDialogDeprecated(
                        fromHistory: false,
                        isBenefit: isBenefit,
                        name: claimName,
                        image: claimImage,
                      ),
                    ),
            child: const Text(
              PiixCopiesDeprecated.startRequest,
            ),
          ),
        ),
      ],
    );
  }
}
