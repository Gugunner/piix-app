import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/widgets/arrow_indicator.dart';
import 'package:piix_mobile/store_feature/ui/widgets/store_home_card_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/widgets/store_home_dots.dart';
import 'package:piix_mobile/store_feature/utils/payment_methods.dart';

///This widget render a carousel of store modules, includes benefits, plans
///and levels
@Deprecated('No longer in use in Piix 4.0')
class StoreHomeBuilderDeprecated extends StatefulWidget {
  const StoreHomeBuilderDeprecated({super.key});

  @override
  State<StoreHomeBuilderDeprecated> createState() =>
      _StoreHomeBuilderDeprecatedState();
}

class _StoreHomeBuilderDeprecatedState
    extends State<StoreHomeBuilderDeprecated> {
  int _current = 0;
  CarouselController carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    final useFullScreenHeight = context.height - kToolbarHeight;
    return SizedBox(
      width: context.width,
      child: Stack(
        // alignment: Alignment.center,
        children: [
          Column(
            children: [
              Expanded(
                child: CarouselSlider(
                  carouselController: carouselController,
                  options: CarouselOptions(
                      height: useFullScreenHeight,
                      viewportFraction: 1,
                      enableInfiniteScroll: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                  items: paymentModules.map(
                    (module) {
                      return StoreHomeCardDeprecated(
                        module: module,
                      ).padTop(8.h).padHorizontal(36.5.w);
                    },
                  ).toList(),
                ),
              ),
              StoreHomeDotsDeprecated(
                current: _current,
                carouselController: carouselController,
              )
            ],
          ),
          if (_current < (paymentModules.length - 1))
            Positioned(
              right: -12.w,
              top: context.height * 0.4,
              child: GestureDetector(
                onTap: () => carouselController.nextPage(),
                child: const ArrowIndicatorDeprecated(),
              ),
            ),
          if (_current > 0)
            Positioned(
              left: 4.w,
              top: context.height * 0.4,
              child: GestureDetector(
                onTap: () => carouselController.previousPage(),
                child: const ArrowIndicatorDeprecated(
                  direction: ConstantsDeprecated.left,
                ),
              ),
            )
        ],
      ),
    );
  }
}
