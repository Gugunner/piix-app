import 'package:flutter/material.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/store_feature/utils/store_module_enum_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/additional_benefits_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/quote_price_request_model/additional_benefit_per_supplier_quote_price_request_model_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/state_switcher_quotation_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget call a future builder with get quotation additional benefit
/// service and render a state switcher
///
///A stateful widget is used for proper handling of re-rendering of the future
///builder
///
class AdditionalBenefitQuotationBuilderDeprecated extends StatefulWidget {
  const AdditionalBenefitQuotationBuilderDeprecated({super.key});

  @override
  State<AdditionalBenefitQuotationBuilderDeprecated> createState() =>
      _AdditionalBenefitQuotationBuilderDeprecatedState();
}

class _AdditionalBenefitQuotationBuilderDeprecatedState
    extends State<AdditionalBenefitQuotationBuilderDeprecated> {
  late Future<void> getAdditionalBenefitDetailFuture;
  late AdditionalBenefitsPerSupplierBLoCDeprecated
      additionalBenefitsPerSupplierBLoC;

  @override
  void initState() {
    getAdditionalBenefitDetailFuture = getAdditionalBenefitDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    additionalBenefitsPerSupplierBLoC =
        context.watch<AdditionalBenefitsPerSupplierBLoCDeprecated>();
    final useFullScreenHeight = context.height - kToolbarHeight;
    return FutureBuilder(
        future: getAdditionalBenefitDetailFuture,
        builder: (_, __) {
          return SizedBox(
            height: useFullScreenHeight,
            width: context.width,
            child: StateSwitcherQuotationDeprecated(
              retryQuotation: retryAdditionalBenefitQuotation,
              quotationState: additionalBenefitsPerSupplierBLoC
                  .additionalBenefitQuotationState,
              module: StoreModuleDeprecated.additionalBenefit,
            ),
          );
        });
  }

//This future, retrieve a quotation for additional benefit
  Future<void> getAdditionalBenefitDetail() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final membership =
          context.read<MembershipProviderDeprecated>().selectedMembership;
      final currentAdditionalBenefitPerSupplier =
          additionalBenefitsPerSupplierBLoC.currentAdditionalBenefitPerSupplier;
      final additionalBenefitId =
          currentAdditionalBenefitPerSupplier?.benefitPerSupplierId ?? '';
      final isPartialPurchase =
          currentAdditionalBenefitPerSupplier?.isPartiallyAcquired ?? false;
      if (membership != null && additionalBenefitId.isNotEmpty) {
        final requestModel = AdditionalBenefitPerSupplierQuotePriceRequestModel(
          membershipId: membership.membershipId,
          additionalBenefitPerSupplierId: additionalBenefitId,
          isPartialPurchase: isPartialPurchase,
        );
        await additionalBenefitsPerSupplierBLoC
            .getAdditionalBenefitPerSupplierDetailsAndPrice(
          requestModel: requestModel,
        );
      }
    });
  }

  //This function resets the future of getQuotationLevelByMembership,
  //and reruns it
  void retryAdditionalBenefitQuotation() => setState(() {
        getAdditionalBenefitDetailFuture = getAdditionalBenefitDetail();
      });
}
