import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_feature/domain/model/user_app_model.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/membership_model/membership_model_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget contains display names of user and membership id
///
class UserInfoTextsDeprecated extends StatelessWidget {
  const UserInfoTextsDeprecated({
    super.key,
    this.membership,
  });
  final MembershipModelDeprecated? membership;

  double get separatorHeight => 4;

  @override
  Widget build(BuildContext context) {
    final currentUser = context.watch<UserBLoCDeprecated>().user;
    final nameStyle = context.primaryTextTheme?.displayMedium?.copyWith(
      color: PiixColors.space,
    );
    return Column(
      children: <Widget>[
        Text(
          currentUser?.displayNames() ?? '',
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: nameStyle,
        ),
        SizedBox(height: separatorHeight.h),
        Text(
          currentUser?.displayLastNames() ?? '',
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: nameStyle,
        ),
        SizedBox(height: separatorHeight.h),
        Text(
          currentUser?.uniqueId ?? '',
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme?.titleMedium?.copyWith(
            color: PiixColors.space,
          ),
        )
      ],
    );
  }
}
