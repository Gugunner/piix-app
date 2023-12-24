import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

/// This widget is a navigation profile row.
class NavigationRow extends StatelessWidget {
  const NavigationRow(
      {Key? key, required this.onTap, required this.label, this.icon})
      : super(key: key);

  final VoidCallback onTap;
  final String label;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      splashColor: PiixColors.clearBlue.withOpacity(0.1),
      highlightColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
            left: width * .07, right: 8.w, top: 8.w, bottom: 8.w),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: .1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (icon != null) ...[icon!, SizedBox(width: 8.w)],
            Text(
              label,
              style: context.textTheme?.bodyMedium,
            ),
            const Spacer(),
            const Icon(
              Icons.chevron_right,
              color: PiixColors.darkSkyBlue,
            )
          ],
        ),
      ),
    );
  }
}
