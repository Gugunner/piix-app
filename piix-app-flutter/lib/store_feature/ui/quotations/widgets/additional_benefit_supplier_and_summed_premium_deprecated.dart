import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/additional_benefits_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/widgets_deprecated/coverage_offer_description_widget_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a supplier and summed total premium for selected
///additional benefit per supplier id
///
class AdditionalBenefitSupplierAndSummedPremiumDeprecated
    extends StatelessWidget {
  const AdditionalBenefitSupplierAndSummedPremiumDeprecated({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final additionalBenefitsPerSupplierBLoC =
        context.watch<AdditionalBenefitsPerSupplierBLoCDeprecated>();
    final currentAdditionalBenefitPerSupplier =
        additionalBenefitsPerSupplierBLoC.currentAdditionalBenefitPerSupplier;
    if (currentAdditionalBenefitPerSupplier == null) return const SizedBox();
    final supplierName =
        currentAdditionalBenefitPerSupplier.supplier?.name ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${PiixCopiesDeprecated.supplier}: $supplierName',
          style: context.textTheme?.bodyMedium,
        ),
        CoverageOfferDescriptionWidgetDeprecated(
          coverageOfferType:
              currentAdditionalBenefitPerSupplier.coverageOfferType,
          coverageOfferValue:
              currentAdditionalBenefitPerSupplier.coverageOfferValue,
          hasCobenefits: currentAdditionalBenefitPerSupplier.hasCobenefits,
          textStyle: context.textTheme?.bodyMedium,
        ),
      ],
    );
  }
}
