import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Use instead FormCardAppButton')
class CardButton extends StatelessWidget {
  const CardButton({
    super.key,
    required this.icon,
    this.disabled = false,
    this.elevation,
    this.height,
    this.cardColor,
    this.iconColor,
    this.child,
    this.iconSize,
    this.onPressed,
    this.done = false,
    this.error = false,
  });

  final IconData icon;
  final bool disabled;
  final double? elevation;
  final double? height;
  final Color? cardColor;
  final Widget? child;
  final double? iconSize;
  final Color? iconColor;
  final VoidCallback? onPressed;
  final bool done;
  final bool error;

  double topByHeight(BuildContext context) =>
      (height ?? context.height * 0.124);

  double get prefixIconSize => done ? (iconSize ?? 32.w) : 32.w;

  Color get suffixIconColor {
    if (disabled) return PiixColors.secondaryText;
    if (error) return PiixColors.errorText;
    if (iconColor != null) return iconColor!;
    return done ? PiixColors.successMain : PiixColors.twilightBlue;
  }

  Color get prefixIconColor {
    if (disabled) return PiixColors.secondaryText;
    return iconColor ?? PiixColors.twilightBlue;
  }

  IconData get suffixIcon {
    if (error) return Icons.info_rounded;
    if (!done) return Icons.arrow_right;
    return Icons.check_circle;
  }

  @override
  Widget build(BuildContext context) {
    final top = topByHeight(context);
    return SizedBox(
      child: GestureDetector(
        onTap: !disabled ? onPressed : null,
        child: Card(
          elevation: elevation ?? (disabled ? 0 : 4),
          child: Stack(
            children: [
              Container(
                width: context.width,
                height: height ?? context.height * 0.124,
                padding: const EdgeInsets.fromLTRB(
                  48,
                  16,
                  8,
                  16,
                ),
                decoration: BoxDecoration(
                    color: cardColor ?? PiixColors.greyWhite,
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    boxShadow: [
                      BoxShadow(
                        color: PiixColors.black.withOpacity(0.05),
                        blurRadius: 0.001,
                        offset: const Offset(0, 0.75),
                      )
                    ]),
                child: child,
              ),
              if (iconSize != null)
                Positioned(
                  top: (top - iconSize!) / 2,
                  left: 8,
                  child: Icon(
                    icon,
                    color: prefixIconColor,
                    size: iconSize,
                  ),
                ),
              if (!disabled)
                Positioned(
                  top: (top - 32.w) / 2,
                  right: 8.w,
                  child: Icon(
                    suffixIcon,
                    color: suffixIconColor,
                    size: prefixIconSize,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
