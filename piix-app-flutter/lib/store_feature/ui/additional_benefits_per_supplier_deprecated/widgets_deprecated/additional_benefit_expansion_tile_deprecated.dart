import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/ui/benefit_per_supplier_detail/benefit_per_supplier_detail_screen_deprecated.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/additional_benefits_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/widgets_deprecated/benefit_tags_row_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/widgets_deprecated/supplier_rich_text_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_html_parser.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a expansion tile for additional benefit per supplier
///
class AdditionalBenefitExpansionTileDeprecated extends StatelessWidget {
  const AdditionalBenefitExpansionTileDeprecated({
    Key? key,
    required this.additionalBenefitPerSupplier,
  }) : super(key: key);
  final BenefitPerSupplierModel additionalBenefitPerSupplier;

  double get mediumPadding => ConstantsDeprecated.mediumPadding;

  @override
  Widget build(BuildContext context) {
    context.watch<AdditionalBenefitsPerSupplierBLoCDeprecated>();
    return ExpansionTile(
      initiallyExpanded: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (additionalBenefitPerSupplier.isAlreadyAcquired)
            Container(
              height: 35.h,
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              margin: EdgeInsets.only(right: 4.w),
              color: PiixColors.successMain,
              child: const Icon(
                Icons.check_circle,
                size: 12,
                color: PiixColors.white,
              ),
            ),
          Flexible(
            child: Text(
              additionalBenefitPerSupplier.benefit.name,
              style: context.textTheme?.bodyMedium,
            ),
          ),
        ],
      ),
      tilePadding: additionalBenefitPerSupplier.isAlreadyAcquired
          ? EdgeInsets.only(
              right: 8.w,
            )
          : null,
      childrenPadding: EdgeInsets.symmetric(
        horizontal: mediumPadding.w,
      ),
      collapsedIconColor: PiixColors.activeButton,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Render a benefit tags
        BenefitTagsRowDeprecated(
          additionalBenefitPerSupplier: additionalBenefitPerSupplier,
          reverse: true,
        ),
        SizedBox(
          height: 8.h,
        ),
        PiixHtmlParser(
          html: additionalBenefitPerSupplier.wordingZero,
        ),
        //Render a name of supplier
        SupplierRichTextDeprecated(
          supplierName: additionalBenefitPerSupplier.supplier?.name ?? '',
        ),
        SizedBox(
          height: 12.h,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () => handleNavigateToBenefitDetail(context),
            child: Text(
              '${PiixCopiesDeprecated.viewThisBenefit}',
              style: context.accentTextTheme?.headlineLarge?.copyWith(
                color: PiixColors.active,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
      ],
    );
  }

  void handleNavigateToBenefitDetail(BuildContext context) {
    final benefitPerSupplierBLoC =
        context.read<BenefitPerSupplierBLoCDeprecated>();
    if (additionalBenefitPerSupplier.supplier == null) return;
    final purchasedBenefitPerSupplier =
        additionalBenefitPerSupplier.toPurchasedModel();
    benefitPerSupplierBLoC
        .setSelectedAdditionalBenefitPerSupplier(purchasedBenefitPerSupplier);
    NavigatorKeyState()
        .getNavigator(context)
        ?.pushNamed(BenefitPerSupplierDetailScreenDeprecated.routeName);
  }
}
