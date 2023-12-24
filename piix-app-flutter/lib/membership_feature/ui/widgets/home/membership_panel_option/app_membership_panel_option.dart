import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/utils/color_utils.dart';

///A card like horizontal panel that acts as a button
abstract class AppMembershipPanelOption extends StatelessWidget {
  const AppMembershipPanelOption({
    super.key,
    required this.text,
    this.icon,
    this.onTap,
  });

  ///The text to show in the pannel
  final String text;

  ///The prefix icon shown in the panel
  final IconData? icon;

  ///The action to execute if the panel option is tapped
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: PiixColors.space,
          borderRadius: BorderRadius.circular(4.w),
          boxShadow: [
            BoxShadow(
              color: ColorUtils.lighten(PiixColors.contrast30, 0.8),
              spreadRadius: 0,
              blurRadius: 2,
              offset: const Offset(1, 2),
              blurStyle: BlurStyle.normal,
            ),
            BoxShadow(
              color: ColorUtils.lighten(PiixColors.contrast30, 0.8),
              spreadRadius: 0,
              blurRadius: 1,
              offset: const Offset(-1, 0),
              blurStyle: BlurStyle.normal,
            ),
          ],
        ),
        child: _AppMembershipPanelContent(icon: icon, text: text),
      ),
    );
  }
}

///The content shown inside the panel arranged inside a
///[Row]
class _AppMembershipPanelContent extends StatelessWidget {
  const _AppMembershipPanelContent({
    required this.icon,
    required this.text,
  });

  ///The text to show in the pannel
  final String text;

  ///The prefix icon shown in the panel
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          flex: 1,
          child: _AppMembershipPanelIconBuilder(icon),
        ),
        SizedBox(width: 4.w),
        Flexible(
          fit: FlexFit.tight,
          flex: 6,
          child: Text(
            text,
            style: context.primaryTextTheme?.titleSmall?.copyWith(
              color: PiixColors.infoDefault,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(
          child: Icon(
            Icons.arrow_forward_ios,
            size: 16.w,
            color: PiixColors.active,
          ),
        ),
      ],
    );
  }
}

///Returns a [SizedBox] if [icon] is null, otherwise
///returns the [Icon]
class _AppMembershipPanelIconBuilder extends StatelessWidget {
  const _AppMembershipPanelIconBuilder(this.icon);

  ///The prefix icon shown in the panel
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    if (icon == null) return SizedBox(width: 8.w);
    return Icon(icon, size: 24.w, color: PiixColors.active);
  }
}
