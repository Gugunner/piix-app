import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/navigation_deprecated/navigation_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/membership_type_builder_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/image_memory_button.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/text_on_tap_element_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/animation/animated_navigation_util.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/membership_model/membership_model_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/memberships/user_info_texts_deprecated.dart';
import 'package:provider/provider.dart';

import 'placeholder_membership_card_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This widget is in charge of rendering the card of each of the user's
///memberships, on the main page of the app.
///Receives:
/// [membership] is a user membership info
/// [current] in case of having more than one, it is the position
class MembershipCardDeprecated extends StatelessWidget {
  const MembershipCardDeprecated({
    Key? key,
    this.membership,
  }) : super(key: key);
  final MembershipModelDeprecated? membership;

  void toMembershipTypeBuilder(BuildContext context) async {
    final navigationProvider = context.read<NavigationProviderDeprecated>();
    final membershipBLoC = context.read<MembershipProviderDeprecated>();
    navigationProvider.setCurrentNavigationBottomTab(0);
    membershipBLoC.setSelectedMembership(membership);
    await Navigator.push<void>(
      context,
      ScalePageRoute(
        widget: const MembershipTypeBuilderDeprecated(),
        routeName: MembershipTypeBuilderDeprecated.routeName,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;

    //A safeguard if the membership is null to avoid any crashes and in the rare
    //cases the app loads everything but a bad state handling creates this
    //scenario
    if (membership == null) return const PlaceHolderMembershipCardDeprecated();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.1),
          child: TextOnTapElementDeprecated(
            text: membership?.package.name ?? '',
            onTap: () => toMembershipTypeBuilder(context),
            activeStyle: context.primaryTextTheme?.headlineSmall,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 35.w),
          child: Stack(
            children: [
              ImageMemoryButton(
                height: height * 0.5,
                imageMemory: membership?.usersMembershipLevel.cardImageCache,
                onTap: () => toMembershipTypeBuilder(context),
                placeholder: PiixAssets.membershipPlaceHolder,
              ),
              Positioned(
                bottom: 20.h,
                right: 0,
                left: 0,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 35.w,
                  ),
                  child: UserInfoTextsDeprecated(
                    membership: membership,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
