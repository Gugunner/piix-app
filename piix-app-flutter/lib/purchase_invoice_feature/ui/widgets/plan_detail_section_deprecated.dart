import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/int_extention.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_model.dart';

@Deprecated('Will be removed in 4.0')
class PlanDetailSectionDeprecated extends StatelessWidget {
  const PlanDetailSectionDeprecated({
    Key? key,
    required this.invoice,
  }) : super(key: key);

  final InvoiceModel invoice;

  @override
  Widget build(BuildContext context) {
    final plans = invoice.products.plans;
    if (plans == null) return const SizedBox();
    final protectedAcquired = invoice.products.protectedAcquired;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ConstantsDeprecated.mediumPadding.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${protectedAcquired} '
            '${PiixCopiesDeprecated.protectedLabel}${protectedAcquired.pluralWithS}',
            style: context.primaryTextTheme?.titleMedium,
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            PiixCopiesDeprecated.planTicketDetail,
            style: context.textTheme?.bodyMedium,
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                PiixCopiesDeprecated.protectedLabel,
                style: context.primaryTextTheme?.titleSmall,
              ),
              Text(
                PiixCopiesDeprecated.quantity,
                style: context.primaryTextTheme?.titleSmall,
                textAlign: TextAlign.end,
              ),
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          ...plans.map(
            (plan) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Text(
                      plan.name,
                      style: context.textTheme?.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        '${plan.protectedAcquired}',
                        style: context.textTheme?.bodyMedium,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
