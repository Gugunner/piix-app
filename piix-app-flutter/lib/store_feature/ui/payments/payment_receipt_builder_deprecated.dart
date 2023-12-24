import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_feature/domain/model/user_app_model.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_banner_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_banner_content_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/data/repository/payments/payments_repository_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/payments_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/payer_model_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/user_payment_request_model_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/payments/widgets/state_switcher_receipt_payment.dart';
import 'package:piix_mobile/store_feature/utils/payment_methods.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget is a receipt builder, includes a make user payment future
///builder, and retry future method
///
class PaymentReceiptBuilderDeprecated extends StatefulWidget {
  const PaymentReceiptBuilderDeprecated({Key? key}) : super(key: key);

  @override
  State<PaymentReceiptBuilderDeprecated> createState() =>
      _PaymentReceiptBuilderDeprecatedState();
}

class _PaymentReceiptBuilderDeprecatedState
    extends State<PaymentReceiptBuilderDeprecated> {
  late Future<void> makeUserPaymentFuture;

  late PaymentsBLoCDeprecated paymentsBLoC;
  static const unexpectedError = PaymentStateDeprecated.unexpectedError;
  static const error = PaymentStateDeprecated.error;
  static const badRequest = PaymentStateDeprecated.badRequest;

  @override
  void initState() {
    super.initState();
    makeUserPaymentFuture = makeUserPayment();
  }

  @override
  Widget build(BuildContext context) {
    paymentsBLoC = context.watch<PaymentsBLoCDeprecated>();
    return FutureBuilder(
        future: makeUserPaymentFuture,
        builder: (_, __) {
          return StateSwitcherReceiptPaymentDeprecated(
            retryMakeUserPayment: retryMakeUserPayment,
          );
        });
  }

  //This future, retrieve a plans to acquire
  Future<void> makeUserPayment() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final userBLoC = context.read<UserBLoCDeprecated>();
      final membershipBLoC = context.read<MembershipProviderDeprecated>();
      final user = userBLoC.user;
      final selectedMembership = membershipBLoC.selectedMembership;
      final selectedPaymentMethod = paymentsBLoC.selectedPaymentMethod;
      if (user != null &&
          selectedMembership != null &&
          selectedPaymentMethod != null) {
        final package = selectedMembership.package;
        final userQuotationId = paymentsBLoC.userQuotationId;
        final payer = PayerModel(
          email: user.email!,
          names: user.displayNames(),
          lastNames: user.displayLastNames(),
        );
        if (userQuotationId != null) {
          final transactionAmount = paymentsBLoC.transactionAmount;
          final userPaymentRequest = UserPaymentRequestModel(
            userId: user.userId,
            packageId: package.id,
            paymentMethodId: selectedPaymentMethod.id,
            userQuotationId: userQuotationId,
            transactionAmount: transactionAmount,
            payer: payer,
          );
          final _userPaymentState = await paymentsBLoC.makeUserPayment(
              userPaymentRequest: userPaymentRequest);
          final banner = PiixBannerContentDeprecated(
            title: AlertTypeDeprecated.success.getPaymentTitleAlertMessage,
            subtitle:
                AlertTypeDeprecated.success.getPaymentSubTitleAlertMessage,
            iconData: AlertTypeDeprecated.success.getPaymentTitleAlertIcon,
            cardBackgroundColor:
                AlertTypeDeprecated.success.getPaymentsAlertColor,
            height: 96.h,
            titleHeight: 48.h,
          );
          final userPaymentState =
              context.read<PaymentsBLoCDeprecated>().userPaymentState;
          if (userPaymentState == PaymentStateDeprecated.accomplished) {
            PiixBannerDeprecated.instance.builder(
              context,
              children: banner.build(context),
              height: 96.h,
            );
          }
          if (_userPaymentState == unexpectedError ||
              _userPaymentState == error ||
              _userPaymentState == badRequest) {
            Navigator.of(context).pop();
          }
        }
      }
    });
  }

  //This function resets the future of getPlansByMembership, and reruns it
  void retryMakeUserPayment() => setState(() {
        makeUserPaymentFuture = makeUserPayment();
      });
}
