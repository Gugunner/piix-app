import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('No longer in use in 4.0')

/// Creates a widget that allow the user to refresh the current page.
class PiixRefresh extends StatelessWidget {
  const PiixRefresh({Key? key, required this.onRefresh}) : super(key: key);

  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await onRefresh();
      },
      child: ListView(
        children: [
          SizedBox(height: 16.h),
          const Icon(Icons.warning_outlined, color: PiixColors.warningMain),
          SizedBox(height: 6.h),
          Text(
            PiixCopiesDeprecated.checkYourConnection,
            textAlign: TextAlign.center,
            style: context.primaryTextTheme?.headlineSmall,
          ),
          SizedBox(height: 6.h),
          Text(
            PiixCopiesDeprecated.verticalDragLabel,
            textAlign: TextAlign.center,
            style: context.primaryTextTheme?.headlineSmall,
          ),
          SizedBox(height: 6.h),
          ...(const Icon(Icons.keyboard_arrow_down,
                  color: PiixColors.ceruleanBlue) *
              3)
        ],
      ),
    );
  }
}
