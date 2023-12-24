import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/providers/claim_ticket_provider.dart';
import 'package:piix_mobile/claim_ticket_feature/utils/claim_ticket_utils.dart';
import 'package:piix_mobile/claim_ticket_feature/utils/claim_tickets_deprecated.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/ui_bloc.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_banner_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_events_constants.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_parameter_constants.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_values.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/ui/common/piix_confirm_alert_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('No longer in use in 4.0')
class ClaimSosDialogDeprecated extends StatefulWidget {
  const ClaimSosDialogDeprecated({super.key, this.isPhoneClaim = true});
  final bool isPhoneClaim;

  @override
  State<ClaimSosDialogDeprecated> createState() =>
      _ClaimSosDialogDeprecatedState();
}

class _ClaimSosDialogDeprecatedState extends State<ClaimSosDialogDeprecated> {
  var loadingClaim = false;
  late MembershipProviderDeprecated membershipInfoBLoC;
  late UiBLoC uiBLoC;
  late ClaimTicketProvider claimTicketProvider;

  String get claimType => widget.isPhoneClaim
      ? PiixCopiesDeprecated.phoneRequest
      : PiixCopiesDeprecated.whatsAppRequest;

  @override
  Widget build(BuildContext context) {
    membershipInfoBLoC = context.watch<MembershipProviderDeprecated>();
    claimTicketProvider = context.watch<ClaimTicketProvider>();
    uiBLoC = context.watch<UiBLoC>();

    return PiixConfirmAlertDialogDeprecated(
      title: PiixCopiesDeprecated.areYouSureStartClaim,
      hasLoader: loadingClaim,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${PiixCopiesDeprecated.youGoingToStartProcess} $claimType. '
            '${PiixCopiesDeprecated.willActivateSystemMonitoring}',
            style: context.textTheme?.bodyMedium,
            textAlign: TextAlign.center,
          ),
          if (!widget.isPhoneClaim) ...[
            SizedBox(height: 12.h),
            Text(PiixCopiesDeprecated.acceptStartClaimText,
                style: context.primaryTextTheme?.labelMedium?.copyWith(
                  color: PiixColors.process,
                ),
                textAlign: TextAlign.center)
          ],
        ],
      ),
      onConfirm: handleSOSClaimCreateTicket,
    );
  }

  void handleSOSClaimCreateTicket() async {
    setState(() => loadingClaim = true);
    uiBLoC.loadText = PiixCopiesDeprecated.reOpeniningTicket;
    final ticketCreated = await handleCreateClaimTicket(
      context,
      mounted: mounted,
      sosClaim: true,
    );
    setState(() => loadingClaim = false);
    final membership = membershipInfoBLoC.selectedMembership;
    if (!ticketCreated || membership == null) return;
    final successfulLaunch = await handleLaunchUrl(
      context,
      selectedTicket: claimTicketProvider.selectedTicket,
      claimAction: PiixAnalyticsValues.createTicket,
      packageId: membership.package.id,
      packageName: membership.package.name,
      mounted: mounted,
      phoneClaim: widget.isPhoneClaim,
    );
    if (!successfulLaunch) return;
    const banner = ClaimTicketsBannersDeprecated.ticketInProcessBanner;
    if (!mounted) return;
    PiixBannerDeprecated.instance.builder(
      context,
      children: banner.build(context),
    );
    if (claimTicketProvider.selectedTicket == null) return;
    final analyticsInstance = PiixAnalytics.instance;
    analyticsInstance.logEvent(
      eventName: PiixAnalyticsEvents.claimTicket,
      eventParameters: {
        PiixAnalyticsParameters.claimAction: PiixAnalyticsValues.createTicket,
        PiixAnalyticsParameters.claimTicketType: PiixAnalyticsValues.sos,
        PiixAnalyticsParameters.packageId: membership.package.id,
        PiixAnalyticsParameters.packageName: membership.package.name,
        PiixAnalyticsParameters.supportChannel: widget.isPhoneClaim
            ? PiixAnalyticsValues.phone
            : PiixAnalyticsValues.whatsapp,
      },
    );
  }
}
