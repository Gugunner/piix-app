import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/utils/skeletons.dart';

@Deprecated('Will be removed in 4.0')

///This is a error screen to store
///
class PiixErrorScreenDeprecated extends StatelessWidget {
  const PiixErrorScreenDeprecated({
    super.key,
    required this.errorMessage,
    this.onTap,
    this.buttonLabel = PiixCopiesDeprecated.retry,
  });
  final String errorMessage;
  final VoidCallback? onTap;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          //This widget is for a error message
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: context.textTheme?.titleMedium,
          ).padHorizontal(context.width.percentageSize(0.151)),
          //This widget is for error image
          SvgPicture.asset(PiixAssets.searchEmpty, height: 97.6.h)
              .padOnly(top: 19.h, bottom: 16.h),
          //This widget is for back to store button
          SizedBox(
            height: 32.h,
            width: context.width * 0.627,
            child: ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style,
              onPressed: onTap,
              child: Text(
                buttonLabel.toUpperCase(),
                textAlign: TextAlign.center,
                style: context.primaryTextTheme?.titleMedium?.copyWith(
                  color: PiixColors.space,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
