import 'package:flutter/material.dart';
import 'package:flutter_html/src/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/bloc_deprecated/purchase_invoice_bloc_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/invoice_product_dialog_deprecated/invoice_product_dialog_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/widgets_deprecated/benefit_tags_row_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/widgets_deprecated/supplier_logo_container_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_html_parser.dart';
import 'package:piix_mobile/utils/extensions/list_extend.dart';
import 'package:provider/provider.dart';

///This widget is a Additional Benefit Info Dialog,
///
class AdditionalBenefitSectionDialog extends StatelessWidget {
  const AdditionalBenefitSectionDialog({super.key});

  double get mediumPadding => ConstantsDeprecated.mediumPadding;
  double get imageSize => 40;

  @override
  Widget build(BuildContext context) {
    final purchaseInvoiceBLoC = context.read<PurchaseInvoiceBLoCDeprecated>();
    final currentInvoiceTicket = purchaseInvoiceBLoC.invoice;
    final additionalBenefitsPerSupplier =
        currentInvoiceTicket?.products.additionalBenefitsPerSupplier;
    if (additionalBenefitsPerSupplier.isNullOrEmpty) return const SizedBox();
    final currentAdditionalBenefitPerSupplier =
        additionalBenefitsPerSupplier?[0];
    if (currentAdditionalBenefitPerSupplier == null) return const SizedBox();
    //TODO: Add pdf wording button
    return InvoiceProductDialogDeprecated(
      child: SizedBox(
        width: context.width,
        height: context.height * 0.6,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                currentAdditionalBenefitPerSupplier.benefit.name,
                style: context.primaryTextTheme?.displayMedium,
              ),
              SizedBox(
                height: 12.h,
              ),
              //Render a combo info detail card
              BenefitTagsRowDeprecated(
                additionalBenefitPerSupplier:
                    currentAdditionalBenefitPerSupplier,
              ),
              SizedBox(
                height: mediumPadding.h,
              ),
              //Render a combo suppliers names
              if (currentAdditionalBenefitPerSupplier.supplier != null)
                Row(
                  children: [
                    SuplierLogoContainerDeprecated(
                      supplier: currentAdditionalBenefitPerSupplier.supplier!,
                      imageHeight: imageSize,
                      imageWidth: imageSize,
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
                              text: currentAdditionalBenefitPerSupplier
                                      .supplier?.name ??
                                  '',
                              style: context.textTheme?.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              //Render a combo validity
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${PiixCopiesDeprecated.validity}: ',
                      style: context.primaryTextTheme?.titleMedium,
                    ),
                    TextSpan(
                      text: PiixCopiesDeprecated.yearValidity,
                      style: context.textTheme?.bodyMedium,
                    ),
                  ],
                ),
              ),
              //Render a combo description
              Flexible(
                flex: 3,
                child: SizedBox(
                  child: PiixHtmlParser(
                    html: currentAdditionalBenefitPerSupplier.wordingZero,
                    htmlStyle: {
                      'p': Style(
                        color: PiixColors.infoDefault,
                        fontFamily: 'Raleway',
                        fontSize: FontSize(
                          12.sp,
                        ),
                        letterSpacing: 0.1,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.justify,
                        lineHeight: LineHeight.em(
                          1,
                        ),
                      ),
                    },
                  ),
                ),
              ),
              if (currentAdditionalBenefitPerSupplier.hasBenefitForm)
                Text(
                  PiixCopiesDeprecated
                      .additionalBenefitPerSupplierHasBenefitForm,
                  style: context.primaryTextTheme?.labelMedium,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
