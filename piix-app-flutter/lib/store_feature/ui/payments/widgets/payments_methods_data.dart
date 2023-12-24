import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/ui/payments/widgets/backed_up_container.dart';
import 'package:piix_mobile/store_feature/ui/payments/widgets/discount_and_total_card.dart';
import 'package:piix_mobile/store_feature/ui/payments/widgets/radio_list_payment_method.dart';
import 'package:piix_mobile/store_feature/ui/payments/widgets/summary_payment_method_footer.dart';

///This widget render a payments method data screen, includes a radio list
///payments, and discount and total card
///
class PaymentsMethodsData extends StatelessWidget {
  const PaymentsMethodsData({Key? key}) : super(key: key);

  double get mediumPadding => ConstantsDeprecated.mediumPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ColoredBox(
              color: PiixColors.greyWhite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DiscountAndTotalCard().padBottom(mediumPadding.h),
                  Text(
                    PiixCopiesDeprecated.selectPaymentMethod,
                    style: context.textTheme?.headlineSmall,
                  ).padBottom(12.h),
                  Text(
                    PiixCopiesDeprecated.seeOfficesToPay,
                    style: context.textTheme?.bodyMedium,
                  ).padBottom(10.h),
                  const RadioListPaymentMethod(),
                  const BackedUpContainer()
                ],
              ).padHorizontal(mediumPadding.w).padTop(mediumPadding.h),
            ),
          ),
        ),
        const SummaryPaymentMethodFooter(),
      ],
    );
  }
}
