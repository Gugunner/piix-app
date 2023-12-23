import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_ui_state.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/membership_tab_builder.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/tab_row.dart';
import 'package:provider/provider.dart';

///This widget contains tab row and membership tab builder
///
class MembershipDataColumn extends StatelessWidget {
  const MembershipDataColumn({
    super.key,
    required this.membershipUiState,
  });
  final MembershipUiState membershipUiState;

  double get gapPadding => ConstantsDeprecated.minPadding;

  @override
  Widget build(BuildContext context) {
    final membershipInfoBLoC = context.watch<MembershipProviderDeprecated>();
    final showUserPurchaseProducts = membershipInfoBLoC.activateStore &&
        membershipInfoBLoC.isActiveMembership;
    return Column(
      children: [
        if (showUserPurchaseProducts)
          TabRow(
            isAdditions: membershipUiState.isAdditionsTab,
            toggleTab: membershipUiState.toggleMembershipTab,
          ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: gapPadding.w,
              top: gapPadding.h,
              right: gapPadding.w,
              bottom: context.height * 0.125,
            ),
            physics: const BouncingScrollPhysics(),
            child: MembershipTabBuilder(
              membershipUiState: membershipUiState,
            ),
          ),
        ),
      ],
    );
  }
}
