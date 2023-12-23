import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_barrel_file.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/membership_feature/membership_model_barrel_file.dart';
import 'package:piix_mobile/membership_feature/membership_ui_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';

///A [Column] component that has [AppPanelButton]s to navigate the user
///to a specific location some panels depend on the status of
///[_linkedUp].
final class MembershipHomeScreenPanels extends StatelessWidget {
  const MembershipHomeScreenPanels({
    super.key,
    required this.membership,
    this.isLoading = false,
  });

  final MembershipModel membership;

  final bool isLoading;

  //TODO: Change to correct prop once membership Piix 4.0 service deploy
  bool get _linkedUp => membership.isLinkedUp;

  Color get _color => PiixColors.infoDefault;

  List<AppPanelButton> _getPanels(BuildContext context) => [
        if (!_linkedUp)
          LinkMembershipPanelButton(context, onPressed: _navigateToMembershipLink)
        else
          WelcomePanelButton(context,onPressed: _navigateToMyAssistances),
        StorePannelButton(context, onPressed: _navigateToStore),
      ];

  ///Navigates to [MyAssistanceScreen].
  void _navigateToMyAssistances() {
    //TODO: navigate to MyAssistancesScreen
  }

  ///Navigates to [MembershipLinkScreen].
  void _navigateToMembershipLink() {
    //TODO: navigate to MembershipLinkScreen
  }

  ///Navigates to [StoreScreen].
  void _navigateToStore() {
    //TODO: navigate to StoreScreen
  }

  ///Retrieves the 'Learn more' message.
  String _getLearnMoreMessage(BuildContext context) =>
      '${context.localeMessage.learnMore}...';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerWrap(
          child: Text(
            _getLearnMoreMessage(context),
            style:
                context.primaryTextTheme?.titleMedium?.copyWith(color: _color),
          ),
        ),
        SizedBox(height: 8.h),
        ..._getPanels(context).map(
          (child) => Container(
            margin: EdgeInsets.only(bottom: 8.h),
            child: ShimmerWrap(
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
