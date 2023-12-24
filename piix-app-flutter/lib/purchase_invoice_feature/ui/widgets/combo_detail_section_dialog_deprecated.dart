import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/bloc_deprecated/purchase_invoice_bloc_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/invoice_product_dialog_deprecated/invoice_product_dialog_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/widgets_deprecated/additional_benefit_expansion_tile_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_html_parser.dart';
import 'package:piix_mobile/store_feature/ui/package_combos/widgets/combo_suppliers_rich_text_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/package_combos/widgets/package_combo_tags_row_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget is a Combo Info Dialog,
///
class ComboDetailSectionDialogDeprecated extends StatelessWidget {
  const ComboDetailSectionDialogDeprecated({super.key});

  double get mediumPadding => ConstantsDeprecated.mediumPadding;

  @override
  Widget build(BuildContext context) {
    final purchaseInvoiceBLoC = context.read<PurchaseInvoiceBLoCDeprecated>();
    final currentInvoiceTicket = purchaseInvoiceBLoC.invoice;
    final currentPackageCombo = currentInvoiceTicket?.products.packageCombo;
    return InvoiceProductDialogDeprecated(
      child: SizedBox(
        width: context.width,
        height: context.height * 0.8,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                currentPackageCombo?.name ?? '',
                style: context.primaryTextTheme?.displayMedium,
              ),
              SizedBox(
                height: 12.h,
              ),
              //Render a combo info detail card
              PackageComboTagsRowDeprecated(
                additionalBenefitsPerSupplier:
                    currentPackageCombo?.additionalBenefitsPerSupplier ?? [],
                type: ComboRow.detail,
              ),
              SizedBox(
                height: 12.h,
              ),
              //Render a combo suppliers names
              ComboSuppliersRichTextDeprecated(
                packageCombo: currentPackageCombo!,
                isDetail: true,
              ),
              SizedBox(
                height: 4.h,
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
                    html: currentPackageCombo.description,
                  ),
                ),
              ),
              if (currentPackageCombo.additionalBenefitsPerSupplier.any(
                  (additionalBenefit) => additionalBenefit.hasBenefitForm)) ...[
                Padding(
                  padding: EdgeInsets.only(
                    right: 12.w,
                  ),
                  child: Text(
                    PiixCopiesDeprecated
                        .someAdditionalBenefitInComboHasBenefitForm,
                    style: context.primaryTextTheme?.labelMedium,
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
              ],
              Text(
                PiixCopiesDeprecated.comboBenefits,
                style: context.primaryTextTheme?.titleMedium,
              ),
              Card(
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: currentPackageCombo.additionalBenefitsPerSupplier
                        .map(
                          (additionalBenefit) => Theme(
                            data: Theme.of(context).copyWith(
                              dividerColor: Colors.transparent,
                              listTileTheme: ListTileTheme.of(context).copyWith(
                                dense: true,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Divider(
                                  color: PiixColors.secondaryLight,
                                  height: 0,
                                ),
                                AdditionalBenefitExpansionTileDeprecated(
                                  additionalBenefitPerSupplier:
                                      additionalBenefit,
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
