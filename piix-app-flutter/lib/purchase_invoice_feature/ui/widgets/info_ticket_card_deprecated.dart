import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_model.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/product_status_column_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/date_and_payment_section_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/product_invoice_selector_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/purchase_detail_section_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/titular_section_deprecated.dart';

@Deprecated('Will be removed in 4.0')

/// This card contains all ticket info
class InfoTicketCardDeprecated extends StatelessWidget {
  const InfoTicketCardDeprecated({
    super.key,
    required this.invoice,
  });
  final InvoiceModel invoice;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: SizedBox(
        width: context.width,
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ProductStatusColumnDeprecated(
                  invoice: invoice,
                ),
              ),
              SizedBox(height: 16.h),
              const TitularSectionDeprecated(),
              DateAndPaymentSectionDeprecated(
                invoice: invoice,
              ),
              PurchaseDetailSectionDeprecated(
                invoice: invoice,
              ),
              Text(
                '${PiixCopiesDeprecated.detailOff} '
                '${invoice.userQuotation.productType.label}',
                style: context.textTheme?.headlineSmall?.copyWith(
                  color: PiixColors.primary,
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              ProductInvoiceSelectorDeprecated(
                invoice: invoice,
              ),
              SizedBox(
                height: 8.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
