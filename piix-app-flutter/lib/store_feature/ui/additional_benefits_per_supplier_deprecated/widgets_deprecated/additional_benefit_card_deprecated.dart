import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/additional_benefits_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/widgets_deprecated/benefit_tags_row_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/widgets_deprecated/quotation_button_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/widgets_deprecated/supplier_logo_container_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/widgets_deprecated/supplier_navigate_detail_row_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/details/additional_benefit_per_supplier_detail_screen_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_html_parser.dart';
import 'package:piix_mobile/store_feature/ui/widgets/pending_invoice_icon_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This card render a additional benefit per supplier,
///includes main info of benefit
///
class AdditionalBenefitCardDeprecated extends StatelessWidget {
  const AdditionalBenefitCardDeprecated({
    super.key,
    required this.additionalBenefitPerSupplier,
  });

  final BenefitPerSupplierModel additionalBenefitPerSupplier;

  void handleDetailNavigation(BuildContext context) {
    final additionalBenefitsPerSupplierBLoC =
        context.read<AdditionalBenefitsPerSupplierBLoCDeprecated>();
    additionalBenefitsPerSupplierBLoC
        .setCurrentAdditionalBenefitPerSupplier(additionalBenefitPerSupplier);
    NavigatorKeyState().getNavigator()?.pushNamed(
        AdditionalBenefitPerSupplierDetailScreenDeprecated.routeName);
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AdditionalBenefitsPerSupplierBLoCDeprecated>();
    final currentAdditionalBenefitPerSupplier =
        additionalBenefitPerSupplier.mapOrNull(
      (value) => null,
      additional: (value) => value,
    );
    return Card(
      elevation: 3,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 16.h),
            child: Column(
              children: [
                //This is a row with supplier logo and additional benefit name
                //and additional benefit tags
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: Row(
                    children: [
                      if (currentAdditionalBenefitPerSupplier?.supplier != null)
                        SuplierLogoContainerDeprecated(
                          supplier:
                              currentAdditionalBenefitPerSupplier!.supplier,
                        ),
                      Expanded(
                        child: Column(
                          children: [
                            //This is a name of additional benefit per supplier
                            Padding(
                              padding: EdgeInsets.only(bottom: 16.0.h),
                              child: GestureDetector(
                                onTap: () => handleDetailNavigation(context),
                                child: Text(
                                  additionalBenefitPerSupplier.benefit.name,
                                  style: context.textTheme?.headlineMedium,
                                ),
                              ),
                            ),
                            BenefitTagsRowDeprecated(
                              additionalBenefitPerSupplier:
                                  additionalBenefitPerSupplier,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                //This is a row of supplier name and detail button navigation
                Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 16.w, right: 16.w),
                  child: SupplierNavigateDetailRowDeprecated(
                    additionalBenefitPerSupplier: additionalBenefitPerSupplier,
                  ),
                ),
                //Render a wording zero
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0.w,
                  ),
                  child: PiixHtmlParser(
                    html: additionalBenefitPerSupplier.wordingZero,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 8.h,
                    bottom: 8.h,
                  ),
                  child: QuotationButtonDeprecated(
                    additionalBenefitPerSupplier: additionalBenefitPerSupplier,
                  ),
                ),
                if (currentAdditionalBenefitPerSupplier?.isAlreadyAcquired ??
                    false)
                  Text(
                    PiixCopiesDeprecated.alreadyAcquiredBenefit,
                    style: context.textTheme?.labelMedium?.copyWith(
                      color: PiixColors.primary,
                    ),
                  )
                else
                  Text(
                    PiixCopiesDeprecated.discoverPrice,
                    style: context.textTheme?.labelMedium?.copyWith(
                      color: PiixColors.primary,
                    ),
                  ),
                if (currentAdditionalBenefitPerSupplier?.isPartiallyAcquired ??
                    false)
                  Text(
                    PiixCopiesDeprecated.anyProtectedNoBenefit,
                    style: context.textTheme?.labelMedium?.copyWith(
                      color: PiixColors.process,
                    ),
                    textAlign: TextAlign.center,
                  ),
                if (currentAdditionalBenefitPerSupplier?.hasPendingInvoice ??
                    false)
                  Text(
                    PiixCopiesDeprecated.quoteAndPendingInvoice,
                    style: context.textTheme?.labelMedium?.copyWith(
                      color: PiixColors.process,
                    ),
                    textAlign: TextAlign.center,
                  )
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
