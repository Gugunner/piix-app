import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/additional_benefits_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/widgets_deprecated/supplier_logo_container_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget contains a supplir info as supplier logo y supplier name
///
class SupplierInfoRowDeprecated extends StatelessWidget {
  const SupplierInfoRowDeprecated({
    super.key,
  });

  double get imageSize => 40;

  @override
  Widget build(BuildContext context) {
    final additionalBenefitsPerSupplierBLoC =
        context.watch<AdditionalBenefitsPerSupplierBLoCDeprecated>();
    final currentAdditionalBenefitPerSupplier =
        additionalBenefitsPerSupplierBLoC.currentAdditionalBenefitPerSupplier;
    return Row(
      children: [
        if (currentAdditionalBenefitPerSupplier?.supplier != null)
          SuplierLogoContainerDeprecated(
            supplier: currentAdditionalBenefitPerSupplier!.supplier!,
            imageHeight: imageSize.h,
            imageWidth: imageSize.w,
          ),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${PiixCopiesDeprecated.supplier}: ',
                  style: context.primaryTextTheme?.titleMedium,
                ),
                TextSpan(
                  text:
                      currentAdditionalBenefitPerSupplier?.supplier?.name ?? '',
                  style: context.textTheme?.bodyMedium,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
