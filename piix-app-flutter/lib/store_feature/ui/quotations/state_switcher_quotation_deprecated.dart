import 'package:flutter/material.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/store_feature/utils/store_module_enum_deprecated.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/animation_bloc_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_error_screen_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/additional_benefits_data_quotation_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/loaders/quotation_loading_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/package_combo_data_quotation_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget is a general state quotation ui switcher
///
class StateSwitcherQuotationDeprecated extends StatelessWidget {
  const StateSwitcherQuotationDeprecated({
    super.key,
    required this.retryQuotation,
    required this.quotationState,
    required this.module,
  });
  final void Function()? retryQuotation;
  final GeneralQuotationStateDeprecated quotationState;
  final StoreModuleDeprecated module;

  GeneralQuotationStateDeprecated get idle =>
      GeneralQuotationStateDeprecated.idle;
  GeneralQuotationStateDeprecated get getting =>
      GeneralQuotationStateDeprecated.getting;
  GeneralQuotationStateDeprecated get accomplished =>
      GeneralQuotationStateDeprecated.accomplished;
  GeneralQuotationStateDeprecated get empty =>
      GeneralQuotationStateDeprecated.empty;
  GeneralQuotationStateDeprecated get error =>
      GeneralQuotationStateDeprecated.error;
  GeneralQuotationStateDeprecated get unexpectedError =>
      GeneralQuotationStateDeprecated.unexpectedError;
  AnimationStatesDeprecated get animationLoading =>
      AnimationStatesDeprecated.LOADING;
  AnimationStatesDeprecated get animationFinish =>
      AnimationStatesDeprecated.FINISH;

  double get mediumPadding => ConstantsDeprecated.mediumPadding;

  @override
  Widget build(BuildContext context) {
    final quotationAnimatedState =
        context.watch<AnimationBLoCDeprecated>().quotationAnimatedState;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (quotationAnimatedState == animationLoading ||
            quotationState == getting ||
            quotationState == idle)
          const Expanded(child: QuotationLoadingScreenDeprecated())
        else if (quotationState == accomplished &&
            quotationAnimatedState == animationFinish)
          Expanded(child: dataWidget)
        else if (quotationState == empty)
          PiixErrorScreenDeprecated(
            errorMessage: PiixCopiesDeprecated.emptyErrorQuotation,
            onTap: retryQuotation,
          )
        else if (quotationState == unexpectedError ||
            quotationState == error ||
            quotationState == GeneralQuotationStateDeprecated.conflict ||
            quotationState == GeneralQuotationStateDeprecated.notFound)
          PiixErrorScreenDeprecated(
            errorMessage: PiixCopiesDeprecated.unexpectedErrorStore,
            onTap: retryQuotation,
          )
      ],
    );
  }

  Widget get dataWidget {
    switch (module) {
      case StoreModuleDeprecated.additionalBenefit:
        return const AdditionalBenefitsDataQuotationDeprecated();
      case StoreModuleDeprecated.combo:
        return const PackageComboDataQuotationDeprecated();
      default:
        return const SizedBox();
    }
  }
}
