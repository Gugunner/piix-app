import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/additional_benefits_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/additional_benefit_quotation_home_screen_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This button includes navigation to quote screen
///
class QuotationButtonDeprecated extends StatelessWidget {
  const QuotationButtonDeprecated({
    Key? key,
    required this.additionalBenefitPerSupplier,
  }) : super(key: key);
  final BenefitPerSupplierModel? additionalBenefitPerSupplier;

  void handleQuoteNavigation(BuildContext context) {
    final additionalBenefitsPerSupplierBLoC =
        context.read<AdditionalBenefitsPerSupplierBLoCDeprecated>();
    additionalBenefitsPerSupplierBLoC
        .setCurrentAdditionalBenefitPerSupplier(additionalBenefitPerSupplier);
    NavigatorKeyState()
        .getNavigator(context)
        ?.pushNamed(AdditionalBenefitQuotationHomeScreenDeprecated.routeName);
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AdditionalBenefitsPerSupplierBLoCDeprecated>();

    final buttonText =
        additionalBenefitPerSupplier?.isPartiallyAcquired ?? false
            ? PiixCopiesDeprecated.quoteToProtectedLabel.toUpperCase()
            : PiixCopiesDeprecated.quoteButtonLabel.toUpperCase();
    return SizedBox(
      height: 32.h,
      width: context.width * 0.579,
      child: ElevatedButton(
        onPressed:
            !(additionalBenefitPerSupplier?.isPartiallyAcquired ?? false) &&
                    (additionalBenefitPerSupplier?.isAlreadyAcquired ?? false)
                ? null
                : () => handleQuoteNavigation(context),
        child: Text(
          buttonText,
          style: context.accentTextTheme?.labelMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
