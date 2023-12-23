import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/membership_benefits_feature/domain/model/supplier_model.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a supplier logo container
///
class SuplierLogoContainerDeprecated extends StatelessWidget {
  const SuplierLogoContainerDeprecated({
    super.key,
    required this.supplier,
    this.imageHeight = 82,
    this.imageWidth = 82,
  });
  final SupplierModel supplier;
  final double imageHeight;
  final double imageWidth;

  @override
  Widget build(BuildContext context) {
    final supplierLogo = supplier.logoMemory.isNotEmpty
        ? Image.memory(
            base64Decode(supplier.logoMemory),
            errorBuilder: (context, exception, stackTrace) {
              return Image.asset(PiixAssets.placeholderProv);
            },
            height: imageHeight.h,
            width: imageWidth.w,
          )
        : Image.asset(
            PiixAssets.placeholderProv,
            fit: BoxFit.contain,
            height: imageHeight.h,
            width: imageWidth.w,
          );

    return Container(
      margin: EdgeInsets.only(right: 16.w),
      height: imageHeight.h,
      width: imageWidth.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 0, // changes position of shadow
          ),
        ],
      ),
      child: supplierLogo,
    );
  }
}
