import 'package:flutter/material.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_model.dart';
import 'package:piix_mobile/purchase_invoice_feature/utils/product_type_enum_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/additional_benefit_detail_section_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/combo_detail_section_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/level_detail_section_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/plan_detail_section_deprecated.dart';

@Deprecated('Will be removed in 4.0')
class ProductInvoiceSelectorDeprecated extends StatelessWidget {
  const ProductInvoiceSelectorDeprecated({
    Key? key,
    required this.invoice,
  }) : super(key: key);

  final InvoiceModel invoice;

  @override
  Widget build(BuildContext context) {
    final productType = invoice.userQuotation.productType;
    switch (productType) {
      case ProductTypeDeprecated.ADDITIONAL:
        return AdditionalBenefitDetailSectionDeprecated(
          invoice: invoice,
        );
      case ProductTypeDeprecated.COMBO:
        return ComboDetailSectionDeprecated(
          invoice: invoice,
        );
      case ProductTypeDeprecated.PLAN:
        return PlanDetailSectionDeprecated(
          invoice: invoice,
        );
      case ProductTypeDeprecated.LEVEL:
        return LevelDetailSectionDeprecated(
          invoice: invoice,
        );
      default:
        return const SizedBox();
    }
  }
}
