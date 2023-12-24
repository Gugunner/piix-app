import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

///This widget is a mercado pago container, includes a mercado pago image
///
class BackedUpContainer extends StatelessWidget {
  const BackedUpContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12.h, bottom: 4.h),
      margin: EdgeInsets.only(top: 20.h),
      width: context.width,
      color: PiixColors.white,
      child: Column(
        children: [
          Text(
            PiixCopiesDeprecated.backedUp,
            style: context.primaryTextTheme?.titleSmall,
          ),
          Image.asset(
            PiixAssets.mercadoPagoLogo,
          )
        ],
      ),
    );
  }
}
