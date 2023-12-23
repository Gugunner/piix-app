import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_model.dart';
import 'package:piix_mobile/purchase_invoice_feature/utils/product_type_enum_deprecated.dart';
import 'package:piix_mobile/extensions/currency_extends.dart';
import 'package:piix_mobile/extensions/date_extend_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/additional_benefit_coverage_in_ticket_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/breakdown_ticket_benefits_expansion_list_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/breakdown_ticket_discount_expansion_list_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/level_coverage_in_ticket_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/row_text_invoice_card_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/protected_quantity_model.dart';

@Deprecated('Will be removed in 4.0')
class PurchaseDetailSectionDeprecated extends StatelessWidget {
  const PurchaseDetailSectionDeprecated({
    Key? key,
    required this.invoice,
  }) : super(key: key);
  final InvoiceModel invoice;

  @override
  Widget build(BuildContext context) {
    final fromDateText = '${invoice.approvedDate?.dateFormatTime ?? ''}';
    final toDateText = addYearsAndFormat(invoice.approvedDate, 1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          PiixCopiesDeprecated.purchaseDetail,
          style: context.textTheme?.headlineSmall?.copyWith(
            color: PiixColors.primary,
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          '${invoice.userQuotation.productType.label}: '
          '${invoice.products.productName}',
          style: context.primaryTextTheme?.titleMedium,
        ),
        SizedBox(
          height: 8.h,
        ),
        if (invoice.userQuotation.productType == ProductTypeDeprecated.LEVEL)
          LevelCoverageInTicketDeprecated(
            invoice: invoice,
          ),
        if (fromDateText.isNotEmpty)
          RowTextInvoiceCardDeprecated(
            leftText: '${PiixCopiesDeprecated.fromValidity}',
            rightText: fromDateText,
            leftStyle: context.primaryTextTheme?.titleSmall,
            rightStyle: context.textTheme?.bodyMedium,
          ),
        if (toDateText.isNotEmpty) ...[
          SizedBox(
            height: 8.h,
          ),
          RowTextInvoiceCardDeprecated(
            leftText: '${PiixCopiesDeprecated.validityUntil}:',
            rightText: toDateText,
            leftStyle: context.primaryTextTheme?.titleSmall,
            rightStyle: context.textTheme?.bodyMedium,
          ),
        ],
        SizedBox(
          height: 8.h,
        ),
        if (invoice.userQuotation.productType ==
            ProductTypeDeprecated.ADDITIONAL)
          AdditionalBenefitCoverageInTicketDeprecated(
            invoice: invoice,
          ),
        if (invoice.userQuotation.productType !=
            ProductTypeDeprecated.PLAN) ...[
          RowTextInvoiceCardDeprecated(
            leftText: '${PiixCopiesDeprecated.personProtected}: ',
            rightText: invoice.protectedQuantityInCoverage.protectedInCoverage,
            leftStyle: context.primaryTextTheme?.titleSmall,
            rightStyle: context.textTheme?.bodyMedium,
          ),
          SizedBox(
            height: 8.h,
          ),
        ],
        RowTextInvoiceCardDeprecated(
          leftText: '${PiixCopiesDeprecated.totalAmount}:',
          rightText: '${ConstantsDeprecated.moneySymbol}'
              '''${(invoice.userQuotation.totalPremium + invoice.userQuotation.totalDiscountAmount).currencyFormat} '''
              '${ConstantsDeprecated.mxn}',
          leftStyle: context.primaryTextTheme?.titleSmall,
          rightStyle: context.textTheme?.bodyMedium,
        ),
        Text(
          PiixCopiesDeprecated.withoutDiscount,
          style: context.textTheme?.labelMedium,
        ),
        SizedBox(
          height: 8.h,
        ),
        RowTextInvoiceCardDeprecated(
          leftText: '${PiixCopiesDeprecated.totalDiscount}:',
          rightText: '${ConstantsDeprecated.moneySymbol}'
              '${(invoice.userQuotation.totalDiscountAmount).currencyFormat} '
              '${ConstantsDeprecated.mxn}',
          leftStyle: context.primaryTextTheme?.titleSmall,
          rightStyle: context.textTheme?.bodyMedium,
        ),
        Text(
          '${PiixCopiesDeprecated.discountOf} '
          '${invoice.percentageFinalDiscount.toStringAsFixed(2)}%',
          style: context.textTheme?.labelMedium,
        ),
        SizedBox(
          height: 8.h,
        ),
        RowTextInvoiceCardDeprecated(
          leftText: '${PiixCopiesDeprecated.totalToPay}:',
          rightText: '${ConstantsDeprecated.moneySymbol}'
              '${(invoice.userQuotation.totalPremium).currencyFormat} '
              '${ConstantsDeprecated.mxn}',
          leftStyle: context.primaryTextTheme?.titleSmall,
          rightStyle: context.textTheme?.bodyMedium,
        ),
        Text(
          '${PiixCopiesDeprecated.withLabel} '
          '${invoice.percentageFinalDiscount.toStringAsFixed(2)}% '
          '${PiixCopiesDeprecated.ofDiscount}',
          style: context.textTheme?.labelMedium,
        ),
        SizedBox(
          height: 12.h,
        ),
        Text(
          PiixCopiesDeprecated.ratesChanged,
          style: context.accentTextTheme?.bodySmall?.copyWith(
            color: PiixColors.infoDefault,
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        Card(
          elevation: 3,
          child: Column(
            children: [
              BreakdownTicketDiscountExpansionListDeprecated(
                invoice: invoice,
              ),
              if (invoice.userQuotation.productType ==
                  ProductTypeDeprecated.COMBO)
                BreakdownTicketBenefitsExpansionListDeprecated(
                  additionalBenefits: invoice.products.packageCombo
                          ?.additionalBenefitsPerSupplier ??
                      [],
                ),
            ],
          ),
        ),
        Divider(height: 32.h),
      ],
    );
  }
}
