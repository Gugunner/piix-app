import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_model.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/combo_detail_section_dialog_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_html_parser.dart';
import 'package:piix_mobile/store_feature/ui/package_combos/widgets/combo_suppliers_rich_text_deprecated.dart';

@Deprecated('Will be removed in 4.0')
class ComboDetailSectionDeprecated extends StatelessWidget {
  const ComboDetailSectionDeprecated({
    Key? key,
    required this.invoice,
  }) : super(key: key);

  final InvoiceModel invoice;

  @override
  Widget build(BuildContext context) {
    final currentPackageCombo = invoice.products.packageCombo;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${invoice.products.productName}',
          style: context.primaryTextTheme?.titleMedium,
        ),
        SizedBox(
          height: 4.h,
        ),
        PiixHtmlParser(
          html: currentPackageCombo?.description ?? '',
        ),
        ComboSuppliersRichTextDeprecated(
          packageCombo: currentPackageCombo!,
          isDetail: true,
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          PiixCopiesDeprecated.includedBenefits,
          style: context.primaryTextTheme?.titleMedium,
        ),
        ...currentPackageCombo.additionalBenefitsPerSupplier.map(
          (additionalBenefit) => Text(
            '• ${additionalBenefit.benefit.name}',
            style: context.textTheme?.bodyMedium,
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () => handleOpenComboDialog(context),
            child: Text(
              '${PiixCopiesDeprecated.viewThisCombo}',
              style: context.accentTextTheme?.headlineLarge?.copyWith(
                color: PiixColors.active,
              ),
            ),
          ),
        ),
        //Render a combo description,
      ],
    );
  }

  void handleOpenComboDialog(BuildContext context) => showDialog<void>(
        context: context,
        barrierColor: PiixColors.mainText.withOpacity(0.62),
        builder: (context) => const ComboDetailSectionDialogDeprecated(),
      );
}
