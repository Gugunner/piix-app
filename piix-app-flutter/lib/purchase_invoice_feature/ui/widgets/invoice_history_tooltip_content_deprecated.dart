import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')

///This is a content for a invoice purchase history tooltip
///
class InvoiceHistoryTooltipContentDeprecated extends StatelessWidget {
  const InvoiceHistoryTooltipContentDeprecated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
      ),
      width: context.width * 0.734,
      child: Text.rich(
        TextSpan(
          children: [
            const TextSpan(
              text: '${PiixCopiesDeprecated.the} ',
            ),
            TextSpan(
              text: '${PiixCopiesDeprecated.purchaseTicket} ',
              style: context.textTheme?.labelLarge?.copyWith(
                color: PiixColors.space,
              ),
            ),
            const TextSpan(
              text: PiixCopiesDeprecated.ticketIsDocument,
            ),
          ],
          style: context.textTheme?.labelMedium?.copyWith(
            color: PiixColors.space,
          ),
        ),
      ),
    );
  }
}
