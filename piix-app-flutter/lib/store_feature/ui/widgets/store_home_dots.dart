import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/store_feature/utils/payment_methods.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

@Deprecated('No longer in use in 4.0')

///This widget contains a store home dots, these markers indicate in which
///position of the carousel of modules the user is
///
class StoreHomeDotsDeprecated extends StatelessWidget {
  const StoreHomeDotsDeprecated({
    super.key,
    required this.current,
    required this.carouselController,
  });
  final int current;
  final CarouselController carouselController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ...paymentModules.map((item) {
          final index = paymentModules.indexOf(item);
          return GestureDetector(
            onTap: () => carouselController.jumpToPage(index),
            child: Container(
              width: 8.h,
              height: 8.h,
              margin: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: current == index
                    ? PiixColors.clearBlue
                    : PiixColors.labelText,
              ),
            ),
          );
        })
      ],
    );
  }
}
