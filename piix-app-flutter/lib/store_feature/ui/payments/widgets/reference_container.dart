import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';


//TODO: Analyze and refactor for 4.0
///This widget contains the bank reference format.

class ReferenceContainer extends StatelessWidget {
  const ReferenceContainer(
      {super.key,
      required this.accountNumber,
      required this.paymentMethodReferenceId});
  final String accountNumber;
  final String paymentMethodReferenceId;

  @override
  Widget build(BuildContext context) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: PiixColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 0.4,
                  blurRadius: 0.8,
                  offset: const Offset(0, 1),
                )
              ]),
          padding: EdgeInsets.all(8.w),
          child: Text(
            accountNumber,
            style: context.textTheme?.headlineMedium,
          ),
        ),
        Text(
          PiixCopiesDeprecated.accountNumber,
          style: context.textTheme?.bodyMedium?.copyWith(
            color: PiixColors.secondary,
          ),
        ).padBottom(8.h),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: PiixColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 0.4,
                  blurRadius: 0.8,
                  offset: const Offset(0, 1),
                )
              ]),
          padding: const EdgeInsets.all(8),
          child: Text(
            paymentMethodReferenceId,
            style: context.textTheme?.headlineMedium,
          ),
        ),
        Text(
          PiixCopiesDeprecated.bankRefference,
          style: context.textTheme?.bodyMedium?.copyWith(
            color: PiixColors.secondary,
          ),
        ),
      ],
    );
  }
}
