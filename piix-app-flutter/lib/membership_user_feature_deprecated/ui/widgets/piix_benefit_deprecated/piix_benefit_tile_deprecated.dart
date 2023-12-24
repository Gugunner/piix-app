import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_form_provider.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/ui/benefit_form_screen_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/ui/benefit_per_supplier_detail/benefit_per_supplier_detail_screen_deprecated.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/general_app_feature/utils/responsive.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/utils/piix_memberships_util_deprecated.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/bloc/protected_provider.dart';
import 'package:piix_mobile/ui/common/piix_tag.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')
class PiixBenefitTileDeprecated extends ConsumerWidget {
  const PiixBenefitTileDeprecated({
    Key? key,
    required this.benefitPerSupplier,
  }) : super(key: key);

  final BenefitPerSupplierModel benefitPerSupplier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final benefitFormNotifier = ref.watch(benefitFormProvider);
    final benefitPerSupplierBLoC =
        context.watch<BenefitPerSupplierBLoCDeprecated>();
    final protectedBLoC = context.watch<ProtectedProvider>();
    final shouldBlockActions = protectedBLoC.shouldBlockMainUserActions;
    final screenSize = Responsive.of(context);
    final selectedBenefitPerSupplier =
        benefitPerSupplier.mapOrNull((value) => value);

    if (selectedBenefitPerSupplier == null) return const SizedBox();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            '${selectedBenefitPerSupplier.benefit.name}',
            style: context.textTheme?.bodyMedium,
          ),
        ),
        if (selectedBenefitPerSupplier.hasBenefitForm && !shouldBlockActions)
          Flexible(
            child: PiixTagDeprecated(
              text: getSignLabelFromBenefit(
                benefitPerSupplier,
              ),
              backgroundColor: getSignColorFromBenefit(
                benefitPerSupplier,
              ),
              action:
                  !selectedBenefitPerSupplier.userHasAlreadySignedTheBenefitForm
                      ? () {
                          benefitPerSupplierBLoC.selectedBenefitPerSupplierId =
                              selectedBenefitPerSupplier.benefitPerSupplierId;
                          benefitPerSupplierBLoC.setSelectedBenefitPerSupplier(
                            selectedBenefitPerSupplier,
                          );
                          benefitFormNotifier.currentBenefitFormId =
                              selectedBenefitPerSupplier.benefitFormId;
                          benefitPerSupplierBLoC.isCobenefit = false;
                          Navigator.of(context).pushNamed(
                            BenefitFormScreenDeprecated.routeName,
                          );
                        }
                      : null,
            ).padOnly(
              right: screenSize.wp(2),
              left: screenSize.wp(4),
            ),
          ),
        TextButton(
          onPressed: () async {
            benefitPerSupplierBLoC
              ..isCobenefit = false
              ..setSelectedBenefitPerSupplier(selectedBenefitPerSupplier);
            Navigator.of(context).pushNamed(
              BenefitPerSupplierDetailScreenDeprecated.routeName,
              arguments: benefitPerSupplier,
            );
          },
          style: Theme.of(context).textButtonTheme.style?.copyWith(
                visualDensity: VisualDensity.compact,
              ),
          child: Text(
            PiixCopiesDeprecated.viewText,
            style: context.primaryTextTheme?.titleMedium?.copyWith(
              color: PiixColors.active,
            ),
          ),
        )
      ],
    );
  }
}
