import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/ui/common/piix_tooltip_deprecated.dart';

final activeInfoKey = GlobalKey();

@Deprecated('Will be removed in 4.0')

///Create a level tooltip, render a resume info of level module
///
class LevelTooltipDeprecated extends StatelessWidget {
  const LevelTooltipDeprecated({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        PiixTooltipDeprecated(
            offsetKey: activeInfoKey,
            showCloseButton: true,
            backgroundColor: PiixColors.infoDefault,
            content: Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              width: 200.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    PiixCopiesDeprecated.levelTooltipText,
                    style: context.textTheme?.labelMedium?.copyWith(
                      color: PiixColors.space,
                    ),
                    textAlign: TextAlign.justify,
                  ).padTop(4.h),
                  Text.rich(TextSpan(
                    children: [
                      TextSpan(
                        text: '${PiixCopiesDeprecated.eventLabel}: ',
                        style: context.textTheme?.labelLarge?.copyWith(
                          color: PiixColors.space,
                        ),
                      ),
                      const TextSpan(
                        text: PiixCopiesDeprecated.eventDescription,
                      ),
                    ],
                    style: context.textTheme?.labelMedium?.copyWith(
                      color: PiixColors.space,
                    ),
                  )).padVertical(10.h),
                  Text.rich(
                    TextSpan(
                        children: [
                          TextSpan(
                            text:
                                '${PiixCopiesDeprecated.summedTotalPremium}: ',
                            style: context.textTheme?.labelLarge?.copyWith(
                              color: PiixColors.space,
                            ),
                          ),
                          const TextSpan(
                            text: PiixCopiesDeprecated.summedTotalDescription,
                          ),
                        ],
                        style: context.textTheme?.labelMedium?.copyWith(
                          color: PiixColors.space,
                        )),
                  )
                ],
              ),
            )).controller?.showTooltip();
      },
      child: Icon(
        Icons.info_outline,
        key: activeInfoKey,
        size: 12.h,
        color: PiixColors.clearBlue,
      ),
    );
  }
}
