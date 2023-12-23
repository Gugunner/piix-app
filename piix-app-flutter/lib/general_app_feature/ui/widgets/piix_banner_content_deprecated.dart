import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')
class PiixBannerContentDeprecated {
  const PiixBannerContentDeprecated({
    required this.title,
    this.subtitle,
    this.iconData,
    this.cardBackgroundColor,
    this.height,
    this.titleHeight,
  });

  final String title;
  final String? subtitle;
  final IconData? iconData;
  final Color? cardBackgroundColor;
  final double? height;
  final double? titleHeight;

  List<Widget> build(BuildContext context) {
    debugPrint(context.width.toString());
    return [
      Card(
        margin: EdgeInsets.zero,
        elevation: 4,
        color: cardBackgroundColor ?? PiixColors.successMain,
        shadowColor: PiixColors.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(4),
            bottomRight: Radius.circular(4),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 12.h,
            bottom: 8.h,
            left: 12.w,
            right: 24.w,
          ),
          child: Row(
            children: [
              SizedBox(
                child: Icon(
                  iconData ?? Icons.check_circle,
                  color: PiixColors.white,
                  size: 24.w,
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              Flexible(
                  child: Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: '$title\n',
                    style: context.primaryTextTheme?.headlineSmall?.copyWith(
                      color: PiixColors.space,
                    ),
                  ),
                  if (subtitle != null)
                    TextSpan(
                      text: subtitle!,
                      style: context.textTheme?.bodyMedium?.copyWith(
                        color: PiixColors.space,
                      ),
                    ),
                ]),
              )),
            ],
          ),
        ),
      ),
    ];
  }
}
