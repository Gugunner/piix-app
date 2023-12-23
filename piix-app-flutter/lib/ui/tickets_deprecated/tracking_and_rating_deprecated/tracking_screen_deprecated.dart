import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/providers/claim_ticket_provider.dart';
import 'package:piix_mobile/claim_ticket_feature/ui/history/widgets/cancel_tracking_button_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/ui/history/widgets/report_tracking_form_deprecated.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/home_provider.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/ui/membership_type_builder_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/model/ticket_model.dart';
import 'package:piix_mobile/ui/common/clamping_scale_deprecated.dart';
import 'package:piix_mobile/ui/common/piix_confirm_alert_deprecated.dart';
import 'package:piix_mobile/ui/common/piix_full_loader_deprecated.dart';
import 'package:piix_mobile/ui/tickets_deprecated/tracking_and_rating_deprecated/widgets/thumbs_button_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Use instead RequestScreen')

///A widget to show a tracking quiz for a benefit or SOS claim.
class TrackingScreenDeprecated extends StatefulWidget {
  static const routeName = '/tracking';
  const TrackingScreenDeprecated({Key? key, required this.ticket})
      : super(key: key);
  final TicketModel ticket;

  @override
  State<TrackingScreenDeprecated> createState() =>
      _TrackingScreenDeprecatedState();
}

class _TrackingScreenDeprecatedState extends State<TrackingScreenDeprecated> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final claimTicketProvider = context.read<ClaimTicketProvider>();
      claimTicketProvider.thumbsStatus = ThumbsStatus.thumbsNone;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();
    final isSOS = widget.ticket.isSOS;
    final isLoading = homeProvider.homeState == HomeStateDeprecated.idle ||
        homeProvider.homeState == HomeStateDeprecated.loading;

    final benefitName = widget.ticket.cobenefitName.isEmpty
        ? widget.ticket.benefitName
        : widget.ticket.cobenefitName;

    return ClampingScaleDeprecated(
      child: Scaffold(
        appBar: isLoading
            ? null
            : AppBar(
                title: const Text(PiixCopiesDeprecated.tellUs),
                automaticallyImplyLeading: false,
              ),
        body: WillPopScope(
          onWillPop: () async => false,
          child: Builder(builder: (context) {
            if (isLoading) {
              return const PiixFullLoaderDeprecated(
                loadText: PiixCopiesDeprecated.gettingTicketHistory,
              );
            }
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text.rich(
                      TextSpan(
                        text: ('${PiixCopiesDeprecated.aboutApplication} \n'
                            '$benefitName'
                            '${isSOS ? ',\n' : PiixCopiesDeprecated.ofBenefitAplication}'
                            '${PiixCopiesDeprecated.withNumber}\n'
                            '${widget.ticket.ticketId}'),
                        children: [
                          TextSpan(
                            text: isSOS ? '' : widget.ticket.benefitName,
                            style: context.titleLarge?.copyWith(
                              color: PiixColors.twilightBlue,
                              height: 18.sp / 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(
                              text: PiixCopiesDeprecated.selectOption),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: context.headlineMedium?.copyWith(
                        color: PiixColors.twilightBlue,
                        height: 16.sp / 16.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    ThumbsButtonDeprecated(
                      ticket: widget.ticket,
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      width: 131.w,
                      child: TextButton(
                        onPressed: handleOpenDialog,
                        child: Text(
                            PiixCopiesDeprecated.stillApplicationProcess,
                            textAlign: TextAlign.center,
                            style: context.headlineSmall?.copyWith(
                                color: PiixColors.clearBlue,
                                height: 12.sp / 12.sp)),
                      ),
                    ),
                    SizedBox(height: 50.h),
                    ReportTrackingFormDeprecated(ticket: widget.ticket),
                    CancelTrackingButtonDeprecated(
                      ticket: widget.ticket,
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  void handleOpenDialog() => showDialog<void>(
        context: context,
        builder: (_) => PiixConfirmAlertDialogDeprecated(
          title: PiixCopiesDeprecated.youWantContinueTo,
          message: PiixCopiesDeprecated.continueToMessage,
          cancelText: PiixCopiesDeprecated.exit,
          onConfirm: () => NavigatorKeyState().getNavigator()?.popUntil(
                ModalRoute.withName(MembershipTypeBuilderDeprecated.routeName),
              ),
        ),
      );
}
