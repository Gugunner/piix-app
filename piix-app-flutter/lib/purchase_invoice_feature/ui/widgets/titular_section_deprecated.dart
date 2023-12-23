import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/row_text_invoice_card_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This is a titular section in ticket screen
///
class TitularSectionDeprecated extends StatelessWidget {
  const TitularSectionDeprecated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final membershipBLoC = context.watch<MembershipProviderDeprecated>();
    final userBLoC = context.watch<UserBLoCDeprecated>();
    final membership = membershipBLoC.selectedMembership;
    final uniqueId = userBLoC.user?.uniqueId ?? '';
    if (membership == null) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          PiixCopiesDeprecated.owner,
          style: context.textTheme?.headlineSmall?.copyWith(
            color: PiixColors.primary,
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          userBLoC.user?.displayName ?? '',
          style: context.primaryTextTheme?.titleMedium,
        ),
        SizedBox(
          height: 8.h,
        ),
        RowTextInvoiceCardDeprecated(
          leftText: '${PiixCopiesDeprecated.package}:',
          rightText: membership.package.name,
          leftStyle: context.primaryTextTheme?.titleSmall,
          rightStyle: context.primaryTextTheme?.bodyMedium,
        ),
        SizedBox(
          height: 8.h,
        ),
        RowTextInvoiceCardDeprecated(
          leftText: '${PiixCopiesDeprecated.uniqueId}:',
          rightText: uniqueId,
          leftStyle: context.primaryTextTheme?.titleSmall,
          rightStyle: context.primaryTextTheme?.bodyMedium,
        ),
        Divider(
          height: 32.h,
        ),
      ],
    );
  }
}
