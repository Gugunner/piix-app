import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/ui/widgets/submit_button_builder_deprecated.dart';
import 'package:piix_mobile/general_app_feature/navigation_deprecated/navigation_provider_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/utils/constants_deprecated/purchase_invoice_copies_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This card is only for approved plan payment
///
class PlanApprovedCardDeprecated extends StatelessWidget {
  const PlanApprovedCardDeprecated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationProvider = context.watch<NavigationProviderDeprecated>();
    return Column(
      children: [
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Text(
                  PurchaseInvoiceCopiesDeprecated.recommendAddProtected,
                  style: context.textTheme?.bodyMedium,
                ),
                SizedBox(
                  height: 8.h,
                ),
                SubmitButtonBuilderDeprecated(
                  onPressed: () => navigationProvider.navigatesToProtectedTab(),
                  text: PurchaseInvoiceCopiesDeprecated.addProtectedData
                      .toUpperCase(),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
      ],
    );
  }
}
