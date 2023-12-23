import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/navigation_deprecated/navigation_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_error_screen_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/purchase_invoice_instructions_container_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')
///This widget render purchase invoice cards, title, instructions and tooltip
///
class PurchaseInvoiceEmptyDeprecated extends StatelessWidget {
  const PurchaseInvoiceEmptyDeprecated({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            PiixCopiesDeprecated.purchaseHistory,
            style: context.headlineMedium?.copyWith(
              color: PiixColors.mainText,
            ),
          ),
          SizedBox(height: 24.h),
          const PurchaseInvoiceInstructionsContainerDeprecated(),
          SizedBox(
            height: 56.h,
          ),
          PiixErrorScreenDeprecated(
            errorMessage: PiixCopiesDeprecated.notHaveAdditions,
            onTap: () => handleNavigationToStore(context),
            buttonLabel: PiixCopiesDeprecated.viewAllTheProducts,
          )
        ],
      ).padSymmetric(horizontal: 12.w, vertical: 24.h),
    );
  }

  //This function navigate to store screen
  void handleNavigationToStore(BuildContext context) {
    final navigationProvider = context.read<NavigationProviderDeprecated>();
    navigationProvider.setCurrentNavigationBottomTab(2);
    Navigator.pop(context, true);
  }
}
