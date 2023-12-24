import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/data/repository/claim_ticket_repository_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/providers/claim_ticket_provider.dart';
import 'package:piix_mobile/claim_ticket_feature/utils/claim_ticket_utils.dart';
import 'package:piix_mobile/claim_ticket_feature/utils/claim_tickets_deprecated.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_banner_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_banner_content_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_events_constants.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_parameter_constants.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_values.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/model/ticket_model.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_barrel_file.dart';
import 'package:provider/provider.dart';

/// Screen for cancel a problem dialog.
class CancelClaimTicketScreen extends StatefulWidget {
  const CancelClaimTicketScreen({
    Key? key,
    required this.fromHistory,
    this.isBenefit = false,
  }) : super(key: key);
  final bool fromHistory;
  final bool isBenefit;

  @override
  State<CancelClaimTicketScreen> createState() =>
      _CancelClaimTicketScreenState();
}

class _CancelClaimTicketScreenState extends State<CancelClaimTicketScreen> {
  late ClaimTicketProvider claimTicketProvider;
  late BenefitPerSupplierBLoCDeprecated benefitPerSupplierBLoC;
  bool cancellingTicket = false;
  TextEditingController cancelCommentsController = TextEditingController();

  String get benefitName {
    if (benefitPerSupplierBLoC.benefitTicketName.isNotEmpty)
      return benefitPerSupplierBLoC.benefitTicketName;
    return claimTicketProvider.selectedTicket?.claimName ??
        PiixCopiesDeprecated.ticketFromSOS;
  }

  String get benefitTicketId {
    if (benefitPerSupplierBLoC
        .currentAdditionalCoBenefitPerSupplierId.isNotEmpty)
      return benefitPerSupplierBLoC.currentAdditionalCoBenefitPerSupplierId;
    return claimTicketProvider.selectedTicket?.benefitClaimId ??
        PiixCopiesDeprecated.ticketFromSOS;
  }

  String get supplierId {
    if (benefitPerSupplierBLoC.supplierId.isNotEmpty)
      return benefitPerSupplierBLoC.supplierId;
    return claimTicketProvider.selectedTicket?.supplierId ?? '';
  }

  String get supplierName {
    if (benefitPerSupplierBLoC.supplierName.isNotEmpty)
      return benefitPerSupplierBLoC.supplierName;
    return claimTicketProvider.selectedTicket?.supplierName ??
        PiixCopiesDeprecated.ticketFromSOS;
  }

  String get ticketId =>
      benefitPerSupplierBLoC
          .selectedAdditionalBenefitPerSupplier?.ticket?.ticketId ??
      benefitPerSupplierBLoC.selectedCobenefitPerSupplier?.ticket?.ticketId ??
      benefitPerSupplierBLoC.selectedBenefitPerSupplier?.ticket?.ticketId ??
      claimTicketProvider.selectedTicket?.ticketId ??
      '';

  bool get benefitClaim =>
      benefitTicketId.isNotEmpty &&
      benefitName.isNotEmpty &&
      supplierId.isNotEmpty &&
      supplierName.isNotEmpty;

  void handleExit() {
    cancelCommentsController.clear();
    NavigatorKeyState().getNavigator()?.pop();
  }

  void handleSuccessfulCancel() {
    final membership =
        context.read<MembershipProviderDeprecated>().selectedMembership;
    claimTicketProvider.setClaimTicketStatusLocal(
      ticketId: ticketId,
      status: TicketStatus.user_canceled,
    );
    final isSOS = claimTicketProvider.selectedTicket?.isSOS ?? false;
    final claimTicketType = getClaimTicketType(
      additionalBenefitPerSupplierId: benefitPerSupplierBLoC
              .additionalBenefitPerSupplierId ??
          claimTicketProvider.selectedTicket?.additionalBenefitPerSupplierId,
      cobenefitPerSupplierId: benefitPerSupplierBLoC.cobenefitPerSupplierId ??
          claimTicketProvider.selectedTicket?.cobenefitPerSupplierId,
      benefitPerSupplierId: benefitPerSupplierBLoC.benefitPerSupplierId ??
          claimTicketProvider.selectedTicket?.benefitPerSupplierId,
    );
    if (membership == null) return;
    final analyticsInstance = PiixAnalytics.instance;
    analyticsInstance.logEvent(
      eventName: PiixAnalyticsEvents.claimTicket,
      eventParameters: {
        PiixAnalyticsParameters.claimAction: PiixAnalyticsValues.cancelTicket,
        PiixAnalyticsParameters.claimTicketType: claimTicketType,
        if (benefitClaim || !isSOS) ...{
          PiixAnalyticsParameters.ticketBenefitId: benefitTicketId,
          PiixAnalyticsParameters.ticketBenefitName: benefitName,
          PiixAnalyticsParameters.supplierId: supplierId,
          PiixAnalyticsParameters.supplierName: supplierName,
        },
        PiixAnalyticsParameters.packageId: membership.package.id,
        PiixAnalyticsParameters.packageName: membership.package.name,
      },
    );
    claimTicketProvider.clearProvider();
    if (benefitClaim || !isSOS) {
      benefitPerSupplierBLoC
        ..setSelectedAdditionalBenefitPerSupplier(
          benefitPerSupplierBLoC.selectedAdditionalBenefitPerSupplier
              ?.setTicket(null),
        )
        ..setSelectedBenefitPerSupplier(
          benefitPerSupplierBLoC.selectedBenefitPerSupplier?.setTicket(null),
        )
        ..setSelectedCobenefitPerSupplier(
          benefitPerSupplierBLoC.selectedCobenefitPerSupplier?.setTicket(null),
        );
    }
    if (benefitPerSupplierBLoC.selectedBenefitPerSupplier == null ||
        benefitPerSupplierBLoC.selectedCobenefitPerSupplier == null) return;
    final newCobenefitPerSupplier =
        benefitPerSupplierBLoC.selectedCobenefitPerSupplier?.setTicket(null);
    if (newCobenefitPerSupplier == null) return;
    final newBenefitPerSupplier = benefitPerSupplierBLoC
        .selectedBenefitPerSupplier
        ?.setCobenefitPerSupplier(newCobenefitPerSupplier);
    benefitPerSupplierBLoC.setSelectedBenefitPerSupplier(newBenefitPerSupplier);
  }

  void handleCancelClaimTicket(BuildContext context) async {
    setState(() => cancellingTicket = true);
    await claimTicketProvider.cancelTicket(
      ticketId: ticketId,
      cancellationReason: cancelCommentsController.text,
    );
    final claimTicketState = claimTicketProvider.claimTicketState;
    setState(() => cancellingTicket = false);
    cancelCommentsController.clear();
    PiixBannerContentDeprecated? banner;
    if (claimTicketState.hasErrorState) {
      banner = const PiixBannerContentDeprecated(
        title: PiixCopiesDeprecated.appFailure,
        subtitle: PiixCopiesDeprecated.cancelClaimErrorMessage,
        iconData: Icons.error_outline,
        cardBackgroundColor: PiixColors.errorMain,
      );
    } else if (claimTicketState == ClaimTicketStateDeprecated.cancelled) {
      banner = PiixBannerContentDeprecated(
        title: PiixCopiesDeprecated.successCancellation,
        subtitle: PiixCopiesDeprecated.successCancellationDescription(
          benefitName,
        ),
        iconData: Icons.check_circle_outlined,
        cardBackgroundColor: PiixColors.successMain,
        height: 96.h,
        titleHeight: 48.h,
      );
      handleSuccessfulCancel();
    }
    NavigatorKeyState().getNavigator()?.pop();
    if (banner == null || !mounted) return;
    PiixBannerDeprecated.instance.builder(
      context,
      children: banner.build(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    claimTicketProvider = context.watch<ClaimTicketProvider>();
    benefitPerSupplierBLoC = context.watch<BenefitPerSupplierBLoCDeprecated>();
    return Shimmer(
      child: ShimmerLoading(
        isLoading: cancellingTicket,
        child: Padding(
          padding: EdgeInsets.all(24.h),
          child: Stack(
            children: [
              Column(
                children: [
                  ShimmerWrap(
                    child: Text(
                      PiixCopiesDeprecated.youWantToCancelAClaim(benefitName),
                      textAlign: TextAlign.center,
                      style: context.textTheme?.headlineSmall?.copyWith(
                        color: PiixColors.primary,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ShimmerWrap(
                    child: Text(
                      PiixCopiesDeprecated.cancelProblemMessage(
                        benefitName,
                      ),
                      textAlign: TextAlign.justify,
                      style: context.textTheme?.bodyMedium,
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  ShimmerWrap(
                    child: Text(
                      PiixCopiesDeprecated.yourOpinionMatters,
                      style: context.primaryTextTheme?.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    PiixCopiesDeprecated.sharedComments,
                    style: context.labelSmall?.copyWith(
                      fontSize: 12.sp,
                      color: PiixColors.twilightBlue,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  ShimmerWrap(
                    child: SizedBox(
                      height: 80.h,
                      child: TextFormField(
                        controller: cancelCommentsController,
                        expands: true,
                        style: context.labelSmall?.copyWith(
                          fontSize: 12.sp,
                          color: PiixColors.black,
                        ),
                        maxLines: null,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(
                            8,
                            12,
                            8,
                            12,
                          ),
                          isDense: false,
                          isCollapsed: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: const BorderSide(
                              width: 1.0,
                              color: PiixColors.twilightBlue,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: const BorderSide(
                              color: PiixColors.twilightBlue,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: const BorderSide(
                              color: PiixColors.twilightBlue,
                              width: 1.0,
                            ),
                          ),
                          floatingLabelStyle: context.titleSmall?.copyWith(
                            color: PiixColors.azure,
                          ),
                          labelText: '',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerWrap(
                      child: TextButton(
                        onPressed: handleExit,
                        style: Theme.of(context).textButtonTheme.style,
                        child: Text(
                          PiixCopiesDeprecated.exit.toUpperCase(),
                          style:
                              context.primaryTextTheme?.titleMedium?.copyWith(
                            color: PiixColors.active,
                          ),
                        ),
                      ),
                    ),
                    ShimmerWrap(
                      child: ElevatedButton(
                        onPressed: () => handleCancelClaimTicket(context),
                        style: Theme.of(context).elevatedButtonTheme.style,
                        child: Text(
                          PiixCopiesDeprecated.okButton.toUpperCase(),
                          style: context.accentTextTheme?.labelMedium?.copyWith(
                            color: PiixColors.space,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
