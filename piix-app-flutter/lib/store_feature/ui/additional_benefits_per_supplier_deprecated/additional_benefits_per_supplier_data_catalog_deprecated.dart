import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/utils/benefit_type_enum.dart';
import 'package:piix_mobile/membership_benefits_feature/domain/model/benefit_type_model.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/utils/branch_type_enum.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/additional_benefits_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/additional_benefit_list_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/widgets_deprecated/additional_benefis_type_grid_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/widgets_deprecated/title_with_button_row_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/widgets/image_card_button_deprecated.dart';
import 'package:piix_mobile/store_feature/utils/skeletons.dart';
import 'package:piix_mobile/store_feature/utils/store_copies.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget is the catalog of additional benefits, here the data from
/// the getAdditionalBenefitsPerSupplier service is shown
///
class AdditionalBenefitsPerSupplierDataCatalogDeprecated
    extends StatelessWidget {
  const AdditionalBenefitsPerSupplierDataCatalogDeprecated({super.key});

  double get benefitCardPadding => 21;

  void handleEverythingNavigate(BuildContext context) {
    final additionalBenefitsPerSupplierBLoC =
        context.read<AdditionalBenefitsPerSupplierBLoCDeprecated>();
    additionalBenefitsPerSupplierBLoC.currentBenefitType = BenefitTypeModel(
      name: PiixCopiesDeprecated.allBenefits,
      benefitType: BenefitType.N,
      branchType: BranchType.emergency,
    );
    NavigatorKeyState().getNavigator()?.pushNamed(
          AdditionalBenefitListScreenDeprecated.routeName,
        );
  }

  @override
  Widget build(BuildContext context) {
    final additionalBenefitsPerSupplierBLoC =
        context.watch<AdditionalBenefitsPerSupplierBLoCDeprecated>();
    final showAdditionalBenefitByTypeList = additionalBenefitsPerSupplierBLoC
        .additionalBenefitsPerSupplierByBenefitType;

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;
        return Container(
          margin: EdgeInsets.symmetric(
            vertical: maxHeight.percentageSize(0.030),
            horizontal: ConstantsDeprecated.mediumPadding.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //This is the component for special offers
              Padding(
                  padding:
                      EdgeInsets.only(bottom: maxHeight.percentageSize(0.031)),
                  child: Text(
                    PiixCopiesDeprecated.quoteIndividualBenefits,
                    style: context.textTheme?.headlineSmall,
                  )),
              //This is the component for combo image
              Padding(
                padding:
                    EdgeInsets.only(bottom: maxHeight.percentageSize(0.045)),
                child: ImageCardButtonDeprecated(
                  PiixAssets.additionalBenefitBanner,
                  width: maxWidth,
                  height: maxHeight.percentageSize(0.28),
                  onTap: () => {},
                ),
              ),
              if (showAdditionalBenefitByTypeList.length > 1)
                //This is the component for benefit types title
                Padding(
                  padding:
                      EdgeInsets.only(bottom: maxHeight.percentageSize(0.038)),
                  child: TitleWithButtonRowDeprecated(
                    title: PiixCopiesDeprecated.productsForYou,
                    labelButton: StoreCopiesDeprecated.viewBenefits,
                    onTap: () => handleEverythingNavigate(context),
                  ),
                ),
              //This is the component for benefit types cards
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: maxHeight.percentageSize(0.014),
                    left: benefitCardPadding.h,
                    right: benefitCardPadding.h,
                  ),
                  child: const AdditionalBenefitsTypeGridDeprecated(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
