import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/image_memory_button.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/ui/common/validity_row_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget shows all supplier information, name and logo.
class SupplierRowDeprecated extends StatelessWidget {
  const SupplierRowDeprecated({
    super.key,
    this.isLoading = false,
  });
  final bool isLoading;
  double get imageSize => 55.w;
  @override
  Widget build(BuildContext context) {
    final benefitPerSupplierBLoC =
        context.watch<BenefitPerSupplierBLoCDeprecated>();
    final supplierName = benefitPerSupplierBLoC.supplierName;
    final supplierLogo = benefitPerSupplierBLoC.supplierLogo;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(12)),
      child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              '${PiixCopiesDeprecated.supplier.toUpperCase()} ',
                          style: context.textTheme?.labelMedium,
                        ),
                        TextSpan(
                          text: supplierName,
                          style: context.textTheme?.labelMedium,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const ValidityRowDeprecated(),
                ],
              ),
            ),
            ImageMemoryButton(
              imageMemory: base64Decode(supplierLogo ?? ''),
              placeholder: PiixAssets.placeholderProv,
              width: imageSize,
              height: imageSize,
              boxFit: BoxFit.contain,
              hasCircularImage: true,
              isLoading: isLoading,
            )
          ]),
    );
  }
}
