import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/claim_ticket_feature/data/repository/claim_ticket_repository_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/providers/claim_ticket_provider.dart';
import 'package:piix_mobile/claim_ticket_feature/utils/claim_ticket_utils.dart';
import 'package:piix_mobile/claim_ticket_feature/utils/claim_tickets_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/utils/decoration_util.dart';
import 'package:piix_mobile/utils/shimmer/shimmer.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_loading.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_wrap.dart';
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
import 'package:piix_mobile/ui/common/clamping_scale_deprecated.dart';
import 'package:piix_mobile/ui/tickets_deprecated/tracking_and_rating_deprecated/widgets/rating_question_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///A widget to show sos, benefit and supplier rating elements.
class RatingsScreenDeprecated extends StatefulWidget {
  static const routeName = '/ratings';
  const RatingsScreenDeprecated({Key? key}) : super(key: key);

  @override
  State<RatingsScreenDeprecated> createState() =>
      _RatingsScreenDeprecatedState();
}

class _RatingsScreenDeprecatedState extends State<RatingsScreenDeprecated> {
  late ClaimTicketProvider claimTicketProvider;
  TextEditingController ratingCommentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    claimTicketProvider = context.watch<ClaimTicketProvider>();
    final selectedTicket = claimTicketProvider.selectedTicket;
    if (selectedTicket == null) {
      return const SizedBox();
    }
    final isSOS = selectedTicket.isSOS;
    final claimName = selectedTicket.claimName;
    final generalRating = (selectedTicket.benefitRatingValue +
            selectedTicket.supplierRatingValue) /
        2;

    return WillPopScope(
      onWillPop: () => handlePopScreen(context),
      child: ClampingScaleDeprecated(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(PiixCopiesDeprecated.rateUs),
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Shimmer(
              child: ShimmerLoading(
                isLoading: claimTicketProvider.claimTicketState ==
                    ClaimTicketStateDeprecated.retrieving,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 16.h),
                        ShimmerWrap(
                          child: Text(
                            PiixCopiesDeprecated.applicationFinished,
                            textAlign: TextAlign.center,
                            style: context.textTheme?.headlineMedium?.copyWith(
                              color: PiixColors.primary,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Container(
                          width: context.width,
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          decoration: ratingCardDecoration,
                          child: Column(
                            children: [
                              SizedBox(height: 24.h),
                              RatingQuestionDeprecated(
                                question: isSOS
                                    ? PiixCopiesDeprecated
                                        .applicationRatingQuestion
                                    : PiixCopiesDeprecated
                                        .benefitRatingQuestion,
                                highlight: claimName.isEmpty
                                    ? PiixCopiesDeprecated.ticketFromSOS
                                    : claimName,
                                onRatingUpdate: (rating) => claimTicketProvider
                                    .updateBenefitClaimTicketRating(rating),
                              ),
                              if (!isSOS)
                                RatingQuestionDeprecated(
                                    question: PiixCopiesDeprecated
                                        .supplierRatingQuestion,
                                    highlight: selectedTicket.supplierName,
                                    onRatingUpdate: (rating) =>
                                        claimTicketProvider
                                            .updateSupplierClaimTicketRating(
                                                rating)),
                            ],
                          ),
                        ),
                        if (!isSOS) ...[
                          SizedBox(
                            height: 16.h,
                          ),
                          ShimmerWrap(
                            child: RatingQuestionDeprecated(
                              isGeneralRating: true,
                              ratingValue: generalRating,
                            ),
                          ),
                        ],
                        SizedBox(height: isSOS ? 48.h : 4.h),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.width * 0.08,
                          ),
                          child: Text(
                            isSOS
                                ? PiixCopiesDeprecated.sosComments
                                : PiixCopiesDeprecated.sharedComments,
                            maxLines: null,
                            style: context.textTheme?.bodyMedium?.copyWith(
                              color: PiixColors.primary,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        ShimmerWrap(
                          child: Container(
                            height: 80.h,
                            padding: EdgeInsets.symmetric(
                              horizontal: context.width * 0.08,
                            ),
                            child: TextFormField(
                              controller: ratingCommentController,
                              expands: true,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.fromLTRB(
                                  8,
                                  12,
                                  8,
                                  12,
                                ),
                                isDense: false,
                                isCollapsed: true,
                                labelText: '',
                                labelStyle: TextStyle(
                                  fontSize: 12.sp,
                                ),
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
                              ),
                              style: context.textTheme?.bodyMedium?.copyWith(
                                color: PiixColors.black,
                              ),
                              maxLines: null,
                            ),
                          ),
                        ),
                        SizedBox(height: isSOS ? 94.h : 12.h),
                        ShimmerWrap(
                          child: SizedBox(
                            width: context.width * 0.83,
                            height: 40.h,
                            child: ElevatedButton(
                              style:
                                  Theme.of(context).elevatedButtonTheme.style,
                              onPressed: claimTicketProvider.enabledButton()
                                  ? () => handleCloseClaimTicket(context)
                                  : null,
                              child: Text(
                                PiixCopiesDeprecated.sendText.toUpperCase(),
                                style: context.primaryTextTheme?.titleMedium
                                    ?.copyWith(
                                  color: PiixColors.space,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> handlePopScreen(BuildContext context) async {
    final claimTicketProvider = context.read<ClaimTicketProvider>();
    claimTicketProvider.clearClaimTicketRatings();
    if (PiixBannerDeprecated.instance.entry != null) {
      PiixBannerDeprecated.instance.removeEntry();
    }
    return true;
  }

  void handleCloseClaimTicket(BuildContext context) async {
    final membership =
        context.read<MembershipProviderDeprecated>().selectedMembership;
    await claimTicketProvider.closeTicket(
      ticketId: claimTicketProvider.selectedTicket?.ticketId ?? '',
      supplierRating: claimTicketProvider.selectedTicket?.supplierRatingValue,
      benefitPerSupplierRating:
          claimTicketProvider.selectedTicket?.benefitRatingValue,
      comments: ratingCommentController.text,
    );
    final claimTicketState = claimTicketProvider.claimTicketState;
    PiixBannerContentDeprecated? banner;
    if (claimTicketState.hasErrorState) {
      banner = ClaimTicketsBannersDeprecated.errorCloseBanner;
    } else if (claimTicketState == ClaimTicketStateDeprecated.closed) {
      banner = ClaimTicketsBannersDeprecated.ticketCloseBanner;
      claimTicketProvider.setClaimTicketStatusLocal(
        ticketId: claimTicketProvider.selectedTicket?.ticketId ?? '',
        status: TicketStatus.user_closed,
        benefitPerSupplierRating:
            claimTicketProvider.selectedTicket?.benefitRatingValue,
        supplierRating: claimTicketProvider.selectedTicket?.supplierRatingValue,
      );
      final isSOS = claimTicketProvider.selectedTicket?.isSOS ?? false;
      final claimTicketType = getClaimTicketType(
        additionalBenefitPerSupplierId:
            claimTicketProvider.selectedTicket?.additionalBenefitPerSupplierId,
        cobenefitPerSupplierId:
            claimTicketProvider.selectedTicket?.cobenefitPerSupplierId,
        benefitPerSupplierId:
            claimTicketProvider.selectedTicket?.benefitPerSupplierId,
      );
      if (membership == null) return;
      final analyticsInstance = PiixAnalytics.instance;
      analyticsInstance.logEvent(
        eventName: PiixAnalyticsEvents.claimTicket,
        eventParameters: {
          PiixAnalyticsParameters.claimAction: PiixAnalyticsValues.closeTicket,
          PiixAnalyticsParameters.claimTicketType: claimTicketType,
          if (!isSOS) ...{
            PiixAnalyticsParameters.ticketBenefitId:
                claimTicketProvider.selectedTicket?.benefitClaimId,
            PiixAnalyticsParameters.ticketBenefitName:
                claimTicketProvider.selectedTicket?.currentBenefitName,
            PiixAnalyticsParameters.supplierId:
                claimTicketProvider.selectedTicket?.supplierId,
            PiixAnalyticsParameters.supplierName:
                claimTicketProvider.selectedTicket?.supplierName,
            if (claimTicketProvider.selectedTicket?.supplierRatingValue != null)
              PiixAnalyticsParameters.supplierRating:
                  claimTicketProvider.selectedTicket?.supplierRatingValue,
          },
          if (claimTicketProvider.selectedTicket?.benefitRatingValue != null)
            PiixAnalyticsParameters.benefitPerSupplierRating:
                claimTicketProvider.selectedTicket?.benefitRatingValue,
          PiixAnalyticsParameters.packageId: membership.package.id,
          PiixAnalyticsParameters.packageName: membership.package.name,
        },
      );
    }
    ratingCommentController.clear();
    if (banner == null || !mounted) return;
    PiixBannerDeprecated.instance.builder(
      context,
      children: banner.build(context),
    );
    Navigator.pop(context);
  }
}
