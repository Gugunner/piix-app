import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/date_extend_deprecated.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget shows a card with user name, package name, membership id and
///quote data
///
class InfoCardDeprecated extends StatelessWidget {
  const InfoCardDeprecated({
    super.key,
    required this.quoteDate,
  });
  final DateTime quoteDate;

  double get mediumPadding => ConstantsDeprecated.mediumPadding;

  @override
  Widget build(BuildContext context) {
    final membershipBLoC = context.watch<MembershipProviderDeprecated>();
    final userBLoC = context.watch<UserBLoCDeprecated>();
    final membership = membershipBLoC.selectedMembership;

    return Card(
      elevation: 3,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.h)),
      child: Container(
        width: context.width,
        padding: EdgeInsets.all(mediumPadding.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Render user name
            Text(
              userBLoC.user!.displayName,
              style: context.primaryTextTheme?.headlineSmall,
            ),
            //Render package name
            Text(
              '${PiixCopiesDeprecated.package}: ${membership!.package.name}',
              style: context.textTheme?.bodyMedium,
            ).padVertical(4.h),
            //Render membership id
            Text(
              '${PiixCopiesDeprecated.membershipId} ${membership.membershipId}',
              style: context.textTheme?.bodyMedium,
            ),
            //Render a quote date
            Text(
              '${PiixCopiesDeprecated.quoteDate}: ${quoteDate.dateFormat}',
              style: context.textTheme?.bodyMedium,
            ).padTop(4.h),
          ],
        ),
      ),
    );
  }
}
