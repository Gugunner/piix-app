import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piix_mobile/auth_feature/domain/model/user_app_model.dart';
import 'package:piix_mobile/extensions/date_extend_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_feature/membership_model_barrel_file.dart';
import 'package:piix_mobile/utils/app_copies_barrel_file.dart';
import 'package:piix_mobile/utils/color_utils.dart';

///Displays a membership card that programatically shows
///the [membership] information based on [level].
class FullVerticalMembershipVerticalCard extends StatelessWidget {
  const FullVerticalMembershipVerticalCard({
    super.key,
    required this.height,
    required this.width,
    required this.membership,
    required this.user,
  }) : assert(height >= 196, width >= 118);

  ///Controls the height of the membership card
  ///do not exceed the minimum
  final double height;

  ///Controls the width of the membership card
  ///do not exceed the minimum
  final double width;

  ///The current user of the app
  final UserAppModel user;

  ///The membership the card represents
  final MembershipModel membership;

  @override
  Widget build(BuildContext context) {
    //A star custom image
    final svgPicture = SvgPicture.asset(
      PiixAssets.piixPlusSvg,
      color: PiixColors.white,
      placeholderBuilder: (context) => const SizedBox(),
      width: 8.w,
    );
    //Positions the first star
    final offsetOne = Offset(width / 2 - 12.w, height / 2 - 20.h);
    //Positions the second star
    final offsetTwo = Offset(width / 2 + 8.w, height / 2 - 12.h);
    //Positions the third star
    final offsetThree = Offset(width / 2, height / 2 - 4.h);
    return Stack(
      children: [
        _MembershipCardContent(
          height: height,
          width: width,
          membership: membership,
          user: user,
        ),
        Positioned(
          top: offsetOne.dy,
          left: offsetOne.dx,
          child: svgPicture,
        ),
        Positioned(
          top: offsetTwo.dy,
          left: offsetTwo.dx,
          child: svgPicture,
        ),
        Positioned(
          top: offsetThree.dy,
          left: offsetThree.dx,
          child: Transform.rotate(
            angle: pi * 3 / 4,
            child: svgPicture,
          ),
        ),
        Positioned(
          top: height * 1 / 2 + 16.h,
          left: width / 2 - 18.w,
          child: SvgPicture.asset(
            PiixAssets.piixSvgLogo,
            color: PiixColors.white,
            placeholderBuilder: (context) => const Placeholder(),
            width: 36.w,
          ),
        ),
      ],
    );
  }
}

///Contains the membership content and decoration
///of the membership card.
class _MembershipCardContent extends StatelessWidget {
  const _MembershipCardContent({
    required this.height,
    required this.width,
    required this.membership,
    required this.user,
  }) : assert(height >= 196, width >= 118);

  ///Controls the height of the membership card
  ///do not exceed the minimum
  final double height;

  ///Controls the width of the membership card
  ///do not exceed the minimum
  final double width;

  ///The current user of the app
  final UserAppModel user;

  ///The membership the card represents
  final MembershipModel membership;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: _membershipCardDecoration,
      child: _MembershipContent(
        cardLevel: MembershipCopies.blue,
        user: user,
      ),
    );
  }

  ///The membership card decoration
  BoxDecoration get _membershipCardDecoration {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: PiixColors.contrast30,
          spreadRadius: 0,
          blurRadius: 10,
          offset: const Offset(0, 4),
          blurStyle: BlurStyle.normal,
        ),
      ],
      gradient: _membershipCardGradient,
    );
  }

  ///A six step gradient that gradually darkens the
  ///original membership card color from top to bottom.
  LinearGradient get _membershipCardGradient {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        PiixColors.level1,
        ColorUtils.darken(PiixColors.level1, 0.01),
        ColorUtils.darken(PiixColors.level1, 0.05),
        ColorUtils.darken(PiixColors.level1, 0.1),
        ColorUtils.darken(PiixColors.level1, 0.15),
        ColorUtils.darken(PiixColors.level1, 0.3),
      ],
    );
  }
}

///The membership information that is dynamically changed
///with each membership
class _MembershipContent extends StatelessWidget {
  const _MembershipContent({
    required this.cardLevel,
    required this.user,
  });

  ///The name of the level
  final String cardLevel;

  ///The current user of the app
  final UserAppModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          flex: 5,
          child: _LevelBrandLabel(cardLevel: cardLevel),
        ),
        Flexible(
          flex: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    user.displayShortFullName,
                    style: context.accentTextTheme?.labelLarge?.copyWith(
                      color: PiixColors.space,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    user.uniqueId ?? '',
                    style: context.labelMedium?.copyWith(
                      fontSize: 6.sp,
                      color: PiixColors.space,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  _MembershipIssueDateInformation(
                    issueDate: user.registerDate.shortDateFormat ?? '',
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

///Contains the information as a [Row] when the user
///was first registered
class _MembershipIssueDateInformation extends StatelessWidget {
  const _MembershipIssueDateInformation({
    required this.issueDate,
  });

  final String issueDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 2,
          child: Text(
            '${PiixCopiesDeprecated.memberSince}: ',
            style: context.bodySmall?.copyWith(
              color: PiixColors.space,
              fontSize: 4.sp,
            ),
          ),
        ),
        Flexible(
          flex: 8,
          child: Text(
            issueDate,
            style: context.bodySmall?.copyWith(
              color: PiixColors.space,
            ),
          ),
        )
      ],
    );
  }
}

///A 180 degrees or -90 degrees label that shows
///the name of the membership level.
class _LevelBrandLabel extends StatelessWidget {
  const _LevelBrandLabel({
    required this.cardLevel,
  });

  ///The level name to show in the membership card
  final String cardLevel;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 2,
      child: Text.rich(
        TextSpan(
          text: '$cardLevel'
              '\n',
          children: [
            TextSpan(
              text: PiixCopiesDeprecated.membershipWord,
              style: context.textTheme?.labelSmall?.copyWith(
                color: PiixColors.space,
              ),
            ),
          ],
        ),
        style: context.textTheme?.displaySmall?.copyWith(
          color: PiixColors.space,
          fontWeight: FontWeight.w100,
        ),
      ),
    );
  }
}
