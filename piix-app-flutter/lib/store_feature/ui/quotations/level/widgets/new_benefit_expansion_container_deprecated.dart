import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/levels_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/widgets_deprecated/coverage_offer_description_widget_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/level/widgets/new_benefit_info_item_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget contains an animated container with new benefit main info and
///detailed info
///
class NewBenefitExpansionContainerDeprecated extends StatefulWidget {
  const NewBenefitExpansionContainerDeprecated({
    super.key,
    required this.index,
    required this.benefitPerSupplier,
  });
  final int index;
  final BenefitPerSupplierModel benefitPerSupplier;

  @override
  State<NewBenefitExpansionContainerDeprecated> createState() =>
      _NewBenefitExpansionContainerDeprecatedState();
}

class _NewBenefitExpansionContainerDeprecatedState
    extends State<NewBenefitExpansionContainerDeprecated> {
  bool showDetailBenefit = false;

  @override
  Widget build(BuildContext context) {
    final newBenefitsLength = context
        .watch<LevelsBLoCDeprecated>()
        .levelQuotation!
        .comparisonInformation
        .newBenefitsLength;
    final padBottom = widget.index == newBenefitsLength ? 8 : 0;
    final showDetailPad = showDetailBenefit ? 8 : 0;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: context.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ConstantsDeprecated.mediumPadding.w,
            ),
            child: ColoredBox(
              color: PiixColors.greyWhite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.benefitPerSupplier.benefit.name,
                    style: context.textTheme?.bodyMedium,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CoverageOfferDescriptionWidgetDeprecated(
                        coverageOfferType:
                            widget.benefitPerSupplier.coverageOfferType,
                        coverageOfferValue:
                            widget.benefitPerSupplier.coverageOfferValue,
                        hasCobenefits: widget.benefitPerSupplier.hasCobenefits,
                      ),
                      InkWell(
                        onTap: handleShowDetail,
                        child: Text(
                          showDetailBenefit
                              ? PiixCopiesDeprecated.viewLessText
                              : PiixCopiesDeprecated.viewMoreText,
                          style:
                              context.primaryTextTheme?.titleMedium?.copyWith(
                            color: PiixColors.active,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: showDetailPad.h,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: padBottom.h,
          ),
          Visibility(
            visible: showDetailBenefit,
            child: NewBenefitInfoItemDeprecated(
              benefitPerSupplier: widget.benefitPerSupplier,
              showDetailBenefit: showDetailBenefit,
              handleShowDetail: handleShowDetail,
            ),
          ),
          if (widget.index < newBenefitsLength)
            const Divider(
              thickness: 1,
              color: PiixColors.secondaryLight,
            )
        ],
      ),
    );
  }

  void handleShowDetail() {
    setState(() {
      showDetailBenefit = !showDetailBenefit;
    });
  }
}
