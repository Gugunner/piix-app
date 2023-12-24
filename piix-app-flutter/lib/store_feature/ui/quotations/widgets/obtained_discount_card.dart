import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/utils/combos.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a card with a final percentage discount
///
class ObtainedDiscountCardDeprecated extends StatelessWidget {
  const ObtainedDiscountCardDeprecated({
    super.key,
    required this.finalDiscount,
  });
  final double finalDiscount;

  double get mediumPadding => ConstantsDeprecated.mediumPadding;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.h)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            PiixCopiesDeprecated.obtainedDiscount,
            style: context.textTheme?.titleMedium?.copyWith(
              color: PiixColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            '${finalDiscount.toPercentage.toStringAsFixed(2)}%',
            style: context.textTheme?.displayLarge?.copyWith(
              color: PiixColors.highlight,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ).padSymmetric(vertical: mediumPadding.h, horizontal: 12.w),
    );
  }
}
