import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/navigation_deprecated/navigation_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/alternate_text_button.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/bloc/protected_provider.dart';
import 'package:piix_mobile/protected_feature_deprecated/ui/widgets/total_protected_card/protected_listed_information.dart';
import 'package:provider/provider.dart';

/// Creates a [Card] with the general information total of the membership.
class TotalProtectedCard extends StatelessWidget {
  const TotalProtectedCard({
    Key? key,
    this.child,
    this.shouldActivateEcommerce = false,
    this.needsToUpgradePlan = false,
    this.canRegisterProtected = false,
  }) : super(key: key);

  final Widget? child;
  final bool shouldActivateEcommerce;
  final bool needsToUpgradePlan;
  final bool canRegisterProtected;

  void handleNavigationToStore(BuildContext context) {
    final navigationProvider = context.read<NavigationProviderDeprecated>();
    navigationProvider.setCurrentNavigationBottomTab(2);
  }

  @override
  Widget build(BuildContext context) {
    final protectedProvider = context.watch<ProtectedProvider>();
    final protectedsInfo = protectedProvider.protectedsInfo;
    final canAddProtected = protectedsInfo?.canAddProtected ?? false;
    return Card(
      color: PiixColors.greyCard,
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8.w,
          vertical: 12.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              PiixCopiesDeprecated.totalProtected,
              style: context.textTheme?.headlineSmall,
            ),
            const Divider(),
            const ProtectedListedInformation(),
            SizedBox(
              height: 8.h,
            ),
            if (needsToUpgradePlan) ...[
              SizedBox(
                child: Text(
                  PiixCopiesDeprecated.upgradePlanToAddMoreProtected,
                  textAlign: TextAlign.start,
                  style: context.textTheme?.bodyMedium,
                ),
              ),
              SizedBox(
                width: context.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AlternateTextButton(
                      onPressed: shouldActivateEcommerce
                          ? () {
                              handleNavigationToStore(context);
                            }
                          : null,
                      child: const Text(
                        PiixCopiesDeprecated.goToAddition,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (!canAddProtected &&
                !needsToUpgradePlan &&
                !canRegisterProtected)
              Text(
                PiixCopiesDeprecated.reachedProtectedLimit,
                textAlign: TextAlign.start,
                style: context.accentTextTheme?.bodySmall?.copyWith(
                  color: PiixColors.error,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
