import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/auth_feature/domain/model/user_app_model.dart';
import 'package:piix_mobile/claim_ticket_feature/data/repository/claim_ticket_repository_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/providers/claim_ticket_provider.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/catalog_bloc.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/home_provider.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/notification_bloc.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_events_constants.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_parameter_constants.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_values.dart';
import 'package:piix_mobile/general_app_feature/utils/route_utils.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/membership_info_repository_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_alert_ui_provider.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_ui_state.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/membership_screen_data.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/piix_app_bar_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/utils/membership_notification.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/bloc_deprecated/purchase_invoice_bloc_deprecated.dart';
import 'package:piix_mobile/ui/common/clamping_scale_deprecated.dart';
import 'package:piix_mobile/ui/tickets_deprecated/tracking_and_rating_deprecated/tracking_screen_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Use instead MembershipHomeScreen')

/// Main screen where user can see all the information about their membership.
class MembershipScreenBuilderDeprecated extends ConsumerStatefulWidget {
  const MembershipScreenBuilderDeprecated({super.key});

  @override
  ConsumerState<MembershipScreenBuilderDeprecated> createState() =>
      _MembershipScreenBuilderState();
}

class _MembershipScreenBuilderState
    extends ConsumerState<MembershipScreenBuilderDeprecated> {
  late Future<void> initScreenFuture;
  late MembershipUiState membershipUiState;
  late HomeProvider homeProvider;
  late UserBLoCDeprecated userBLoC;
  late MembershipProviderDeprecated membershipInfoBLoC;
  late ClaimTicketProvider claimTicketProvider;
  late CatalogBLoC catalogBLoC;
  late NotificationBLoC notificationBLoC;
  late MembershipAlertUiProvider membershipAlertProvider;
  bool isInitialized = false;

  void checkBenefitFormsNotifications() {
    final hasBenefitForms = membershipInfoBLoC.hasBenefitForms &&
        membershipInfoBLoC.isMainUserOfSelectedMembership;
    if (!hasBenefitForms) return;
    final formNotifications =
        membershipInfoBLoC.benefitsByTypes.getFormNotificationsNumber;
    notificationBLoC.sumMembershipNotification(formNotifications);
  }

  Future<void> checkHistoryAndReminderTickets(String membershipId) async {
    final userId = userBLoC.user?.userId;
    if (userId == null) return;
    membershipUiState.setLoadText(PiixCopiesDeprecated.gettingTicketHistory);
    await claimTicketProvider.getTicketHistoryByMembership(
      membershipId: membershipId,
    );
    if (!mounted) return;
    if (claimTicketProvider.claimTicketState !=
        ClaimTicketStateDeprecated.retrieved) return;
    final notificationTickets = claimTicketProvider.showNotificationTickets;
    if (notificationTickets.isEmpty) return;
    notificationTickets.forEach(
      (ticket) {
        NavigatorKeyState().slideTopNavigateTo(
          TrackingScreenDeprecated(
            ticket: ticket,
          ),
        );
      },
    );
  }

  //If ecommerce is active, calls get purchase invoice by membership service
  Future<void> checkPurchaseInvoices(String membershipId) async {
    final activeEcommerce = membershipInfoBLoC.activateStore;
    final activeMembership = membershipInfoBLoC.isActiveMembership;
    if (!mounted || !activeEcommerce || !activeMembership) return;
    final purchaseInvoiceBLoC = context.read<PurchaseInvoiceBLoCDeprecated>();
    await purchaseInvoiceBLoC.getAllInvoicesByMembership(
      membershipId: membershipId,
      onlyActiveInvoices: true,
    );
  }

  ///Asynchronously loads the information of the membership,
  ///the tickets created for support and if the account is enabled
  ///to use the online store it also gets all products sold online.
  void loadMembershipScreenInformation() async {
    final membership = membershipInfoBLoC.selectedMembership;
    if (membership == null) return;
    final membershipId = membership.membershipId;
    checkBenefitFormsNotifications();
    await membershipInfoBLoC.getMembershipInfo(
      membership: membership,
    );
    if (membershipInfoBLoC.membershipInfoState ==
            MembershipInfoStateDeprecated.error ||
        membershipInfoBLoC.membershipInfoState ==
            MembershipInfoStateDeprecated.notFound) {
      homeProvider.setHomeState(HomeStateDeprecated.error);
      return;
    }

    final futures = <Future<void>>[
      checkHistoryAndReminderTickets(membershipId),
      checkPurchaseInvoices(membershipId)
    ];
    await Future.wait(futures);
    homeProvider.setHomeState(HomeStateDeprecated.finish);
    final selectedMembership = membershipInfoBLoC.selectedMembership;
    if (selectedMembership == null) return;
    //If the membership is retrieved after being selected
    //then log the event with all the core information about the
    //membership analytics.
    if (selectedMembership.membershipId.isNotEmpty) {
      PiixAnalytics.instance.logEvent(
        eventName: PiixAnalyticsEvents.membership,
        eventParameters: {
          PiixAnalyticsParameters.mainMembership:
              PiixAnalyticsValues.yesOrNo(selectedMembership.isMainUser),
          PiixAnalyticsParameters.activeMembership:
              PiixAnalyticsValues.yesOrNo(selectedMembership.isActive),
          PiixAnalyticsParameters.packageId: selectedMembership.package.id,
          PiixAnalyticsParameters.packageName: selectedMembership.package.name,
        },
      );
    }
  }

  Future<void> _initScreen() async {
    notificationBLoC = context.read<NotificationBLoC>();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        if (membershipInfoBLoC.membershipInfoState ==
                MembershipInfoStateDeprecated.retrieved &&
            membershipInfoBLoC.selectedMembership != null) return;
        homeProvider.setHomeState(HomeStateDeprecated.loading);
        membershipAlertProvider.openAllMembershipAlerts();
        membershipInfoBLoC.benefitsByTypes = [];
        loadMembershipScreenInformation();
        membershipUiState.setLoadText(PiixCopiesDeprecated.gettingUserInfo);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    membershipUiState = MembershipUiState(setState: setState);
    initScreenFuture = _initScreen();
  }

  void retryInitMembershipScreen() {
    initScreenFuture = _initScreen();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    homeProvider = context.watch<HomeProvider>();
    userBLoC = context.watch<UserBLoCDeprecated>();
    membershipInfoBLoC = context.watch<MembershipProviderDeprecated>();
    claimTicketProvider = context.watch<ClaimTicketProvider>();
    catalogBLoC = context.watch<CatalogBLoC>();
    membershipAlertProvider = context.watch<MembershipAlertUiProvider>();
    final isHomeLoading = homeProvider.homeState == HomeStateDeprecated.idle ||
        homeProvider.homeState == HomeStateDeprecated.loading;
    return WillPopScope(
      onWillPop: () => goToMemberships(context, ref),
      child: ClampingScaleDeprecated(
        child: Scaffold(
          appBar: isHomeLoading
              ? null
              : PiixAppBarDeprecated(
                  title: '${userBLoC.user?.displayNames(max: 1) ?? ''} '
                      '${userBLoC.user?.displayLastNames(max: 1) ?? ''}',
                  isTabScreen: true,
                  isMembership: true,
                  onPressed: () => goToMemberships(context, ref),
                ),
          body: FutureBuilder(
            future: initScreenFuture,
            builder: (_, __) {
              return MembershipScreenData(
                membershipUiState: membershipUiState,
                retryInitMembershipScreen: retryInitMembershipScreen,
              );
            },
          ),
        ),
      ),
    );
  }
}
