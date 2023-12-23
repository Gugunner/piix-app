import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/data/repository/benefit_per_supplier_repository.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/ui/benefit_per_supplier_detail/cobenefit_list_loading_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/ui/benefit_per_supplier_detail/cobenefit_tile_data_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget shows a list of cobenefits for benefit.
class CobenefitListTilesDeprecated extends StatelessWidget {
  const CobenefitListTilesDeprecated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final benefitPerSupplierBLoC =
        context.watch<BenefitPerSupplierBLoCDeprecated>();
    final benefitPerSupplier =
        benefitPerSupplierBLoC.selectedBenefitPerSupplier;
    final cobenefitList = benefitPerSupplier?.cobenefitsPerSupplier ?? [];
    final isLoading = benefitPerSupplierBLoC.benefitPerSupplierState ==
        BenefitPerSupplierStateDeprecated.retrieving;
    final hasCobenefits = benefitPerSupplier?.hasCobenefits ?? false;

    if (!hasCobenefits) return const SizedBox();

    return Container(
      margin: const EdgeInsets.only(bottom: 30.0),
      child: Card(
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            listTileTheme: ListTileTheme.of(context).copyWith(
              dense: true,
            ),
          ),
          child: ExpansionTile(
            initiallyExpanded: true,
            title: Text(
              PiixCopiesDeprecated.coBenefits,
              style: context.textTheme?.headlineSmall,
            ),
            children: <Widget>[
              if (isLoading)
                CobenefitListLoadingDeprecated(
                  isLoading: isLoading,
                )
              else
                ...cobenefitList.map(
                  (cobenefit) => CobenefitTileDataDeprecated(
                    cobenefit: cobenefit,
                  ),
                ),
              SizedBox(
                height: 16.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
