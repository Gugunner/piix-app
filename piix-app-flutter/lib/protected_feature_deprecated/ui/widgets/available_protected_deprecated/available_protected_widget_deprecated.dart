import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/shimmer/shimmer.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_loading.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_wrap.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/alternate_text_button.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/bloc/protected_provider.dart';
import 'package:piix_mobile/protected_feature_deprecated/ui/widgets/protected_expansion_card_list.dart';
import 'package:piix_mobile/protected_feature_deprecated/ui/widgets/total_protected_card/total_protected_card_builder.dart';
import 'package:piix_mobile/store_feature/ui/plans/plans_home_screen_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('No longer in use as of Piix 4.0 MyGroupHomeScreen')
class AvailableProtectedWidgetDeprecated extends StatelessWidget {
  const AvailableProtectedWidgetDeprecated({
    Key? key,
    this.shouldActivateEcommerce = false,
    this.isLoading = false,
  }) : super(key: key);

  final bool shouldActivateEcommerce;
  final bool isLoading;

  void toPlansHomeScreen(BuildContext context) {
    Navigator.pushNamed(
      context,
      PlansHomeScreenDeprecated.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    final protectedProvider = context.watch<ProtectedProvider>();
    final canAddProtected =
        protectedProvider.protectedsInfo?.canAddProtected ?? false;
    return SingleChildScrollView(
      padding: EdgeInsets.all(8.w),
      child: Shimmer(
        child: ShimmerLoading(
          isLoading: isLoading,
          child: SizedBox(
            child: Column(
              children: [
                // const TotalProtectedCard(),
                TotalProtectedCardBuilder(
                  shouldActivateEcommerce: shouldActivateEcommerce,
                ),
                const ProtectedExpansionCardList(),
                SizedBox(
                  height: 8.h,
                ),
                ShimmerWrap(
                  child: AlternateTextButton(
                    onPressed: shouldActivateEcommerce && canAddProtected
                        ? () => toPlansHomeScreen(context)
                        : null,
                    child: const Text(
                      PiixCopiesDeprecated.addProtecteds,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
