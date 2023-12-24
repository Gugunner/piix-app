import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/currency_extends.dart';
import 'package:piix_mobile/extensions/date_extend_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_model.dart';
import 'package:piix_mobile/store_feature/utils/payment_methods.dart';
import 'package:piix_mobile/store_feature/utils/store_copies.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget includes a general info of receipt as user display name, total
///transaction amount, discount, validity of receipt
///
class PaymentLineGeneralInfoDeprecated extends StatelessWidget {
  const PaymentLineGeneralInfoDeprecated({
    super.key,
    required this.paymentLine,
  });
  final InvoiceModel paymentLine;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserBLoCDeprecated>().user;
    final currentDate = DateTime.now();
    final expirationDate = paymentLine.expirationDate;
    final differenceInDays = getDifferenceInDaysBetweenDates(
      fromDate: currentDate,
      toDate: expirationDate,
    );
    final differenceInHours = getDifferenceInHoursBetweenDates(
          fromDate: currentDate,
          toDate: expirationDate,
        ) -
        (differenceInDays * 24);
    return Container(
      width: context.width,
      color: PiixColors.twilightBlue,
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Column(children: [
        SizedBox(height: 8.h),
        Text(
          '${paymentLine.paymentPurchaseType} '
          '"${paymentLine.paymentPurchaseName}"',
          style: context.textTheme?.headlineMedium?.copyWith(
            color: PiixColors.sky,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),
        Text(
          '${PiixCopiesDeprecated.emissionDate}: '
          '${paymentLine.registerDate.dateFormatTime}',
          style: context.primaryTextTheme?.bodyMedium?.copyWith(
            color: PiixColors.sky,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 24.h),
        Text(
          user?.displayName ?? '-',
          style: context.textTheme?.headlineSmall?.copyWith(
            color: PiixColors.sky,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          '${PiixCopiesDeprecated.includedProtected}: '
          '${paymentLine.protectedQuantity}',
          style: context.textTheme?.bodyMedium?.copyWith(
            color: PiixColors.sky,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16.h),
        if (paymentLine.percentageFinalDiscount > 0)
          Text(
            PiixCopiesDeprecated.applyDiscountInTotal(
                paymentLine.percentageFinalDiscount.toStringAsFixed(2)),
            style: context.textTheme?.bodyMedium?.copyWith(
              color: PiixColors.sky,
            ),
            textAlign: TextAlign.center,
          )
        else
          Text(
            PiixCopiesDeprecated.cashPayment,
            style: context.textTheme?.bodyMedium?.copyWith(
              color: PiixColors.sky,
            ),
            textAlign: TextAlign.center,
          ),
        SizedBox(height: 8.h),
        Text(
          '${ConstantsDeprecated.moneySymbol}'
          '${paymentLine.totalPremium.currencyFormat} '
          '${ConstantsDeprecated.mxn}',
          style: context.textTheme?.displayMedium?.copyWith(
            color: PiixColors.sky,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20.h),
        Text(
          '${paymentLine.paymentMethodId.typeOfPaymentText}',
          style: context.textTheme?.bodyMedium?.copyWith(
            color: PiixColors.sky,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          '$differenceInDays ${StoreCopiesDeprecated.days} $differenceInHours '
          '${StoreCopiesDeprecated.hours}',
          style: context.textTheme?.bodyMedium?.copyWith(
            color: PiixColors.sky,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          '${PiixCopiesDeprecated.availableUntil}: '
          '${expirationDate.dateFormatTime}',
          style: context.textTheme?.bodyMedium?.copyWith(
            color: PiixColors.sky,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 18.h),
      ]),
    );
  }
}
