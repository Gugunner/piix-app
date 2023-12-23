import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_model.dart';

@Deprecated('Will be removed in 4.0')

///This widget contain the status color, text, and image for a invoice
///payment
///
class StatusPaymentImageContainerDeprecated extends StatelessWidget {
  const StatusPaymentImageContainerDeprecated({
    Key? key,
    required this.invoice,
  }) : super(key: key);

  final InvoiceModel invoice;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: context.width,
          color: invoice.colorBy(InvoiceElementDeprecated.header),
          child: Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              top: 20.h,
              bottom: 20.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  invoice.paymentDetailInvoiceTextTitle,
                  style: context.textTheme?.headlineMedium?.copyWith(
                    color: PiixColors.sky,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                SizedBox(
                  width: context.width * 0.76,
                  child: Text(
                    invoice.paymentDetailInvoiceTextDescription,
                    style: context.textTheme?.bodyMedium?.copyWith(
                      color: PiixColors.sky,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  invoice.gratitudeText,
                  style: context.textTheme?.labelMedium?.copyWith(
                    color: PiixColors.sky,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: SvgPicture.asset(
            PiixAssets.ticket_image,
            width: 128.w,
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () => NavigatorKeyState().getNavigator()?.pop(),
            icon: const Icon(
              Icons.close,
              color: PiixColors.white,
            ),
          ),
        )
      ],
    );
  }
}
