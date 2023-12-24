import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/shimmer/shimmer.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_loading.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/memberships/memberships_cards_carousel_builder_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/memberships/membership_header_deprecated.dart';
import 'package:piix_mobile/share_widgets/piix_footer_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///When the user has memberships, this widget is showed, contains the membership
///card header, memberships carousel and piix footer.
///
class MembershipsCardsWidgetDeprecated extends StatelessWidget {
  const MembershipsCardsWidgetDeprecated({
    super.key,
    this.isLoading = false,
  });

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: ShimmerLoading(
        isLoading: isLoading,
        child: SizedBox(
          child: Column(
            children: [
              Container(
                height: context.height * 0.104,
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                ),
                child: MembershipHeaderDeprecated(
                  isLoading: isLoading,
                ),
              ),
              MembershipsCardsCarouselBuilderDeprecated(
                isLoading: isLoading,
              ),
              if (!isLoading)
                const PiixFooterDeprecated(
                  backgroundColor: PiixColors.greyWhite,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
