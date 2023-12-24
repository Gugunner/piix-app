import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/additional_benefits_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/details/additional_benefit_per_supplier_detail_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/widgets/store_text_button.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a rich text with supplier name info, and a navigate button
/// to detail screen
///
class SupplierNavigateDetailRowDeprecated extends StatelessWidget {
  const SupplierNavigateDetailRowDeprecated({
    super.key,
    required this.additionalBenefitPerSupplier,
  });
  final BenefitPerSupplierModel additionalBenefitPerSupplier;

  @override
  Widget build(BuildContext context) {
    final additionalBenefitsPerSupplierBLoC =
        context.read<AdditionalBenefitsPerSupplierBLoCDeprecated>();

    void handleDetailNavigation() {
      additionalBenefitsPerSupplierBLoC
          .setCurrentAdditionalBenefitPerSupplier(additionalBenefitPerSupplier);
      NavigatorKeyState().getNavigator()?.pushNamed(
          AdditionalBenefitPerSupplierDetailScreenDeprecated.routeName);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: '${PiixCopiesDeprecated.supplier}: ',
              style: context.primaryTextTheme?.titleMedium,
            ),
            TextSpan(
              text: additionalBenefitPerSupplier.supplier?.name ?? '',
              style: context.textTheme?.bodyMedium,
            ),
          ])),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.0.w),
          child: StoreTextButtonDeprecated(
            label: PiixCopiesDeprecated.knowMore.toUpperCase(),
            onTap: handleDetailNavigation,
          ),
        )
      ],
    );
  }
}
