import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/package_combos_bloc.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_html_parser.dart';
import 'package:piix_mobile/store_feature/ui/package_combos/widgets/combo_suppliers_rich_text_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/package_combos/widgets/package_combo_tags_row_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/widgets/pending_invoice_icon_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This card render a main info for combo detail
///
class PackageComboInfoDetailCardDeprecated extends StatelessWidget {
  const PackageComboInfoDetailCardDeprecated({Key? key}) : super(key: key);

  double get mediumPadding => ConstantsDeprecated.mediumPadding;

  @override
  Widget build(BuildContext context) {
    final packageComboBLoC = context.read<PackageComboBLoC>();
    final currentPackageCombo =
        packageComboBLoC.currentPackageCombo?.mapOrNull((value) => value);
    final comboHasBenefitForm = currentPackageCombo!
        .additionalBenefitsPerSupplier
        .any((element) => element.hasBenefitForm);
    final lastPadding = currentPackageCombo.comboDiscount > 0 ? 12 : 6;
    return Card(
      elevation: 3,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(5))),
      child: Stack(
        children: [
          SizedBox(
            width: context.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(currentPackageCombo.name,
                        style: context.primaryTextTheme?.displayMedium)
                    .padHorizontal(mediumPadding.w)
                    .padVertical(12.h),
                //Render a combo info detail card
                PackageComboTagsRowDeprecated(
                  additionalBenefitsPerSupplier:
                      currentPackageCombo.additionalBenefitsPerSupplier,
                  type: ComboRow.detail,
                ).padHorizontal(mediumPadding.w).padBottom(mediumPadding.h),
                //Render a combo suppliers names
                ComboSuppliersRichTextDeprecated(
                  packageCombo: currentPackageCombo,
                  isDetail: true,
                ).padHorizontal(mediumPadding.w).padBottom(8.h),
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
                ).padHorizontal(mediumPadding.w),
                //Render a combo description
                PiixHtmlParser(
                  html: currentPackageCombo.description,
                  offsetX: 0,
                  offsetY: 0,
                ).padHorizontal(10.w),
                if (comboHasBenefitForm)
                  Text(
                    PiixCopiesDeprecated
                        .someAdditionalBenefitInComboHasBenefitForm,
                    style: context.primaryTextTheme?.labelLarge,
                  ).padHorizontal(mediumPadding.w).padBottom(lastPadding.h),
              ],
            ),
          ),
          if (currentPackageCombo.hasPendingInvoice)
            const Align(
              alignment: Alignment.topRight,
              child: PendingInvoiceIconDeprecated(),
            )
        ],
      ),
    );
  }
}
