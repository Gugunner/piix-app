import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_feature/user_app_model_barrel_file.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/benefit_per_supplier_screen_barrel_file.dart';
import 'package:piix_mobile/membership_feature/membership_screen_barrel_file.dart';
import 'package:piix_mobile/navigation_feature/navigation_utils_barrel_file.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_barrel_file.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_icons.dart';
import 'package:piix_mobile/membership_feature/membership_model_barrel_file.dart';
import 'package:piix_mobile/membership_feature/membership_ui_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';

///A [Column] component that has the main components the user sees
///when entering the [MembershipHomeScreen].
final class MembershipHomeScreenHeader extends StatelessWidget {
  const MembershipHomeScreenHeader({
    super.key,
    required this.user,
    required this.membership,
    this.isLoading = false,
  });

  final UserAppModel user;
  final MembershipModel membership;
  final bool isLoading;

  bool get _isActive => membership.isActive;

  //TODO: Change to correct prop once membership Piix 4.0 service deploy
  bool get _linkedUp => membership.isLinkedUp;

  String get _shortName => user.displayShortFullName;

  Color get _color => PiixColors.infoDefault;

  //TODO: change to assistance quantity once new service for Piix 4.0 is deployed
  int get _count => membership.benefitsQuantity;

  ///Navigates to [MyAssistanceScreen].
  void _navigateToMyAssistances() {
    NavigatorKeyState().slideToLeftRoute(
      page: const MyAssistancesScreen(),
      routeName: MyAssistancesScreen.routeName,
    );
  }

  ///Navigates to [MembershipLinkScreen].
  void _navigateToMembershipLink() {
    NavigatorKeyState().slideToLeftRoute<String>(
      page: const LinkupMembershipScreen(),
      routeName: LinkupMembershipScreen.routeName,
    );
  }

  ///Retrieves the 'Hello [_shortName]' message.
  String _getHelloShortNameMessage(BuildContext context) =>
      context.localeMessage.helloUser(_shortName);

  ///Retrieves the 'Your Piix Membership has:' message.
  String _getYourPiixMembershipMessage(BuildContext context) =>
      context.localeMessage.yourPiixMembership;

  ///Retrieves the 'My assistances ([_count])' message.
  String _getMyAssistancesMessage(BuildContext context) =>
      context.localeMessage.myAssistanceCount(_count);

  ///Retrieves the 'Link Membership' or 'Unlink Membership' message
  ///if the [_linkedUp] is true.
  String _getLinkMembershipMessage(BuildContext context) => _linkedUp
      ? context.localeMessage.unlinkMembership
      : context.localeMessage.linkMembership;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(flex: 3, child: SizedBox(width: context.width)),
        Flexible(
            flex: 10,
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MembershipStatusTag(_isActive),
                  SizedBox(height: 8.h),
                  ShimmerWrap(
                    child: Text(
                      _getHelloShortNameMessage(context),
                      style: context.primaryTextTheme?.headlineSmall
                          ?.copyWith(color: _color),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  ShimmerWrap(
                    child: Text(
                      _getYourPiixMembershipMessage(context),
                      style: context.bodyMedium?.copyWith(color: _color),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  ShimmerWrap(
                    child: AppTabButton.icon(
                      onPressed: _isActive ? _navigateToMyAssistances : null,
                      icon: Icon(
                        PiixIcons.membresias,
                        color: PiixColors.active,
                        size: 24.w,
                      ),
                      label: Text(
                        _getMyAssistancesMessage(context),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(
                    width: context.width,
                    child: AppOutlinedSizedButton(
                      onPressed: _isActive ? _navigateToMembershipLink : null,
                      text: _getLinkMembershipMessage(context).toUpperCase(),
                    ),
                  )
                ],
              ),
            ))
      ],
    );
  }
}
