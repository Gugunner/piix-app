import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/navigation_deprecated/navigation_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/bloc_deprecated/purchase_invoice_bloc_deprecated.dart';
import 'package:piix_mobile/ui/common/piix_tag_store.dart';
import 'package:provider/provider.dart';

class MyPlanList extends StatelessWidget {
  const MyPlanList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final purchaseInvoiceBLoC = context.read<PurchaseInvoiceBLoCDeprecated>();
    final purchasePlanList = purchaseInvoiceBLoC.purchasePlanList;
    return purchasePlanList.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    purchasePlanList.length > 1
                        ? PiixCopiesDeprecated.plans.toUpperCase()
                        : PiixCopiesDeprecated.planLabel.toUpperCase(),
                    style: context.primaryTextTheme?.titleSmall,
                  ),
                  SizedBox(width: 12.w),
                  SizedBox(
                    width: 60.w,
                    height: 20.sp,
                    child: const PiixTagStoreDeprecated(
                      text: PiixCopiesDeprecated.activeProduct,
                      backgroundColor: PiixColors.successMain,
                    ),
                  )
                ],
              ).padBottom(4.h),
              ...purchasePlanList.map(
                (plan) {
                  final index = purchasePlanList.indexOf(plan);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        plan.name,
                        style: context.textTheme?.bodyMedium,
                      ),
                      GestureDetector(
                        onTap: () => handleViewPlan(context),
                        child: Text(
                          PiixCopiesDeprecated.viewText,
                          style:
                              context.primaryTextTheme?.titleMedium?.copyWith(
                            color: PiixColors.active,
                          ),
                        ),
                      )
                    ],
                  ).padBottom(index == (purchasePlanList.length - 1) ? 0 : 4.h);
                },
              ),
            ],
          )
        : const SizedBox();
  }

  void handleViewPlan(BuildContext context) {
    final navigationProvider = context.read<NavigationProviderDeprecated>();
    navigationProvider.setCurrentNavigationBottomTab(1);
  }
}
