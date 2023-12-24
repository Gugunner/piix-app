import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/membership_feature/membership_model_barrel_file.dart';
import 'package:piix_mobile/membership_feature/membership_screen_barrel_file.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/widgets/screen/app_screen/app_request_result_screen.dart';

///Appears after the user successfully links up the membership to
///a family group or a commnunity.
final class SuccessLinkupMembershipScreen extends ConsumerWidget {
  static const routeName = '/success_linkup_membership_screen';
  const SuccessLinkupMembershipScreen({
    super.key,
    this.linkupModel,
  });

  final LinkupCodeTypeModel? linkupModel;

  String _getLinkMembershipMessage(BuildContext context) =>
      context.localeMessage.linkMembership;

  String _getSuccesfulFamilyGroupLinkupMessage(
          BuildContext context, String linkupTo) =>
      context.localeMessage.successfulFamilyGroupLinkupMessage(linkupTo);

  String _getSuccessComunnityLinkupMessage(
          BuildContext context, String linkupTo) =>
      context.localeMessage.successfulCommunityLinkupMessage(linkupTo);

  String _getSuccessfulLinkupMessage(
    BuildContext context,
  ) {
    final type = linkupModel!.type;
    final name = linkupModel!.name;
    if (type == LinkupCodeType.userGroup)
      return _getSuccesfulFamilyGroupLinkupMessage(context, name);
    return _getSuccessComunnityLinkupMessage(context, name);
  }

  String _getTheFamilyGroupInvitationCodeHasBeenValidatedMessage(
          BuildContext context, String linkupTo) =>
      context.localeMessage
          .theFamilyGroupInvitationCodeHasBeenValidated(linkupTo);

  String _getTheCommunityInvitationCodeHasBeenValidatedMessage(
          BuildContext context, String linkupTo) =>
      context.localeMessage
          .theCommunityInvitationCodeHasBeenValidated(linkupTo);

  String _getTheInvitationCodeHasBeenValidatedMessage(
    BuildContext context,
  ) {
    final type = linkupModel!.type;
    final name = linkupModel!.name;
    if (type == LinkupCodeType.userGroup)
      return _getTheFamilyGroupInvitationCodeHasBeenValidatedMessage(
          context, name);
    return _getTheCommunityInvitationCodeHasBeenValidatedMessage(context, name);
  }

  ///Clears any [memberships] the user has and navigates to the
  ///[MembershipLoadingScreen] to load the new [memberships] with the
  ///linkage changes.
  void _navigateToMembershipLoadingScreen(BuildContext context, WidgetRef ref) {
    //Returns to the previous screen.
    Navigator.pop(context);
  }

  //User cannot pop this screen only accept and move to the
  //MembershipLoadingScreen
  Future<bool> _onWillPop() async => false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //If the information is not passed it means the app
    //did not pass the data and may have failed the linkup.
    if (linkupModel == null) const SizedBox();
    return AppRequestResultScreen(
      appBarTitleText: _getLinkMembershipMessage(context),
      titleText: _getSuccessfulLinkupMessage(context),
      messageText: _getTheInvitationCodeHasBeenValidatedMessage(context),
      onAccept: () => _navigateToMembershipLoadingScreen(context, ref),
      onWillPop: _onWillPop,
    );
  }
}
