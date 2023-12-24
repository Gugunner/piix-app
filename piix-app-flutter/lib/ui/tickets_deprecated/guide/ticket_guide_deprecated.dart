import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/ui/benefit_per_supplier_detail/existing_claim_ticket_buttons_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/providers/claim_ticket_provider.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:piix_mobile/ui/common/clamping_scale_deprecated.dart';
import 'package:piix_mobile/ui/tickets_deprecated/guide/widgets/membership_info.dart';
import 'package:piix_mobile/ui/tickets_deprecated/guide/widgets/step_deprecated.dart';
import 'package:piix_mobile/ui/tickets_deprecated/widgets_deprecated/claim_dialog_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget renders a Ticket guide
class TicketGuideDeprecated extends StatelessWidget {
  static const routeName = '/ticket_guide';
  const TicketGuideDeprecated({
    Key? key,
    required this.isBenefit,
  }) : super(key: key);
  final bool isBenefit;

  @override
  Widget build(BuildContext context) {
    final benefitPerSupplierBLoC =
        context.watch<BenefitPerSupplierBLoCDeprecated>();
    final userBLoC = context.watch<UserBLoCDeprecated>();
    final claimTicketProvider = context.watch<ClaimTicketProvider>();
    final user = userBLoC.user;
    final benefitPerSupplier =
        benefitPerSupplierBLoC.selectedAdditionalBenefitPerSupplier ??
            benefitPerSupplierBLoC.selectedCobenefitPerSupplier ??
            benefitPerSupplierBLoC.selectedBenefitPerSupplier;
    benefitPerSupplierBLoC.selectedBenefitPerSupplier;
    final benefitName = benefitPerSupplierBLoC.benefitName ?? '';
    final benefitImageMemory = benefitPerSupplier?.benefitImageMemory;
    final haveGuide = benefitPerSupplier?.benefit.haveGuide;
    final askGuide = benefitPerSupplier?.benefit.askGuide;
    final considerGuide = benefitPerSupplier?.benefit.considerGuide;
    final userHasBenefitForm = benefitPerSupplier?.hasBenefitForm ?? false;
    final userHasAlreadySignedTheBenefitForm =
        benefitPerSupplier?.userHasAlreadySignedTheBenefitForm ?? false;
    final ticket =
        benefitPerSupplier?.ticket ?? claimTicketProvider.selectedTicket;
    return ClampingScaleDeprecated(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(PiixCopiesDeprecated.requestLabel),
        ),
        body: SizedBox(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.0.w,
                    ),
                    child: Text(
                      PiixCopiesDeprecated.guideTicketTitle,
                      textAlign: TextAlign.center,
                      style: context.textTheme?.headlineMedium?.copyWith(
                        color: PiixColors.primary,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.0.w,
                    ),
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: '"${user?.displayName ?? ''}" '
                              '${PiixCopiesDeprecated.instuctionGuides} ',
                        ),
                        TextSpan(
                          text: '$benefitName ',
                          style: context.primaryTextTheme?.titleSmall,
                        ),
                        const TextSpan(
                          text: PiixCopiesDeprecated.should,
                        ),
                      ]),
                      textAlign: TextAlign.justify,
                      style: context.textTheme?.bodyMedium,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  PiixStepDeprecated(
                    numberStep: '1',
                    titleStep: PiixCopiesDeprecated.requestHave,
                    contentList: haveGuide ?? [],
                  ),
                  PiixStepDeprecated(
                    numberStep: '2',
                    titleStep: PiixCopiesDeprecated.requestAsk,
                    contentList: askGuide ?? [],
                  ),
                  PiixStepDeprecated(
                    numberStep: '3',
                    titleStep: PiixCopiesDeprecated.requestConsider,
                    contentList: considerGuide ?? [],
                    isVisible: false,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  const MembershipInfo(),
                  SizedBox(
                    height: 16.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                    child: Text(
                      PiixCopiesDeprecated.buttonGuideInstructions,
                      style: context.primaryTextTheme?.labelMedium?.copyWith(
                        color: PiixColors.warning,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (ticket != null)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.w,
                      ),
                      child: ExistingClaimTicketButtonsDeprecated(
                        isBenefit: isBenefit,
                      ),
                    )
                  else
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 16.h),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton(
                          onPressed: userHasBenefitForm &&
                                  !userHasAlreadySignedTheBenefitForm
                              ? null
                              : () {
                                  showDialog(
                                      context: context,
                                      builder: (_) => ClaimDialogDeprecated(
                                            fromHistory: false,
                                            isBenefit: isBenefit,
                                            name: benefitName,
                                            image: benefitImageMemory,
                                          ));
                                },
                          style: ElevatedButton.styleFrom(
                              disabledBackgroundColor: PiixColors.warning30,
                              backgroundColor: PiixColors.warning),
                          child: Text(
                            PiixCopiesDeprecated.startRequest.toUpperCase(),
                            style:
                                context.primaryTextTheme?.titleMedium?.copyWith(
                              color: PiixColors.space,
                            ),
                          )),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
