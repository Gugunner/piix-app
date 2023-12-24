import 'package:flutter/material.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/providers/claim_ticket_provider.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/catalog_bloc.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/connectivity_bloc.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/home_provider.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/notification_bloc.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/ui_bloc.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_error_screen_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/membership_info_repository_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_alert_ui_provider.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_ui_state.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/membership_data_column.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/membership_top_alert.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/piix_bottom_alert_info_deprecated.dart';
import 'package:piix_mobile/widgets/no_internet.dart';
import 'package:piix_mobile/ui/common/piix_full_loader_deprecated.dart';
import 'package:provider/provider.dart';

///This widget contains all membership alerts include bottom and top alerts and
///membership data column that contains coverage and additions info
///
class MembershipScreenData extends StatefulWidget {
  const MembershipScreenData({
    super.key,
    required this.membershipUiState,
    this.retryInitMembershipScreen,
  });
  final MembershipUiState membershipUiState;
  final VoidCallback? retryInitMembershipScreen;

  @override
  State<MembershipScreenData> createState() => _MembershipScreenDataState();
}

class _MembershipScreenDataState extends State<MembershipScreenData> {
  late HomeProvider homeProvider;
  late UiBLoC uiBLoC;
  late MembershipProviderDeprecated membershipInfoBLoC;
  late ClaimTicketProvider claimTicketProvider;
  late CatalogBLoC catalogBLoC;
  late NotificationBLoC notificationBLoC;
  late MembershipAlertUiProvider membershipAlertProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final connectivityBLoC = context.watch<ConnectivityBLoC>();
    homeProvider = context.watch<HomeProvider>();
    uiBLoC = context.watch<UiBLoC>();
    membershipInfoBLoC = context.watch<MembershipProviderDeprecated>();
    claimTicketProvider = context.watch<ClaimTicketProvider>();
    catalogBLoC = context.watch<CatalogBLoC>();
    membershipAlertProvider = context.watch<MembershipAlertUiProvider>();

    if (!connectivityBLoC.fullConnection) {
      return const NoInternet();
    }
    if (homeProvider.homeState == HomeStateDeprecated.idle ||
        homeProvider.homeState == HomeStateDeprecated.loading) {
      return PiixFullLoaderDeprecated(
          loadText: widget.membershipUiState.loadText);
    }
    if (homeProvider.homeState == HomeStateDeprecated.error) {
      return PiixErrorScreenDeprecated(
        errorMessage: PiixCopiesDeprecated.couldNotBeLoadedMembershipInfo,
        onTap: widget.retryInitMembershipScreen,
      );
    }
    return Stack(
      children: [
        MembershipDataColumn(
          membershipUiState: widget.membershipUiState,
        ),

        //IMPORTANT!
        //The membership top alert must be called as many times as necessary,
        //since if there are two alerts, each one is independent, each one
        //closes and has different actions than the other.
        if (showTopBasicMembership)
          MembershipTopAlert(
            type: topAlert,
            retryInitScreen: widget.retryInitMembershipScreen,
          ),
        if (showTopTicketAlert) MembershipTopAlert(type: topAlert),
        if (showTopAdditionalFormAlert) MembershipTopAlert(type: topAlert),
        if (showBottomActivatingMembershipAlert)
          PiixBottomAlertInfoDeprecated(
            color: PiixColors.process,
            child: Text(
              PiixCopiesDeprecated.membershipIsActivating,
              textAlign: TextAlign.center,
              style: context.accentTextTheme?.titleLarge?.copyWith(
                color: PiixColors.space,
              ),
            ),
          ),
      ],
    );
  }
}

///An extension to handle all boolean logic that evaluates if the
///user needs to see top and/or bottom alerts and of what kind.
extension MembershipScreenAlerts on _MembershipScreenDataState {
  bool get hasBenefitForms =>
      membershipInfoBLoC.hasBenefitForms &&
      membershipInfoBLoC.isMainUserOfSelectedMembership;

  bool get isMembershipErrorState =>
      membershipInfoBLoC.membershipInfoState ==
      MembershipInfoStateDeprecated.error;

  bool get isMembershipNotFoundState =>
      membershipInfoBLoC.membershipInfoState ==
      MembershipInfoStateDeprecated.notFound;

  ///Returns a [MembershipAlert] to show alerts as banners value based on the
  ///different boolean logics
  MembershipAlert get topAlert {
    if (!membershipAlertProvider.isOpenTopAlert ||
        !membershipInfoBLoC.isMainUserOfSelectedMembership) {
      return MembershipAlert.none;
    }
    if (hasBenefitForms && membershipAlertProvider.isOpenFormsAlert) {
      return MembershipAlert.additionalForms;
    }
    if (claimTicketProvider.showNotificationTickets.isNotEmpty &&
        membershipAlertProvider.isOpenTicketAlert) {
      return MembershipAlert.ticketsFound;
    }
    if (isMembershipErrorState || isMembershipNotFoundState) {
      return MembershipAlert.basicMembership;
    }
    return MembershipAlert.none;
  }

  ///Returns a [MembershipAlert] to show alerts as snackbars value based on the
  ///different boolean logics
  MembershipAlert get bottomAlert {
    //Bottom Form Alerts
    //If membership is active is not necessary show alerts
    if (membershipInfoBLoC.isActiveMembership) {
      return MembershipAlert.none;
    }
    //When membership is inactive shows alerts
    if (hasBenefitForms) {
      return MembershipAlert.activatingMembership;
    }
    return MembershipAlert.none;
  }

  bool get showTopAdditionalFormAlert =>
      topAlert == MembershipAlert.additionalForms;

  bool get showTopBasicMembership =>
      topAlert == MembershipAlert.basicMembership;

  bool get showTopTicketAlert => topAlert == MembershipAlert.ticketsFound;

  bool get showBottomActivatingMembershipAlert =>
      bottomAlert == MembershipAlert.activatingMembership;
}
