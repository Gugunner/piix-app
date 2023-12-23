import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';

//TODO: Add documentation
class PiixBarButtons extends StatelessWidget {
  const PiixBarButtons({Key? key, this.onCancel, this.onSave})
      : super(key: key);

  final VoidCallback? onCancel;
  final VoidCallback? onSave;

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil();
    return Container(
      color: PiixColors.twilightBlue,
      height: screenUtil.setHeight(60),
      padding: EdgeInsets.symmetric(horizontal: screenUtil.setWidth(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: onCancel,
            child: Text(
              PiixCopiesDeprecated.cancelButton.toUpperCase(),
              style: context.labelLarge?.copyWith(
                color: PiixColors.white,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: onSave,
            child: Text(
              PiixCopiesDeprecated.save.toUpperCase(),
              style: context.labelLarge?.copyWith(
                color: PiixColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
