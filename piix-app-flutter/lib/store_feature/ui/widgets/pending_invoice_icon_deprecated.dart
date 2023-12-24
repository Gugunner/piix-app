import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')

///This widget is a pending invoice icon tooltip
///
class PendingInvoiceIconDeprecated extends StatelessWidget {
  const PendingInvoiceIconDeprecated({super.key});

  double get containerSize => 32;
  double get radius => 4;
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: PiixCopiesDeprecated.pendingInvoices,
      textStyle:
          context.textTheme?.bodyMedium?.copyWith(color: PiixColors.space),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 6.w),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: PiixColors.mainText,
      ),
      waitDuration: const Duration(
        seconds: 4,
      ),
      triggerMode: TooltipTriggerMode.tap,
      child: Container(
        height: containerSize.h,
        width: containerSize.h,
        decoration: BoxDecoration(
          color: PiixColors.simultaneousColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(radius),
              bottomLeft: Radius.circular(radius)),
        ),
        child: SvgPicture.asset(
          PiixAssets.invoice_pending,
        ).padAll(9.h),
      ),
    );
  }
}
