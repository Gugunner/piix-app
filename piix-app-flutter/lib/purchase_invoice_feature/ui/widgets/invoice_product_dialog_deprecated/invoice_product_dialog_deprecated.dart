import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')
class InvoiceProductDialogDeprecated extends StatelessWidget {
  const InvoiceProductDialogDeprecated({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      contentPadding: EdgeInsets.all(
        16.h,
      ),
      insetPadding: EdgeInsets.all(
        16.w,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          8,
        ),
      ),
      content: SizedBox(
        width: context.width * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(
                  right: 0.w,
                ),
                child: GestureDetector(
                  onTap: () => NavigatorKeyState().getNavigator()?.pop(),
                  child: const Icon(
                    Icons.close,
                    color: PiixColors.errorMain,
                  ),
                ),
              ),
            ),
            if (child != null)
              SizedBox(
                width: context.width * 0.8,
                child: child!,
              ),
          ],
        ),
      ),
    );
  }
}
