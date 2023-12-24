import 'package:flutter/material.dart';
import 'package:piix_mobile/claim_ticket_feature/data/repository/claim_ticket_repository_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/providers/claim_ticket_provider.dart';
import 'package:piix_mobile/claim_ticket_feature/utils/claim_tickets_deprecated.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_banner_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_banner_content_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_values.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/model/ticket_model.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/utils/piix_memberships_util_deprecated.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

///This method returns the status of a ticket.
String getTicketStatusName({required TicketStatus status}) {
  switch (status) {
    case TicketStatus.user_generated:
    case TicketStatus.system_alert_one:
    case TicketStatus.user_support:
      return 'Abierta';
    case TicketStatus.user_closed:
      return 'Terminada';
    case TicketStatus.user_canceled:
      return 'Cancelada';
    default:
      return 'Desconocido';
  }
}

///This method returns the status color of a ticket.
Color getTicketStatusColor({required TicketStatus status}) {
  switch (status) {
    case TicketStatus.user_generated:
    case TicketStatus.user_support:
    case TicketStatus.system_alert_one:
      return PiixColors.attendanceGreen;
    case TicketStatus.user_closed:
      return PiixColors.sunYellow;
    case TicketStatus.user_canceled:
      return PiixColors.errorMain;
    default:
      return PiixColors.grey;
  }
}

///This method returns the name of benefit of a ticket.
String getNameOfTicket({required String benefitName}) {
  return benefitName.isEmpty ? PiixCopiesDeprecated.ticketFromSOS : benefitName;
}

///This method returns a list of messages of a ticket.
List<String> getRichAlertMessages({required String message}) {
  var messages = <String>[];
  if (message.contains(ConstantsDeprecated.boldOk)) {
    messages = message.split('*');
  }

  return messages;
}

///Generate a html ul tag
String generateUnOrderedHtmlList(List<String> contentList) {
  final pointHtmlList = contentList.map((e) => '<li>$e</li>').toList().join('');
  final html = '''<ul>${pointHtmlList}</ul>''';
  return html;
}

String getClaimTicketType({
  String? additionalBenefitPerSupplierId,
  String? cobenefitPerSupplierId,
  String? benefitPerSupplierId,
}) {
  if (additionalBenefitPerSupplierId.isNotNullEmpty) {
    return PiixAnalyticsValues.additionalBenefitPerSupplier;
  }
  if (cobenefitPerSupplierId.isNotNullEmpty) {
    return PiixAnalyticsValues.cobenefitPerSupplier;
  }
  if (benefitPerSupplierId.isNotNullEmpty) {
    return PiixAnalyticsValues.benefitPerSupplier;
  }
  return PiixAnalyticsValues.sos;
}

Future<bool> handleCreateClaimTicket(
  BuildContext context, {
  required bool mounted,
  bool sosClaim = false,
  String? benefitPerSupplierId,
  String? cobenefitPerSupplierId,
  String? additionalBenefitPerSupplierId,
}) async {
  final userBLoC = context.read<UserBLoCDeprecated>();
  final membershipBLoC = context.read<MembershipProviderDeprecated>();
  final claimTicketProvider = context.read<ClaimTicketProvider>();
  final user = userBLoC.user;
  final membership = membershipBLoC.selectedMembership;
  if (user == null || membership == null) return false;
  await claimTicketProvider.createTicket(
    userId: user.userId,
    membershipId: membership.membershipId,
    isSos: sosClaim,
    benefitPerSupplierId: benefitPerSupplierId,
    cobenefitPerSupplierId: cobenefitPerSupplierId,
    additionalBenefitPerSupplierId: additionalBenefitPerSupplierId,
  );
  NavigatorKeyState().getNavigator()?.pop();
  final claimTicketState = claimTicketProvider.claimTicketState;
  if (claimTicketState.hasErrorState) {
    const banner = ClaimTicketsBannersDeprecated.errorCreateBanner;
    if (!mounted) return false;
    PiixBannerDeprecated.instance.builder(
      context,
      children: banner.build(context),
    );
  }
  return claimTicketState == ClaimTicketStateDeprecated.created;
}

Future<bool> handleLaunchUrl(
  BuildContext context, {
  required TicketModel? selectedTicket,
  required String claimAction,
  required String packageId,
  required String packageName,
  required bool mounted,
  String? benefitName,
  bool phoneClaim = false,
}) async {
  final membershipInfoBLoC = context.read<MembershipProviderDeprecated>();
  final userBLoC = context.read<UserBLoCDeprecated>();
  final user = userBLoC.user;
  final membership = membershipInfoBLoC.selectedMembership;
  final whatsappNumber = membershipInfoBLoC.selectedMembership?.claimChatNumber;
  final callNumber = membershipInfoBLoC.selectedMembership?.claimPhoneNumber;
  var succesfulLaunch = false;
  if (phoneClaim) {
    succesfulLaunch = await piixLaunchUrl(
      'tel://$callNumber',
      isPhone: phoneClaim,
    );
  } else {
    copyMembershipData(
      uniqueId: user?.uniqueId,
      membership: membership,
    );
    final whatsappUniLink = WhatsAppUnilink(
      phoneNumber: '+$whatsappNumber',
      text: PiixCopiesDeprecated.chatMessage(
        user: user,
        membership: membership,
        benefitName: benefitName,
      ),
    );
    succesfulLaunch = await piixLaunchUrl(
      '$whatsappUniLink',
      isPhone: phoneClaim,
    );
  }
  if (!succesfulLaunch) {
    final banner = phoneClaim
        ? ClaimTicketsBannersDeprecated.errorCallBanner
        : ClaimTicketsBannersDeprecated.errorWhatsappBanner;
    if (!mounted) return false;
    PiixBannerDeprecated.instance.builder(
      context,
      children: banner.build(context),
    );
  }
  return succesfulLaunch;
}

Future<bool> handleReportClaimTicket(
  BuildContext context, {
  bool sosClaim = false,
  required String ticketId,
  required bool mounted,
  String problemDescription = '',
}) async {
  final claimTicketProvider = context.read<ClaimTicketProvider>();
  await claimTicketProvider.reportTicketProblem(
    ticketId: ticketId,
    problemDescription: problemDescription,
  );
  final claimTicketState = claimTicketProvider.claimTicketState;
  if (claimTicketState.hasErrorState) {
    const banner = PiixBannerContentDeprecated(
      title: PiixCopiesDeprecated.appFailure,
      subtitle: PiixCopiesDeprecated.reportClaimErrorMessage,
      iconData: Icons.error_outline,
      cardBackgroundColor: PiixColors.errorMain,
    );
    if (!mounted) return false;
    PiixBannerDeprecated.instance.builder(
      context,
      children: banner.build(context),
    );
  }
  return claimTicketState == ClaimTicketStateDeprecated.reported;
}
