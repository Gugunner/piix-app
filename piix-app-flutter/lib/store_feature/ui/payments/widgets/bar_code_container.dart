import 'package:barcode_widget/barcode_widget.dart' as bc;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

//TODO: Analyze and refactor for 4.0
class BarcodeContainer extends StatelessWidget {
  const BarcodeContainer({
    super.key,
    required this.barcode,
    required this.barcodeType,
  });
  final String barcodeType;
  final String barcode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        bc.BarcodeWidget(
          barcode: bc.Barcode.code128(
            useCode128A: barcodeType == BarType.Code128A.name,
            useCode128B: barcodeType == BarType.Code128B.name,
            useCode128C: barcodeType == BarType.Code128C.name,
          ),
          style: context.labelMedium?.copyWith(
            color: PiixColors.black,
            height: 12.sp / 12.sp,
            fontWeight: FontWeight.w500,
            fontFamily: 'Arial',
            letterSpacing: 1.2,
          ),
          data: '${barcode}',
          height: 68.w,
        ).padHorizontal(24.w),
      ],
    );
  }
}
