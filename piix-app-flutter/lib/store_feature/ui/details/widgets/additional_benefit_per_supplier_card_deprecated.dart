import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/additional_benefits_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/widgets_deprecated/benefit_tags_row_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/widgets_deprecated/quotation_button_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/widgets_deprecated/supplier_info_row_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_html_parser.dart';
import 'package:piix_mobile/store_feature/ui/widgets/pending_invoice_icon_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/widgets/store_text_button.dart';
import 'package:piix_mobile/ui/pdf/pdf_screen.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget render additional benefit per supplier card, contains name,
///tags row, supplier row, validity, description, navigate to conditions screen
///and navigate to quotation screen
///
class AdditionalBenefitPerSupplierCardDeprecated extends StatelessWidget {
  const AdditionalBenefitPerSupplierCardDeprecated({
    super.key,
  });

  double get paddingTop => 4;
  double get horizontalPadding => 16;

  void handlePDFNavigation(BuildContext context) {
    final additionalBenefitsPerSupplierBLoC =
        context.read<AdditionalBenefitsPerSupplierBLoCDeprecated>();
    Navigator.pushNamed(
      context,
      PDFDetailScreen.routeName,
      arguments: additionalBenefitsPerSupplierBLoC
          .currentAdditionalBenefitPerSupplier?.pdfWordingMemory,
    );
  }

  @override
  Widget build(BuildContext context) {
    final additionalBenefitsPerSupplierBLoC =
        context.watch<AdditionalBenefitsPerSupplierBLoCDeprecated>();
    final currentAdditionalBenefitPerSupplier =
        additionalBenefitsPerSupplierBLoC.currentAdditionalBenefitPerSupplier;
    final hasPDFNavigate = additionalBenefitsPerSupplierBLoC
            .currentAdditionalBenefitPerSupplier?.pdfWordingMemory !=
        null;
    return Card(
      elevation: 3,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: horizontalPadding.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //This is a benefit name
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                  child: Text(
                    currentAdditionalBenefitPerSupplier?.benefit.name ?? '',
                    style: context.primaryTextTheme?.displayMedium?.copyWith(
                      color: PiixColors.mainText,
                      height: 16.sp / 16.sp,
                    ),
                  ),
                ),
                //This is a benefit tags row
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: paddingTop.h, horizontal: horizontalPadding.w),
                  child: BenefitTagsRowDeprecated(
                    additionalBenefitPerSupplier:
                        currentAdditionalBenefitPerSupplier,
                  ),
                ),
                //This is a supplier row
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                  child: const SupplierInfoRowDeprecated(),
                ),
                //This a validity text
                Padding(
                  padding: EdgeInsets.only(
                    top: paddingTop.h,
                    left: horizontalPadding.w,
                    right: horizontalPadding.w,
                    bottom: 4.h,
                  ),
                  child: Text.rich(
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
                ),
                //This a description text
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 9.w),
                  child: PiixHtmlParser(
                    html:
                        currentAdditionalBenefitPerSupplier?.wordingZero ?? '',
                  ),
                ),
                if (currentAdditionalBenefitPerSupplier?.hasBenefitForm ??
                    false)
                  Text(
                    PiixCopiesDeprecated
                        .additionalBenefitPerSupplierHasBenefitForm,
                    style: context.primaryTextTheme?.labelMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ).padHorizontal(horizontalPadding.w),
                //This button navigate to pdf screen
                if (hasPDFNavigate)
                  Padding(
                    padding: EdgeInsets.only(
                        top: paddingTop.h, left: horizontalPadding.h),
                    child: StoreTextButtonDeprecated(
                      label: PiixCopiesDeprecated.viewConditionsText,
                      style: context.textTheme?.labelLarge?.copyWith(
                        color: PiixColors.active,
                      ),
                      onTap: hasPDFNavigate
                          ? () => handlePDFNavigation(context)
                          : null,
                    ),
                  ),
                //This button navigate to quotation screen
                Padding(
                  padding: EdgeInsets.only(
                    top: 24.h,
                    bottom: 8.h,
                  ),
                  child: Center(
                    child: QuotationButtonDeprecated(
                      additionalBenefitPerSupplier:
                          currentAdditionalBenefitPerSupplier,
                    ),
                  ),
                ),
                //This a discover price and cover text
                if (currentAdditionalBenefitPerSupplier?.isAlreadyAcquired ??
                    false)
                  Center(
                    child: Text(
                      PiixCopiesDeprecated.alreadyAcquiredBenefit,
                      style: context.textTheme?.labelMedium?.copyWith(
                        color: PiixColors.primary,
                      ),
                    ),
                  )
                else
                  Center(
                    child: Text(
                      PiixCopiesDeprecated.discoverPrice,
                      style: context.textTheme?.labelMedium?.copyWith(
                        color: PiixColors.primary,
                      ),
                    ),
                  ),
                if (currentAdditionalBenefitPerSupplier?.hasPendingInvoice ??
                    false)
                  Center(
                    child: Text(
                      PiixCopiesDeprecated.quoteAndPendingInvoice,
                      style: context.textTheme?.labelMedium?.copyWith(
                        color: PiixColors.process,
                      ),
                    ),
                  ),

                if (currentAdditionalBenefitPerSupplier?.isPartiallyAcquired ??
                    false)
                  Center(
                    child: Text(
                      PiixCopiesDeprecated.anyProtectedNoBenefit,
                      style: context.textTheme?.labelMedium?.copyWith(
                        color: PiixColors.process,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (currentAdditionalBenefitPerSupplier?.hasPendingInvoice ?? false)
            const Align(
              alignment: Alignment.topRight,
              child: PendingInvoiceIconDeprecated(),
            )
        ],
      ),
    );
  }
}
