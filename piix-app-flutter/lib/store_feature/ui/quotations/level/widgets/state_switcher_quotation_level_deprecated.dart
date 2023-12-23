import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/animation_bloc_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_error_screen_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/store_feature/data/repository/levels_deprecated/levels_repository_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/levels_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/level/widgets/level_data_quotation_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/loaders/quotation_loading_screen_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget depending on the state can show the loading screen, the data
///screen, the empty screen or the error screen
///
class StateSwitcherQuotationLevelDeprecated extends StatelessWidget {
  const StateSwitcherQuotationLevelDeprecated(
      {super.key, required this.retryQuotationLevelByMembership});
  final void Function()? retryQuotationLevelByMembership;

  static const getting = LevelStateDeprecated.getting;
  static const idle = LevelStateDeprecated.idle;
  static const accomplished = LevelStateDeprecated.accomplished;
  static const empty = LevelStateDeprecated.empty;
  static const unexpectedError = LevelStateDeprecated.unexpectedError;
  static const error = LevelStateDeprecated.error;
  static const animationLoading = AnimationStatesDeprecated.LOADING;
  static const animationFinish = AnimationStatesDeprecated.FINISH;

  double get mediumPadding => ConstantsDeprecated.mediumPadding;

  @override
  Widget build(BuildContext context) {
    final levelsBLoC = context.watch<LevelsBLoCDeprecated>();
    final quotationAnimatedState =
        context.watch<AnimationBLoCDeprecated>().quotationAnimatedState;
    final levelState = levelsBLoC.levelState;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (quotationAnimatedState == animationLoading ||
            levelState == getting ||
            levelState == idle)
          const Expanded(child: QuotationLoadingScreenDeprecated())
        else if (levelState == accomplished &&
            quotationAnimatedState == animationFinish)
          const Expanded(child: LevelDataQuotationDeprecated())
        else if (levelState == empty)
          PiixErrorScreenDeprecated(
            errorMessage: PiixCopiesDeprecated.emptyErrorQuotation,
            onTap: retryQuotationLevelByMembership,
          )
        else if (levelState == unexpectedError ||
            levelState == error ||
            levelState == LevelStateDeprecated.conflict ||
            levelState == LevelStateDeprecated.notFound)
          PiixErrorScreenDeprecated(
            errorMessage: PiixCopiesDeprecated.unexpectedErrorStore,
            onTap: retryQuotationLevelByMembership,
          )
      ],
    );
  }
}
