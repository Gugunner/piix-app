import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/utils/constants_deprecated/benefit_per_supplier_copies_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_model.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/row_text_invoice_card_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This is a additional benefit coverage
///
class AdditionalBenefitCoverageInTicketDeprecated extends StatelessWidget {
  const AdditionalBenefitCoverageInTicketDeprecated({
    Key? key,
    required this.invoice,
  }) : super(key: key);

  final InvoiceModel invoice;

  @override
  Widget build(BuildContext context) {
    final currentAdditionalBenefitPerSupplier =
        invoice.products.additionalBenefitsPerSupplier?[0];
    if (currentAdditionalBenefitPerSupplier == null) return const SizedBox();
    final coverageOfferType =
        currentAdditionalBenefitPerSupplier.coverageOfferType;
    final coverageOfferValue =
        currentAdditionalBenefitPerSupplier.coverageOfferValue;
    return Column(
      children: [
        RowTextInvoiceCardDeprecated(
          leftText: '${PiixCopiesDeprecated.coverageType}:',
          rightText: BenefitPerSupplierCopiesDeprecated.coverageTextType(
              coverageOfferType),
          leftStyle: context.primaryTextTheme?.titleSmall,
          rightStyle: context.textTheme?.bodyMedium,
        ),
        SizedBox(
          height: 8.h,
        ),
        RowTextInvoiceCardDeprecated(
          leftText: '${PiixCopiesDeprecated.coverageValue}:',
          rightText: BenefitPerSupplierCopiesDeprecated.coverageDescription(
            coverageOfferType,
            coverageOfferValue,
          ),
          leftStyle: context.primaryTextTheme?.titleSmall,
          rightStyle: context.textTheme?.bodyMedium,
        ),
        SizedBox(
          height: 8.h,
        ),
      ],
    );
  }
}
