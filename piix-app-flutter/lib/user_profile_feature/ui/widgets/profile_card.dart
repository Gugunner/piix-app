import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/image_memory_button.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:piix_mobile/user_profile_feature/ui/widgets/edit_credential_label.dart';
import 'package:provider/provider.dart';

/// It shows the name, telephone and email of the user, as well as the image of
/// the contracted membership
class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userBLoC = context.watch<UserBLoCDeprecated>();
    final membershipBLoC = context.watch<MembershipProviderDeprecated>();
    final user = userBLoC.user;
    final screen = MediaQuery.of(context);
    final width = screen.size.width;

    return Container(
      color: PiixColors.white,
      padding: EdgeInsets.only(top: 10.h),
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.h),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 8.h),
                        FittedBox(
                          child: Text(
                            user?.displayName ?? '',
                            style: context.textTheme?.headlineMedium,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          '${PiixCopiesDeprecated.id} ${user?.uniqueId ?? ''}',
                          textAlign: TextAlign.left,
                          style: context.primaryTextTheme?.titleSmall,
                        ),
                        SizedBox(height: 10.h),
                        const EditCredentialLabel(isEmail: true),
                        SizedBox(height: 2.h),
                        const EditCredentialLabel(isEmail: false),
                        SizedBox(height: 15.h),
                      ]),
                ),
              ),
              SizedBox(width: width * 0.241)
            ],
          ),
          Positioned(
            bottom: 0,
            right: 8.w,
            child: ImageMemoryButton(
              imageMemory: base64Decode(membershipBLoC.selectedMembership
                      ?.usersMembershipLevel.cardImageMemory ??
                  ''),
              placeholder: PiixAssets.membershipPlaceHolder,
              height: 100.h,
              boxFit: BoxFit.fitHeight,
            ),
          ),
        ],
      ),
    );
  }
}
