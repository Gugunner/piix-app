import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/store_feature/utils/store_module_enum_deprecated.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/ui/widgets/navigate_module_button_deprecated.dart';
import 'package:piix_mobile/store_feature/utils/payment_methods.dart';

@Deprecated('No longer in use in 4.0')

///This widget is a store home card, contains image, label, and description
///
class StoreHomeCardDeprecated extends StatelessWidget {
  const StoreHomeCardDeprecated({super.key, required this.module});
  final StoreModuleDeprecated module;

  double get minSeparatorHeight => 4;
  double get regularSeparatorHeight => 8;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: context.width,
          child: Text(
            PiixCopiesDeprecated.upgradeYourMembership,
            textAlign: TextAlign.center,
            style: context.primaryTextTheme?.labelMedium,
          ),
        ),
        SizedBox(height: minSeparatorHeight.h),
        Image.asset(
          module.getImageOfModulePayment,
          width: context.width * 0.78,
          height: context.height * 0.34,
          fit: BoxFit.contain,
        ).center(),
        Text(
          module.storeModuleTitle,
          style: context.primaryTextTheme?.displayMedium,
        ),
        SizedBox(height: regularSeparatorHeight.h),
        Text(
          '${module.getFirstInstructionWord}'
          '${module.getSecondInstructionPhrase}'
          '${module.getComplementInstructionPhrase}',
          style: context.textTheme?.bodyMedium,
        ),
        SizedBox(
          height: regularSeparatorHeight.h,
        ),
        Text(
          module.getSlogan,
          style: context.primaryTextTheme?.titleMedium,
        ),
        SizedBox(height: regularSeparatorHeight.h),
        NavigateModuleButtonDeprecated(
          module: module,
        ).center()
      ],
    );
  }
}
