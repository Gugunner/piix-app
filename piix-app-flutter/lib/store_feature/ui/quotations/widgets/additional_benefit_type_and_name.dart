import 'package:flutter/material.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/additional_benefits_per_supplier_bloc_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a text with benefit type and beneift name
///
class AdditionalBenefitTypeAndNameDeprecated extends StatelessWidget {
  const AdditionalBenefitTypeAndNameDeprecated({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final additionalBenefitsPerSupplierBLoC =
        context.watch<AdditionalBenefitsPerSupplierBLoCDeprecated>();
    final currentAdditionalBenefitPerSupplier =
        additionalBenefitsPerSupplierBLoC.currentAdditionalBenefitPerSupplier;

    final benefitTypeName =
        currentAdditionalBenefitPerSupplier?.benefitType?.name ?? '';

    final benefitName = currentAdditionalBenefitPerSupplier?.benefit.name;
    return Text(
      '$benefitTypeName: $benefitName',
      style: context.primaryTextTheme?.headlineSmall,
    );
  }
}
