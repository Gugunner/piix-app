import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/providers/claim_ticket_provider.dart';
import 'package:piix_mobile/claim_ticket_feature/utils/claim_ticket_utils.dart';
import 'package:piix_mobile/claim_ticket_feature/utils/claim_tickets_deprecated.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/ui_bloc.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_banner_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_events_constants.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_parameter_constants.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_values.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/ui/common/piix_confirm_alert_deprecated.dart';
import 'package:provider/provider.dart';

///This dialog contains phone and whatsapp create claim buttons
///
class ClaimBenefitDialog extends StatefulWidget {
  const ClaimBenefitDialog({
    super.key,
    this.isPhoneClaim = true,
    this.fromHistory = false,
    this.isBenefit = true,
  });
  final bool isPhoneClaim;
  final bool fromHistory;
  final bool isBenefit;

  @override
  State<ClaimBenefitDialog> createState() => _ClaimBenefitDialogState();
}

class _ClaimBenefitDialogState extends State<ClaimBenefitDialog> {
  var loadingClaim = false;
  late MembershipProviderDeprecated membershipBLoC;
  late UiBLoC uiBLoC;
  late ClaimTicketProvider claimTicketProvider;
  late BenefitPerSupplierBLoCDeprecated benefitPerSupplierBLoC;
  String get claimType => widget.isPhoneClaim
      ? PiixCopiesDeprecated.phoneRequest
      : PiixCopiesDeprecated.whatsAppRequest;

  @override
  void dispose() {
    final instance = PiixBannerDeprecated.instance;
    if (instance.entry != null) {
      instance.removeEntry();
    }
    super.dispose();
  }

  String? get additionalBenefitPerSupplierId {
    if (benefitPerSupplierBLoC.additionalBenefitPerSupplierId.isNotNullEmpty)
      return benefitPerSupplierBLoC.additionalBenefitPerSupplierId;
    if (claimTicketProvider.selectedTicket != null &&
        claimTicketProvider
            .selectedTicket!.additionalBenefitPerSupplierId.isNotEmpty)
      return claimTicketProvider.selectedTicket?.additionalBenefitPerSupplierId;
    return null;
  }

  String? get cobenefitPerSupplierId {
    if (benefitPerSupplierBLoC.cobenefitPerSupplierId.isNotNullEmpty)
      return benefitPerSupplierBLoC.cobenefitPerSupplierId;
    if (claimTicketProvider.selectedTicket != null &&
        claimTicketProvider.selectedTicket!.cobenefitPerSupplierId.isNotEmpty)
      return claimTicketProvider.selectedTicket?.cobenefitPerSupplierId;
    return null;
  }

  String? get benefitPerSupplierId {
    if (benefitPerSupplierBLoC.benefitPerSupplierId.isNotNullEmpty)
      return benefitPerSupplierBLoC.benefitPerSupplierId;
    if (claimTicketProvider.selectedTicket != null &&
        claimTicketProvider.selectedTicket!.benefitPerSupplierId.isNotEmpty)
      return claimTicketProvider.selectedTicket?.benefitPerSupplierId;
    return null;
  }

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

  @override
  Widget build(BuildContext context) {
    membershipBLoC = context.watch<MembershipProviderDeprecated>();
    claimTicketProvider = context.watch<ClaimTicketProvider>();
    benefitPerSupplierBLoC = context.watch<BenefitPerSupplierBLoCDeprecated>();
    uiBLoC = context.watch<UiBLoC>();
    return PiixConfirmAlertDialogDeprecated(
      hasLoader: loadingClaim,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${PiixCopiesDeprecated.youGoingToStartProcess} $claimType '
            '${PiixCopiesDeprecated.forBenefitName(benefitName)} '
            '${PiixCopiesDeprecated.willActivateSystemMonitoring}',
            style: context.textTheme?.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 12.h,
          ),
          if (!widget.isPhoneClaim)
            Text(
              PiixCopiesDeprecated.acceptStartClaimText,
              style: context.primaryTextTheme?.labelMedium?.copyWith(
                color: PiixColors.process,
              ),
              textAlign: TextAlign.justify,
            )
        ],
      ),
      title: PiixCopiesDeprecated.areYouSureStartClaim,
      onConfirm: handleBenefitClaimTicket,
    );
  }

  void handleBenefitClaimTicket() async {
    setState(() => loadingClaim = true);
    uiBLoC.loadText = PiixCopiesDeprecated.reOpeniningTicket;
    final ticketCreated = await handleCreateClaimTicket(
      context,
      mounted: mounted,
      additionalBenefitPerSupplierId: additionalBenefitPerSupplierId,
      cobenefitPerSupplierId: cobenefitPerSupplierId,
      benefitPerSupplierId: benefitPerSupplierId,
    );
    setState(() => loadingClaim = false);
    final membership = membershipBLoC.selectedMembership;
    if (!ticketCreated || membership == null) return;
    final successfulLaunch = await handleLaunchUrl(
      context,
      selectedTicket: claimTicketProvider.selectedTicket,
      claimAction: PiixAnalyticsValues.createTicket,
      packageId: membership.package.id,
      packageName: membership.package.name,
      mounted: mounted,
      benefitName: benefitName,
      phoneClaim: widget.isPhoneClaim,
    );
    if (!successfulLaunch) return;

    if (!mounted) return;

    if (claimTicketProvider.selectedTicket == null) return;
    final claimTicketType = getClaimTicketType(
      additionalBenefitPerSupplierId:
          benefitPerSupplierBLoC.additionalBenefitPerSupplierId,
      cobenefitPerSupplierId: benefitPerSupplierBLoC.cobenefitPerSupplierId,
      benefitPerSupplierId: benefitPerSupplierBLoC.benefitPerSupplierId,
    );
    final analyticsInstance = PiixAnalytics.instance;
    analyticsInstance.logEvent(
      eventName: PiixAnalyticsEvents.claimTicket,
      eventParameters: {
        PiixAnalyticsParameters.claimAction: PiixAnalyticsValues.createTicket,
        PiixAnalyticsParameters.claimTicketType: claimTicketType,
        PiixAnalyticsParameters.ticketBenefitId: benefitTicketId,
        PiixAnalyticsParameters.ticketBenefitName: benefitName,
        PiixAnalyticsParameters.supplierId: supplierId,
        PiixAnalyticsParameters.supplierName: supplierName,
        PiixAnalyticsParameters.packageId: membership.package.id,
        PiixAnalyticsParameters.packageName: membership.package.name,
        PiixAnalyticsParameters.supportChannel: widget.isPhoneClaim
            ? PiixAnalyticsValues.phone
            : PiixAnalyticsValues.whatsapp,
      },
    );
    const banner = ClaimTicketsBannersDeprecated.ticketInProcessBanner;
    PiixBannerDeprecated.instance.builder(
      context,
      children: banner.build(context),
    );
  }
}
