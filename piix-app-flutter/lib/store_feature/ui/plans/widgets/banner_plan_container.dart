import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/utils/store_copies.dart';

///This widget render a plan banner is a asset image with border radius in
///bottom
///
class BannerPlanContainer extends StatelessWidget {
  const BannerPlanContainer({super.key});

  double get mediumPadding => ConstantsDeprecated.mediumPadding;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: context.width,
          height: 81.h,
          margin: EdgeInsets.only(bottom: mediumPadding),
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(PiixAssets.planQuotationBanner),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(8),
              )),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 20.sp),
          child: Text(
            StoreCopiesDeprecated.moreProtectedBetterPrices,
            style: context.textTheme?.headlineSmall?.copyWith(
              color: PiixColors.sky,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
