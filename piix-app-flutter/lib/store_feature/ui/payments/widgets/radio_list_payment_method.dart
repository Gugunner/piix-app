import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/payments_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/utils/payment_methods.dart';
import 'package:provider/provider.dart';

///This widget render a radio list cards of payment methods.
///
class RadioListPaymentMethod extends StatefulWidget {
  const RadioListPaymentMethod({Key? key}) : super(key: key);

  @override
  State<RadioListPaymentMethod> createState() => _RadioListPaymentMethodState();
}

class _RadioListPaymentMethodState extends State<RadioListPaymentMethod> {
  var value;
  @override
  Widget build(BuildContext context) {
    final paymentsBLoC = context.watch<PaymentsBLoCDeprecated>();
    return Column(
      children: [
        ...paymentsBLoC.paymentMethods.map(
          (paymentMethod) {
            final index = paymentsBLoC.paymentMethods
                .indexWhere((element) => element == paymentMethod);
            final colorCard =
                index == value ? PiixColors.skeletonGrey : PiixColors.white;
            final colorBorder =
                index == value ? PiixColors.clearBlue : PiixColors.white;
            return Card(
              elevation: 3,
              color: colorCard,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: colorBorder, width: 1.5.h),
                  borderRadius: BorderRadius.circular(4)),
              child: RadioListTile<int>(
                value: index,
                groupValue: value,
                visualDensity: VisualDensity.compact,
                onChanged: (ind) => setState(() {
                  value = ind!;
                  paymentsBLoC.selectedPaymentMethod =
                      paymentsBLoC.paymentMethods[ind];
                }),
                title: Text(
                  paymentMethod.name,
                  style: context.textTheme?.headlineSmall,
                ).padTop(12.h),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: getFirstPaymentMethod(method: paymentMethod)
                            .map((e) => Image.asset(
                                  e.asset,
                                  height: 17.h,
                                ).padRight(6.w))
                            .toList()),
                    Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:
                                getPaymentPlacesSecondRow(method: paymentMethod)
                                    .map((e) => Image.asset(
                                          e.asset,
                                          height: 17.h,
                                        ).padRight(6.w))
                                    .toList())
                        .padBottom(10.h),
                    if (index == value) ...[
                      Text(
                        getPaymentPlaceNames(paymentMethod: paymentMethod),
                        style: context.textTheme?.bodyMedium,
                      ).padBottom(10.h)
                    ]
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
