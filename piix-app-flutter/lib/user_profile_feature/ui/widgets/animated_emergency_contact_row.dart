import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_icons.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/providers/animator_provider.dart';
import 'package:provider/provider.dart';

/// This widget shows a emergency contact info in an animated container.
class AnimatedEmergencyContactRow extends StatelessWidget {
  const AnimatedEmergencyContactRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animatorProvider = context.watch<AnimatorProvider>();
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      decoration:
          const BoxDecoration(border: Border(bottom: BorderSide(width: .1))),
      child: Padding(
        padding: EdgeInsets.only(left: width * .07, right: 12.w),
        child: Row(
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: const Icon(PiixIcons.phone,
                              color: PiixColors.infoDefault)),
                      Text(
                        PiixCopiesDeprecated.emergencyContact,
                        style: context.textTheme?.bodyMedium,
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 6.h,
                      left: width * .07,
                    ),
                    child: !animatorProvider.expandEmergencyContact
                        ? const SizedBox()
                        //TODO: Once the user contact information is added, refactor and use this code
                        // : user!.emergencyContactName.isNotEmpty
                        //     ? Text(
                        //         '${user.emergencyContactName}\n'
                        //         '${user.emergencyContactPhoneNumber}',
                        //         style: context.textTheme?.bodyMedium,
                        //       )
                        : Text(
                            PiixCopiesDeprecated.noContact1,
                            style: context.textTheme?.bodyMedium,
                          ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () => animatorProvider.expandEmergencyContact =
                  !animatorProvider.expandEmergencyContact,
              child: Text(
                animatorProvider.expandEmergencyContact
                    ? PiixCopiesDeprecated.hideButton
                    : PiixCopiesDeprecated.viewText,
                style: context.primaryTextTheme?.titleMedium?.copyWith(
                  color: PiixColors.active,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
