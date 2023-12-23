import 'package:flutter/material.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/store_feature/utils/store_module_enum_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/package_combos_bloc.dart';
import 'package:piix_mobile/store_feature/domain/model/quote_price_request_model/combo_quote_price_request_model.dart';
import 'package:piix_mobile/store_feature/ui/quotations/state_switcher_quotation_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')
class PackageComboQuotationBuilderDeprecated extends StatefulWidget {
  const PackageComboQuotationBuilderDeprecated({super.key});

  @override
  State<PackageComboQuotationBuilderDeprecated> createState() =>
      _PackageComboQuotationBuilderDeprecatedState();
}

class _PackageComboQuotationBuilderDeprecatedState
    extends State<PackageComboQuotationBuilderDeprecated> {
  late Future<void> getPackageComboDetailFuture;
  late PackageComboBLoC packageComboBLoC;

  @override
  void initState() {
    getPackageComboDetailFuture = getPackageComboDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    packageComboBLoC = context.watch<PackageComboBLoC>();
    final useFullScreenHeight = context.height - kToolbarHeight;
    return FutureBuilder<void>(
        future: getPackageComboDetailFuture,
        builder: (_, __) {
          return SizedBox(
            height: useFullScreenHeight,
            width: context.width,
            child: StateSwitcherQuotationDeprecated(
              retryQuotation: retryPackageComboQuotation,
              module: StoreModuleDeprecated.combo,
              quotationState: packageComboBLoC.packageComboQuotationState,
            ),
          );
        });
  }

  //This future, retrieve a quotation for package combo
  Future<void> getPackageComboDetail() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final membership =
          context.read<MembershipProviderDeprecated>().selectedMembership;
      final currentPackageCombo = packageComboBLoC.currentPackageCombo;
      final packageComboId = currentPackageCombo?.packageComboId ?? '';
      final isPartiallyAcquired =
          currentPackageCombo?.isPartiallyAcquired ?? false;
      if (membership != null && packageComboId.isNotEmpty) {
        final requestModel = ComboQuotePriceRequestModel(
          membershipId: membership.membershipId,
          packageComboId: packageComboId,
          isPartialPurchase: isPartiallyAcquired,
        );
        await packageComboBLoC.getPackageCombosWithDetailsAndPriceByMembership(
          requestModel: requestModel,
        );
      }
    });
  }

  //This function resets the future of getPackageComboDetail, and reruns it
  void retryPackageComboQuotation() => setState(() {
        getPackageComboDetailFuture = getPackageComboDetail();
      });
}
