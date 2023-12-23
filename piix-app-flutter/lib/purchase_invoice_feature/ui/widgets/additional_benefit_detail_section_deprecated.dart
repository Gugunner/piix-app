import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/ui/benefit_per_supplier_detail/benefit_per_supplier_detail_screen_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/utils/constants_deprecated/benefit_per_supplier_copies_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_model.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_html_parser.dart';
import 'package:provider/provider.dart';

import '../../../navigation_feature/utils/navigator_key_state.dart';

@Deprecated('Will be removed in 4.0')
class AdditionalBenefitDetailSectionDeprecated extends StatelessWidget {
  const AdditionalBenefitDetailSectionDeprecated({
    Key? key,
    required this.invoice,
  }) : super(key: key);

  final InvoiceModel invoice;

  @override
  Widget build(BuildContext context) {
    final additionalBenefitPerSupplier =
        invoice.products.additionalBenefitsPerSupplier?[0];
    if (additionalBenefitPerSupplier == null) return const SizedBox();
    final coverageOfferType = additionalBenefitPerSupplier.coverageOfferType;
    final coverageOfferValue = additionalBenefitPerSupplier.coverageOfferValue;
    final coverageText = BenefitPerSupplierCopiesDeprecated.coverageDescription(
      coverageOfferType,
      coverageOfferValue,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${additionalBenefitPerSupplier.benefitType?.name ?? ''}: '
          '${invoice.products.productName}',
          style: context.primaryTextTheme?.titleMedium,
        ),
        PiixHtmlParser(
          html: '''${additionalBenefitPerSupplier.wordingZero}''',
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${BenefitPerSupplierCopiesDeprecated.coverageTextType(
                  coverageOfferType,
                )}: ',
                style: context.primaryTextTheme?.titleSmall,
              ),
              TextSpan(
                text: coverageText,
                style: context.textTheme?.bodyMedium,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                  text: '${PiixCopiesDeprecated.supplier}: ',
                  style: context.primaryTextTheme?.titleSmall),
              TextSpan(
                text: additionalBenefitPerSupplier.supplier?.name ?? '',
                style: context.textTheme?.bodyMedium,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () => handleNavigateToBenefitDetail(context),
            child: Text(
              '${PiixCopiesDeprecated.viewThisBenefit}',
              style: context.accentTextTheme?.headlineLarge?.copyWith(
                color: PiixColors.active,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void handleNavigateToBenefitDetail(BuildContext context) {
    final benefitPerSupplierBLoC =
        context.read<BenefitPerSupplierBLoCDeprecated>();
    final additionalBenefitPerSupplier =
        invoice.products.additionalBenefitsPerSupplier?[0];
    if (additionalBenefitPerSupplier == null) return;
    final purchasedBenefitPerSupplier =
        additionalBenefitPerSupplier.toPurchasedModel();
    benefitPerSupplierBLoC
        .setSelectedAdditionalBenefitPerSupplier(purchasedBenefitPerSupplier);
    NavigatorKeyState()
        .getNavigator(context)
        ?.pushNamed(BenefitPerSupplierDetailScreenDeprecated.routeName);
  }
}
