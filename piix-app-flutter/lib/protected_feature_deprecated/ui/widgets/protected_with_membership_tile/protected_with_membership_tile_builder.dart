import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/model/protected_model.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/protected_feature_deprecated/ui/widgets/protected_with_membership_tile/protected_with_membership_expansion_content_.dart';
import 'package:piix_mobile/protected_feature_deprecated/ui/widgets/protected_with_membership_tile/protected_with_membership_title.dart';

/// Creates a expansion card with the info about the protected memberships.
class ProtectedWithMembershipTileBuilder extends StatelessWidget {
  const ProtectedWithMembershipTileBuilder({
    Key? key,
    required this.protectedWithMembership,
    required this.title,
  }) : super(key: key);

  final String title;
  final List<ProtectedModel> protectedWithMembership;

  @override
  Widget build(BuildContext context) {
    if (protectedWithMembership.isEmpty)
      return Container(
        width: context.width,
        padding: EdgeInsets.symmetric(
          vertical: 8.h,
          horizontal: 12.w,
        ),
        child: ProtectedWithMembershipTitle(
          title: title,
          protectedWithMembershipCount: protectedWithMembership.length,
        ),
      );

    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        listTileTheme: ListTileTheme.of(context).copyWith(
          dense: true,
        ),
      ),
      child: ExpansionTile(
        initiallyExpanded: true,
        title: ProtectedWithMembershipTitle(
          title: title,
          protectedWithMembershipCount: protectedWithMembership.length,
        ),
        collapsedIconColor: PiixColors.darkSkyBlue,
        childrenPadding: EdgeInsets.symmetric(
          vertical: 8.h,
        ),
        children: [
          if (protectedWithMembership.isNotEmpty)
            const Divider(
              color: PiixColors.grey,
            ),
          SizedBox(
            height: 8.h,
          ),
          ...protectedWithMembership.map(
            (protected) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 0,
                ),
                child: Column(
                  children: [
                    ProtectedWithMembershipTileContent(
                      protected: protected,
                    ),
                    if (protected.userId != protectedWithMembership.last.userId)
                      Divider(
                        color: Colors.grey,
                        height: 24.h,
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
