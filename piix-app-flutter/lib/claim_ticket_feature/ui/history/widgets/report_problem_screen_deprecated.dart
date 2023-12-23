import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/claim_ticket_feature/data/repository/claim_ticket_repository_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/providers/claim_ticket_provider.dart';
import 'package:piix_mobile/claim_ticket_feature/utils/claim_ticket_utils.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/ui_bloc.dart';
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
import 'package:piix_mobile/utils/shimmer/shimmer_barrel_file.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

/// Screen for reporting a problem dialog.
class ReportProblemScreenDeprecated extends StatefulWidget {
  const ReportProblemScreenDeprecated({
    Key? key,
    required this.ticket,
  }) : super(key: key);
  final TicketModel ticket;

  @override
  State<ReportProblemScreenDeprecated> createState() =>
      _ReportProblemScreenDeprecatedState();
}

class _ReportProblemScreenDeprecatedState
    extends State<ReportProblemScreenDeprecated> {
  late UiBLoC uiBLoC;
  late ClaimTicketProvider claimTicketProvider;
  TextEditingController reportCommentsController = TextEditingController();
  String get benefitName => widget.ticket.cobenefitName.isEmpty
      ? widget.ticket.benefitName
      : widget.ticket.cobenefitName;

  @override
  void initState() {
    reportCommentsController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    reportCommentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    claimTicketProvider = context.watch<ClaimTicketProvider>();
    uiBLoC = context.watch<UiBLoC>();

    final message = PiixCopiesDeprecated.startingReportProblem(
        getNameOfTicket(benefitName: benefitName));
    return Shimmer(
      child: ShimmerLoading(
        isLoading: claimTicketProvider.claimTicketState ==
            ClaimTicketStateDeprecated.retrieving,
        child: Padding(
          padding: EdgeInsets.all(24.h),
          child: SizedBox(
            child: Column(
              children: [
                ShimmerWrap(
                  child: Text(PiixCopiesDeprecated.areYouSureReportProblem,
                      textAlign: TextAlign.center,
                      style: context.textTheme?.headlineSmall?.copyWith(
                        color: PiixColors.primary,
                      )),
                ),
                SizedBox(height: 24.h),
                ShimmerWrap(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: context.textTheme?.bodyMedium,
                  ),
                ),
                SizedBox(height: 24.h),
                ShimmerWrap(
                  child: Text(PiixCopiesDeprecated.yourOpinionProblem,
                      style: context.primaryTextTheme?.titleMedium,
                      textAlign: TextAlign.center),
                ),
                SizedBox(height: 12.h),
                ShimmerWrap(
                  child: TextFormField(
                    style: context.textTheme?.bodyMedium,
                    controller: reportCommentsController,
                    maxLines: null,
                    decoration: InputDecoration(
                      floatingLabelStyle: context.titleSmall?.copyWith(
                        color: PiixColors.insurance,
                      ),
                      labelText: PiixCopiesDeprecated.problemComments,
                      helperText: PiixCopiesDeprecated.requiredField,
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerWrap(
                      child: TextButton(
                          onPressed: handleExit,
                          child: Text(PiixCopiesDeprecated.exit.toUpperCase(),
                              style: context.primaryTextTheme?.titleMedium
                                  ?.copyWith(
                                color: PiixColors.active,
                              ))),
                    ),
                    ShimmerWrap(
                      child: ElevatedButton(
                        onPressed: reportCommentsController.text.isNotEmpty
                            ? () => reportClaimTicket(context)
                            : null,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: PiixColors.clearBlue),
                        child: Text(
                          PiixCopiesDeprecated.okButton.toUpperCase(),
                          style: context.accentTextTheme?.labelMedium?.copyWith(
                            color: PiixColors.space,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void handleExit() {
    reportCommentsController.clear();
    NavigatorKeyState().getNavigator()?.pop();
  }

  void reportClaimTicket(BuildContext context) async {
    final ticketReported = await handleReportClaimTicket(
      context,
      ticketId: widget.ticket.ticketId,
      mounted: mounted,
      problemDescription: reportCommentsController.text,
    );
    final membership =
        context.read<MembershipProviderDeprecated>().selectedMembership;
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
    reportCommentsController.clear();
    const banner = PiixBannerContentDeprecated(
      title: PiixCopiesDeprecated.problemReceived,
      subtitle: PiixCopiesDeprecated.problemReceivedDescription,
      iconData: Icons.warning,
      cardBackgroundColor: PiixColors.tangerine,
    );
    PiixBannerDeprecated.instance.builder(
      context,
      children: banner.build(context),
    );
    Navigator.pop(context);
  }
}
