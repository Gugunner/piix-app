import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/bloc_deprecated/purchase_invoice_bloc_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/utils/purchase_invoice_enums.dart';
import 'package:piix_mobile/purchase_invoice_feature/utils/product_type_enum_deprecated.dart';
import 'package:piix_mobile/ui/common/piix_tag_store.dart';
import 'package:provider/provider.dart';

class MyLevelList extends StatelessWidget {
  const MyLevelList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final purchaseInvoiceBLoC = context.read<PurchaseInvoiceBLoCDeprecated>();
    final activeInvoiceList = purchaseInvoiceBLoC.purchaseInvoiceList
        .where((element) => element.productStatus == ProductStatus.active);
    final purchaseLevelList = activeInvoiceList
        .where((element) =>
            element.userQuotation.productType == ProductTypeDeprecated.LEVEL)
        .toList();
    purchaseLevelList.sort((a, b) => b.registerDate.compareTo(a.registerDate));

    return purchaseLevelList.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    PiixCopiesDeprecated.levelLabel.toUpperCase(),
                    style: context.primaryTextTheme?.titleSmall,
                  ),
                  SizedBox(width: 12.w),
                  SizedBox(
                    width: 60.w,
                    height: 20.sp,
                    child: const PiixTagStoreDeprecated(
                      text: PiixCopiesDeprecated.activeProduct,
                      backgroundColor: PiixColors.successMain,
                    ),
                  )
                ],
              ).padBottom(4.h),
              Text(
                purchaseLevelList.first.products.level?.name ?? '',
                style: context.textTheme?.bodyMedium,
              ),
            ],
          )
        : const SizedBox();
  }
}
