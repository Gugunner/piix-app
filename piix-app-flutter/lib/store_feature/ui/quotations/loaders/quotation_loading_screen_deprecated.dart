import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/animation_bloc_deprecated.dart';
import 'package:piix_mobile/ui/model/quote_price_loading_ui_model_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/loaders/widgets/loading_element_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/quotation_skeleton_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///Is a quotation loading screen
///use a [AnimationStatesDeprecated] to notify when animation are finished
///it is based on opacities to show the image that corresponds according to
///the state
///
class QuotationLoadingScreenDeprecated extends StatefulWidget {
  const QuotationLoadingScreenDeprecated({Key? key}) : super(key: key);

  @override
  State<QuotationLoadingScreenDeprecated> createState() =>
      _QuotationLoadingScreenDeprecatedState();
}

class _QuotationLoadingScreenDeprecatedState
    extends State<QuotationLoadingScreenDeprecated> {
  late AnimationBLoCDeprecated animationBLoC;
  List<double> quotationOpacities = [1, 1, 1];
  List<QuotePriceLoadingUiModelDeprecated> quotationLoadingItems = [
    const QuotePriceLoadingUiModelDeprecated(
      loadingText: PiixCopiesDeprecated.generatingQuotation,
      pathImage: PiixAssets.generate_quotation,
    ),
    const QuotePriceLoadingUiModelDeprecated(
      loadingText: PiixCopiesDeprecated.calculatingDiscounts,
      pathImage: PiixAssets.calculating_discounts,
    ),
    const QuotePriceLoadingUiModelDeprecated(
      loadingText: PiixCopiesDeprecated.analizingMembershipInfo,
      pathImage: PiixAssets.analizing_membership_info,
    ),
  ];
  AnimationStatesDeprecated get loading => AnimationStatesDeprecated.LOADING;
  AnimationStatesDeprecated get finish => AnimationStatesDeprecated.FINISH;
  int get millisecondsDelayeTime => 1500;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      animationBLoC.quotationAnimatedState = loading;
      await setOpacity(0, 0);
      await setOpacity(1, 0);
      await setOpacity(2, 0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    animationBLoC = context.watch<AnimationBLoCDeprecated>();
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        const QuotationSkeletonDeprecated(),
        ...quotationLoadingItems.map(
          (item) {
            final index = quotationLoadingItems.reversed
                .toList()
                .indexWhere(((element) => element == item));
            return AnimatedOpacity(
              opacity: quotationOpacities[index],
              duration: const Duration(milliseconds: 300),
              child: LoadingElementDeprecated(
                pathImage: item.pathImage,
                text: item.loadingText,
              ),
              onEnd: () {
                final quotationLoadingItemsLength =
                    quotationLoadingItems.length - 1;
                if (index == quotationLoadingItemsLength) {
                  animationBLoC.quotationAnimatedState = finish;
                }
              },
            );
          },
        ),
      ],
    );
  }

  //This future set opacity after a delay
  Future<void> setOpacity(int index, double opacity) async {
    await Future.delayed(Duration(milliseconds: millisecondsDelayeTime), () {
      if (!mounted) return;
      setState(() {
        if (quotationOpacities.isNotEmpty) {
          quotationOpacities[index] = opacity;
        }
      });
    });
  }
}
