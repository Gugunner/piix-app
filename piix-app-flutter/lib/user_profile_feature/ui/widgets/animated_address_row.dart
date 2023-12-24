import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_feature/domain/model/user_app_model.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:piix_mobile/providers/animator_provider.dart';
import 'package:provider/provider.dart';

/// This widget shows a addres info in an animated container.
class AnimatedAddressRow extends StatelessWidget {
  const AnimatedAddressRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final animatorProvider = context.watch<AnimatorProvider>();
    final user = context.read<UserBLoCDeprecated>().user;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      width: double.infinity,
      decoration:
          const BoxDecoration(border: Border(bottom: BorderSide(width: .1))),
      child: Padding(
        padding: EdgeInsets.only(left: width * .07, right: 12.w),
        child: Row(
          children: [
            Expanded(
              child: Text(
                  '${PiixCopiesDeprecated.address} : ${user?.stringAddress ?? ''}',
                  style: context.textTheme?.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: animatorProvider.expandAddress ? 6 : 1),
            ),
            //TODO: Once the user address information is added, refactor and use this code
            //if (user.stringAddress.isNotEmpty)
            //GestureDetector(
            //  onTap: () => animatorProvider.expandAddress =
            //      !animatorProvider.expandAddress,
            //  child: Text(
            //      animatorProvider.expandAddress
            //          ? PiixCopies.hideButton
            //          : PiixCopies.viewText,
            //      style: context.primaryTextTheme?.titleMedium?.copyWith(
            //        color: PiixColors.active,
            //      )),
            //)
          ],
        ),
      ),
    );
  }
}
