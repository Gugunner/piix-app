import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/int_extention.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_model.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/row_text_invoice_card_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This is a level coverage
///
class LevelCoverageInTicketDeprecated extends StatelessWidget {
  const LevelCoverageInTicketDeprecated({
    Key? key,
    required this.invoice,
  }) : super(key: key);

  final InvoiceModel invoice;

  @override
  Widget build(BuildContext context) {
    final comparisonInformation = invoice.products.level?.comparisonInformation;
    if (comparisonInformation == null) return const SizedBox();
    final allExistingBenefitsLength =
        comparisonInformation.existingBenefitsLength +
            comparisonInformation.existingAdditionalBenefitsLength;
    final newBenefitsLength = comparisonInformation.newBenefitsLength;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RowTextInvoiceCardDeprecated(
          leftText: '${PiixCopiesDeprecated.improvedLabel}: ',
          rightText: '$allExistingBenefitsLength beneficio'
              '${allExistingBenefitsLength.pluralWithS} '
              'y cobeneficio${allExistingBenefitsLength.pluralWithS}',
          leftStyle: context.primaryTextTheme?.titleSmall,
          rightStyle: context.textTheme?.bodyMedium,
        ),
        RowTextInvoiceCardDeprecated(
          leftText: '${PiixCopiesDeprecated.joinedLabel}: ',
          rightText: '$newBenefitsLength '
              'beneficio${newBenefitsLength.pluralWithS} '
              'nuevo${newBenefitsLength.pluralWithS}',
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
