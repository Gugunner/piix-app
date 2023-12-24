import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/memberships/blank_membership.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/memberships/membership_card_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/memberships/membership_carousel_dots_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget is a main Card carousel container, contains a card and
///carousel dots.
class MembershipsCardsCarouselBuilderDeprecated extends StatefulWidget {
  const MembershipsCardsCarouselBuilderDeprecated({
    Key? key,
    this.isLoading = false,
  }) : super(key: key);
  final bool isLoading;
  @override
  _MembershipsCardsCarouselBuilderDeprecatedState createState() =>
      _MembershipsCardsCarouselBuilderDeprecatedState();
}

class _MembershipsCardsCarouselBuilderDeprecatedState
    extends State<MembershipsCardsCarouselBuilderDeprecated> {
  int currentMembership = 0;
  @override
  Widget build(BuildContext context) {
    final userBLoC = context.watch<UserBLoCDeprecated>();
    final memberships = userBLoC.user?.memberships ?? [];

    if (widget.isLoading || memberships.isEmpty)
      return Flexible(
        child: BlankMembership(
          isLoading: widget.isLoading,
        ),
      );

    return Flexible(
      flex: 6,
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                color: PiixColors.greyWhite,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: context.height,
                    viewportFraction: 1,
                    enableInfiniteScroll: true,
                    onPageChanged: (index, _) => setState(
                      () {
                        currentMembership = index;
                      },
                    ),
                  ),
                  items: memberships
                      .map(
                        (membership) => MembershipCardDeprecated(
                          membership: membership,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            MembershipCarouselDotsDeprecated(
              memberships: memberships,
              currentMembership: currentMembership,
            )
          ],
        ),
      ),
    );
  }
}
