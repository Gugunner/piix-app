import 'package:flutter/material.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/utils/benefit_type_enum.dart';
import 'package:piix_mobile/membership_benefits_feature/domain/model/benefit_type_model.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/utils/branch_type_enum.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/additional_benefits_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/additional_benefit_list_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/widgets/additional_benefit_card_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widgetuse the showAdditionalBenefitByTypeList to render the grid for
///the additional benefit types
///
class AdditionalBenefitsTypeGridDeprecated extends StatelessWidget {
  const AdditionalBenefitsTypeGridDeprecated({Key? key}) : super(key: key);

  void handleAllAdditionalBenefitsOnTap(BuildContext context) {
    final additionalBenefitsPerSupplierBLoC =
        context.read<AdditionalBenefitsPerSupplierBLoCDeprecated>();
    additionalBenefitsPerSupplierBLoC.currentBenefitType = BenefitTypeModel(
      name: PiixCopiesDeprecated.allBenefits,
      benefitType: BenefitType.N,
      branchType: BranchType.emergency,
    );
    handleAdditionalBenefitNavigation();
  }

  void handleBenefitOnTap(BuildContext context, {int index = 0}) {
    final additionalBenefitsPerSupplierBLoC =
        context.read<AdditionalBenefitsPerSupplierBLoCDeprecated>();
    final showAdditionalBenefitByTypeList = additionalBenefitsPerSupplierBLoC
        .additionalBenefitsPerSupplierByBenefitType;
    additionalBenefitsPerSupplierBLoC.currentBenefitType =
        showAdditionalBenefitByTypeList[index].first.benefitType;
    handleAdditionalBenefitNavigation();
  }

  @override
  Widget build(BuildContext context) {
    final additionalBenefitsPerSupplierBLoC =
        context.watch<AdditionalBenefitsPerSupplierBLoCDeprecated>();
    final showAdditionalBenefitByTypeList = additionalBenefitsPerSupplierBLoC
        .additionalBenefitsPerSupplierByBenefitType;
    final showAdditionalBenefitslistLength =
        showAdditionalBenefitByTypeList.length;

    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 0,
      crossAxisSpacing: 0,
      padding: EdgeInsets.zero,
      clipBehavior: Clip.none,
      children: [
        ...List.generate(
          showAdditionalBenefitslistLength,
          (index) {
            if (showAdditionalBenefitByTypeList[index].isEmpty) {
              return const SizedBox();
            }
            final currentBenefitTypeName =
                showAdditionalBenefitByTypeList[index]
                        .first
                        .benefitType
                        ?.name ??
                    '';
            //This is a benefit by type card, sets the type of additional
            //benefit according to the index
            return AdditionalBenefitCardDeprecated(
              name: currentBenefitTypeName,
              textColor: PiixColors.white,
              onTap: () {
                handleBenefitOnTap(
                  context,
                  index: index,
                );
              },
            );
          },
        ),
        if (showAdditionalBenefitslistLength > 1)
          //This widget is a card for "todos los beneficios"
          //this card set all aditional benefits per supplier type
          AdditionalBenefitCardDeprecated(
            onTap: () => handleAllAdditionalBenefitsOnTap(context),
            name: PiixCopiesDeprecated.everything,
            textColor: PiixColors.mainText,
            iconColor: PiixColors.cardTotalIcon,
          )
      ],
    );
  }

  void handleAdditionalBenefitNavigation() => NavigatorKeyState()
      .getNavigator()
      ?.pushNamed(AdditionalBenefitListScreenDeprecated.routeName);
}
