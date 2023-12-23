import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/ui/widgets/submit_button_builder_deprecated.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/bloc/protected_form_provider.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/bloc/protected_provider.dart';
import 'package:piix_mobile/protected_feature_deprecated/ui/protected_register_form_screen.dart';
import 'package:piix_mobile/protected_feature_deprecated/ui/widgets/total_protected_card/total_protected_card.dart';
import 'package:provider/provider.dart';

class TotalProtectedCardBuilder extends ConsumerWidget {
  const TotalProtectedCardBuilder({
    super.key,
    this.shouldActivateEcommerce = false,
  });

  final bool shouldActivateEcommerce;

  void _toProtectedRegisterForm(BuildContext context, WidgetRef ref) {
    ref.read(protectedFormProvider).clearProvider();
    NavigatorKeyState().getNavigator()?.push(
          MaterialPageRoute(
            builder: (_) => const ProtectedRegisterFormScreen(),
          ),
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membershipInfoBLoC = context.watch<MembershipProviderDeprecated>();
    final protectedProvider = context.watch<ProtectedProvider>();
    final protectedsInfo = protectedProvider.protectedsInfo;
    final protectedSlots = protectedsInfo?.slots.totalAvailableSlots ?? 0;
    final needsToUpgradePlan = protectedSlots == 0 &&
        membershipInfoBLoC.activateStore &&
        (protectedsInfo?.canAddProtected ?? false);
    final canRegisterProtected = protectedSlots > 0;
    return Stack(
      children: [
        TotalProtectedCard(
          shouldActivateEcommerce: shouldActivateEcommerce,
          needsToUpgradePlan: needsToUpgradePlan,
          canRegisterProtected: canRegisterProtected,
        ),
        if (canRegisterProtected)
          Positioned(
            bottom: 20.h,
            right: 0,
            child: Column(
              children: [
                Container(
                  width: context.width * 0.36,
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                  ),
                  child: SubmitButtonBuilderDeprecated(
                    onPressed: () => _toProtectedRegisterForm(context, ref),
                    text: PiixCopiesDeprecated.toRegister.toUpperCase(),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
