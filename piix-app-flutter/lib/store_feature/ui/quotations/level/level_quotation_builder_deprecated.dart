import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/store_feature/data/repository/levels_deprecated/levels_repository_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/levels_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/quote_price_request_model/level_quote_price_request_model_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/level/widgets/state_switcher_quotation_level_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget cal a future builder with get quotation level service
///and render a state switcher quotation level
///
///A stateful widget is used for proper handling of re-rendering of the future
///builder
///
class LevelQuotationBuilderDeprecated extends StatefulWidget {
  const LevelQuotationBuilderDeprecated({Key? key}) : super(key: key);

  @override
  State<LevelQuotationBuilderDeprecated> createState() =>
      _LevelQuotationBuilderDeprecatedState();
}

class _LevelQuotationBuilderDeprecatedState
    extends State<LevelQuotationBuilderDeprecated> {
  late Future<void> getQuotationLevelFuture;
  late LevelsBLoCDeprecated levelsBLoC;
  double get mediumPadding => ConstantsDeprecated.mediumPadding;

  @override
  void initState() {
    getQuotationLevelFuture = getQuotationLevelByMembership();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    levelsBLoC = context.watch<LevelsBLoCDeprecated>();
    final usefullScreenHeight = context.height - kToolbarHeight;
    return FutureBuilder<void>(
      future: getQuotationLevelFuture,
      builder: (_, __) {
        return SizedBox(
            height: usefullScreenHeight,
            width: context.width,
            child: StateSwitcherQuotationLevelDeprecated(
              retryQuotationLevelByMembership: retryQuotationLevelByMembership,
            ));
      },
    );
  }

  //This future, retreive a level quotation to acquire
  Future<void> getQuotationLevelByMembership() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        final membership =
            context.read<MembershipProviderDeprecated>().selectedMembership;
        final currentLevel = levelsBLoC.currentLevel;
        final levelId = currentLevel?.levelId ?? '';
        final isPartialPurchase = currentLevel?.maybeMap(
                (value) => value.isPartiallyAcquired,
                orElse: () => false) ??
            false;
        if (membership == null || levelId.isEmpty) {
          levelsBLoC.levelState = LevelStateDeprecated.error;
          return;
        }
        final requestModel = LevelQuotePriceRequestModel(
          membershipId: membership.membershipId,
          levelId: levelId,
          isPartialPurchase: isPartialPurchase,
        );
        await levelsBLoC.getLevelQuotationByMembership(
          requestModel: requestModel,
        );
      },
    );
  }

  //This function resets the future of getQuotationLevelByMembership, and reruns it
  void retryQuotationLevelByMembership() => setState(() {
        getQuotationLevelFuture = getQuotationLevelByMembership();
      });
}
