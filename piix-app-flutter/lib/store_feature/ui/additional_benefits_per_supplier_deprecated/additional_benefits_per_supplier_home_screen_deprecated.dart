import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_error_screen_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/store_feature/data/repository/additional_benefits_per_supplier/additional_benefits_per_supplier_repository_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/additional_benefits_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/additional_benefits_per_supplier_data_catalog_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/blank_slates_deprecated/blank_slate_store_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/additional_benefits_per_supplier_catalog_skeleton_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This screen is the main screen for additional benefits per supplier and combos
///render a grid of benefits per supplier and the image combo card
///
class AdditionalBenefitsPerSupplierHomeScreenDeprecated extends StatefulWidget {
  static const routeName = '/additional_benefit_per_supplier_home';
  const AdditionalBenefitsPerSupplierHomeScreenDeprecated({Key? key})
      : super(key: key);

  @override
  State<AdditionalBenefitsPerSupplierHomeScreenDeprecated> createState() =>
      _AdditionalBenefitsPerSupplierHomeScreenDeprecatedState();
}

class _AdditionalBenefitsPerSupplierHomeScreenDeprecatedState
    extends State<AdditionalBenefitsPerSupplierHomeScreenDeprecated> {
  final idle = AdditionalBenefitsPerSupplierStateDeprecated.idle;
  final getting = AdditionalBenefitsPerSupplierStateDeprecated.getting;
  final accomplished =
      AdditionalBenefitsPerSupplierStateDeprecated.accomplished;
  final empty = AdditionalBenefitsPerSupplierStateDeprecated.empty;
  final error = AdditionalBenefitsPerSupplierStateDeprecated.error;
  final unexpectedError =
      AdditionalBenefitsPerSupplierStateDeprecated.unexpectedError;
  final userNotMatch =
      AdditionalBenefitsPerSupplierStateDeprecated.userNotMatchError;

  Future<void> _initScreen() async {
    final additionalBenefitsPerSupplierBLoC =
        context.read<AdditionalBenefitsPerSupplierBLoCDeprecated>();
    final membershipBLoC = context.read<MembershipProviderDeprecated>();
    additionalBenefitsPerSupplierBLoC
        .getAdditionalBenefitsPerSupplierByMembership(
      membershipId: membershipBLoC.selectedMembership?.membershipId ?? '',
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async => _initScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final usefullScreenHeight = context.height - kToolbarHeight;
    final additionalBenefitsPerSupplierBLoC =
        context.watch<AdditionalBenefitsPerSupplierBLoCDeprecated>();
    final additionalBenefitPerSupplierState =
        additionalBenefitsPerSupplierBLoC.additionalBenefitPerSupplierState;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            PiixCopiesDeprecated.benefits,
            style: context.accentTextTheme?.displayMedium,
          ),
          centerTitle: true,
        ),
        body: SizedBox(
          height: usefullScreenHeight,
          width: context.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (additionalBenefitPerSupplierState == idle ||
                  additionalBenefitPerSupplierState == getting)
                const Expanded(
                  child:
                      AdditionalBenefitsPerSupplierCatalogSkeletonDeprecated(),
                )
              else if (additionalBenefitPerSupplierState == accomplished)
                const Expanded(
                  child: AdditionalBenefitsPerSupplierDataCatalogDeprecated(),
                )
              else if (additionalBenefitPerSupplierState == empty ||
                  additionalBenefitPerSupplierState ==
                      AdditionalBenefitsPerSupplierStateDeprecated.notFound)
                const BlankSlateStoreDeprecated(
                    label: PiixCopiesDeprecated.benefits)
              else if (additionalBenefitPerSupplierState == error ||
                  additionalBenefitPerSupplierState == unexpectedError ||
                  additionalBenefitPerSupplierState == userNotMatch)
                PiixErrorScreenDeprecated(
                  errorMessage: PiixCopiesDeprecated.unexpectedErrorStore,
                  onTap: () async {
                    await _initScreen();
                  },
                )
            ],
          ),
        ));
  }
}
