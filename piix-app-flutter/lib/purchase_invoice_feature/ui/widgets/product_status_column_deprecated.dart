import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_model.dart';

@Deprecated('Will be removed in 4.0')

///This colum contains a control status icon and texts
///
class ProductStatusColumnDeprecated extends StatelessWidget {
  const ProductStatusColumnDeprecated({
    Key? key,
    required this.invoice,
  }) : super(key: key);

  final InvoiceModel invoice;

  @override
  Widget build(BuildContext context) {
    final paymentColor = invoice.colorBy(InvoiceElementDeprecated.payment);
    final productLabel = invoice.userQuotation.productType.label;
    final productAdditionalStatusText = invoice.productAdditionalStatusText;
    final productYearStatusText = invoice.productYearStatusText;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          invoice.productStatusIcon,
          color: paymentColor,
        ),
        Text(
          '$productLabel ${invoice.productStatusText}',
          style: context.primaryTextTheme?.titleSmall?.copyWith(
            color: paymentColor,
          ),
        ),
        if (productAdditionalStatusText.isNotEmpty)
          Text(
            productAdditionalStatusText,
            style: context.textTheme?.bodyMedium?.copyWith(
              color: paymentColor,
            ),
            textAlign: TextAlign.center,
          ),
        if (productYearStatusText.isNotEmpty) ...[
          SizedBox(
            height: 4.h,
          ),
          Text(
            productYearStatusText,
            style: context.textTheme?.labelMedium?.copyWith(
              color: paymentColor,
            ),
          ),
        ]
      ],
    );
  }
}
