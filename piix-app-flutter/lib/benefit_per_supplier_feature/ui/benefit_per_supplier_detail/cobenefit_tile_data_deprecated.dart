import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_form_provider.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/ui/benefit_form_screen_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/ui/benefit_per_supplier_detail/benefit_per_supplier_detail_screen_deprecated.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/utils/piix_memberships_util_deprecated.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/bloc/protected_provider.dart';
import 'package:piix_mobile/ui/common/piix_tag.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')
class CobenefitTileDataDeprecated extends ConsumerWidget {
  const CobenefitTileDataDeprecated({
    super.key,
    required this.cobenefit,
  });
  final BenefitPerSupplierModel cobenefit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final protectedBLoC = context.watch<ProtectedProvider>();
    final shouldBlockActions = protectedBLoC.shouldBlockMainUserActions;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Divider(
            thickness: 1,
            color: PiixColors.veryLightPink2,
          ),
          SizedBox(
            height: 16.w,
          ),
          InkWell(
            onTap: () => handleCobenefitDetail(context),
            splashColor: PiixColors.clearBlue.withOpacity(0.1),
            highlightColor: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Text(
                    cobenefit.benefit.name,
                    style: context.textTheme?.headlineSmall,
                  ),
                ),
                if (cobenefit.hasBenefitForm && !shouldBlockActions)
                  Flexible(
                    child: PiixTagDeprecated(
                      text: getSignLabelFromCoBenefit(cobenefit),
                      backgroundColor: getSignColorFromCoBenefit(cobenefit),
                      action: () => handleBenefitForm(context, ref),
                    ),
                  ),
                SizedBox(
                  width: 16.w,
                ),
                Text(
                  PiixCopiesDeprecated.viewText,
                  style: context.primaryTextTheme?.titleMedium?.copyWith(
                    color: PiixColors.active,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
        ],
      ),
    );
  }

  void handleBenefitForm(BuildContext context, WidgetRef ref) {
    final benefitFormNotifier = ref.read(benefitFormProvider);
    final benefitPerSupplierBLoC =
        context.read<BenefitPerSupplierBLoCDeprecated>();
    if (cobenefit.userHasAlreadySignedTheBenefitForm) return;
    benefitFormNotifier.currentBenefitFormId = cobenefit.benefitFormId;
    benefitPerSupplierBLoC.setSelectedCobenefitPerSupplier(cobenefit);
    NavigatorKeyState()
        .getNavigator()
        ?.pushNamed(BenefitFormScreenDeprecated.routeName);
  }

  void handleCobenefitDetail(BuildContext context) {
    final benefitPerSupplierBLoC =
        context.read<BenefitPerSupplierBLoCDeprecated>();
    benefitPerSupplierBLoC
      ..isCobenefit = true
      ..setSelectedCobenefitPerSupplier(cobenefit);
    NavigatorKeyState()
        .getNavigator()
        ?.pushNamed(BenefitPerSupplierDetailScreenDeprecated.routeName);
  }
}
