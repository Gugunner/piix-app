import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/providers/claim_ticket_provider.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/ui_bloc.dart';
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
import 'package:piix_mobile/claim_ticket_feature/utils/claim_ticket_utils.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/model/ticket_model.dart';
import 'package:provider/provider.dart';

@Deprecated('No longer in use')

///This screen is used to render a report tracking ticket form.
class ReportTrackingFormDeprecated extends StatefulWidget {
  const ReportTrackingFormDeprecated({
    super.key,
    required this.ticket,
  });
  final TicketModel ticket;

  @override
  State<ReportTrackingFormDeprecated> createState() =>
      _ReportTrackingFormDeprecatedState();
}

class _ReportTrackingFormDeprecatedState
    extends State<ReportTrackingFormDeprecated> {
  late UiBLoC uiBLoC;
  late ClaimTicketProvider claimTicketProvider;
  late MembershipProviderDeprecated membershipBLoC;
  TextEditingController reportTrackingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    claimTicketProvider = context.watch<ClaimTicketProvider>();
    uiBLoC = context.watch<UiBLoC>();
    membershipBLoC = context.watch<MembershipProviderDeprecated>();
    return Column(children: [
      if (claimTicketProvider.thumbsStatus == ThumbsStatus.thumbsDown)
        Padding(
          padding: EdgeInsets.only(
              left: context.width * 0.081,
              right: context.width * 0.081,
              bottom: 30.h),
          child: TextFormField(
            controller: reportTrackingController,
            decoration: InputDecoration(
              labelText: PiixCopiesDeprecated.sharedComments,
              labelStyle: context.labelSmall?.copyWith(
                color: PiixColors.mainText,
              ),
              border: const UnderlineInputBorder(),
            ),
            style: context.labelSmall?.copyWith(
              color: PiixColors.mainText,
            ),
            maxLines: null,
          ),
        ),
      if (claimTicketProvider.thumbsStatus == ThumbsStatus.thumbsDown)
        SizedBox(
          width: context.width * 0.83,
          height: 40.h,
          child: ElevatedButton(
            onPressed: claimTicketProvider.thumbs.firstWhere((element) =>
                    element['status'] == ThumbsStatus.thumbsDown)['selected']
                ? reportClaimTicket
                : null,
            child: Text(
              PiixCopiesDeprecated.sendText.toUpperCase(),
            ),
          ),
        )
    ]);
  }

  void reportClaimTicket() async {
    uiBLoC
      ..isLoading = true
      ..loadText = PiixCopiesDeprecated.reportingTicket;
    final ticketReported = await handleReportClaimTicket(
      context,
      ticketId: widget.ticket.ticketId,
      mounted: mounted,
      problemDescription: reportTrackingController.text,
    );
    uiBLoC.isLoading = false;
    final membership = membershipBLoC.selectedMembership;
    if (!ticketReported || membership == null) return;
    final isSOS = widget.ticket.isSOS;
    final claimTicketType = getClaimTicketType(
      additionalBenefitPerSupplierId:
          widget.ticket.additionalBenefitPerSupplierId,
      cobenefitPerSupplierId: widget.ticket.cobenefitPerSupplierId,
      benefitPerSupplierId: widget.ticket.benefitPerSupplierId,
    );
    final analyticsInstance = PiixAnalytics.instance;
    analyticsInstance.logEvent(
      eventName: PiixAnalyticsEvents.claimTicket,
      eventParameters: {
        PiixAnalyticsParameters.claimAction: PiixAnalyticsValues.followUpTicket,
        PiixAnalyticsParameters.claimTicketType: claimTicketType,
        if (!isSOS) ...{
          PiixAnalyticsParameters.ticketBenefitId: widget.ticket.benefitClaimId,
          PiixAnalyticsParameters.ticketBenefitName:
              widget.ticket.currentBenefitName,
          PiixAnalyticsParameters.supplierId: widget.ticket.supplierId,
          PiixAnalyticsParameters.supplierName: widget.ticket.supplierName,
        },
        PiixAnalyticsParameters.packageId: membership.package.id,
        PiixAnalyticsParameters.packageName: membership.package.name,
      },
    );
    if (!mounted) return;
    claimTicketProvider.setClaimTicketStatusLocal(
      ticketId: widget.ticket.ticketId,
      status: TicketStatus.user_support,
    );
    const banner = PiixBannerContentDeprecated(
      title: PiixCopiesDeprecated.problemReceived,
      subtitle: PiixCopiesDeprecated.problemReceivedDescription,
      iconData: Icons.warning,
      cardBackgroundColor: PiixColors.tangerine,
    );
    reportTrackingController.clear();
    PiixBannerDeprecated.instance.builder(
      context,
      children: banner.build(context),
    );
    Navigator.pop(context);
  }
}
