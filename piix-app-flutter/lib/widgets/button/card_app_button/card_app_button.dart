import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

///Base class that defines a default Widget structure
///and properties
abstract class CardAppButton extends StatelessWidget {
  const CardAppButton({
    super.key,
    required this.onPressed,
    this.isHighlighted = false,
    this.isDisabled = false,
    this.prefix,
    this.suffix,
    this.child,
  });

  ///The callback to exectue when tapping the card
  final VoidCallback onPressed;

  ///Shows elevation 4.0 for the card when true
  final bool isHighlighted;

  ///Allows [onPressed] callback to be executed if true
  final bool isDisabled;

  ///The Widget before the [child]
  final Widget? prefix;

  ///The Widget after the [child]
  final Widget? suffix;

  ///The Widget that is placed in the middle
  ///of the card
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !isDisabled ? onPressed : null,
      child: Card(
        color: PiixColors.space,
        margin: EdgeInsets.zero,
        elevation: isHighlighted ? 4.0 : 0,
        shadowColor: PiixColors.contrast30,
        child: Stack(
          children: [
            Container(
              constraints: BoxConstraints(
                minHeight: 72.h,
                minWidth: 272.w,
                maxWidth: 272.w,
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(42.w, 16.h, 32.w, 16.h),
                child: child,
              ),
            ),
            if (prefix != null)
              Positioned(
                top: 20.h,
                left: 8.w,
                child: prefix!,
              ),
            if (suffix != null)
              Positioned(
                top: 20.h,
                right: 12.w,
                child: suffix!,
              ),
          ],
        ),
      ),
    );
  }
}

///The actual implementation of the base class
class FormCardAppButton extends CardAppButton {
  FormCardAppButton({
    super.key,
    required super.onPressed,
    super.isHighlighted,
    super.isDisabled,
    super.prefix,
    super.suffix,
    required String title,
    String? subtitle,
    Color? color,
  }) : super(
            child: _FormCardAppButtonChild(
          title: title,
          subtitle: subtitle,
          color: color,
        ));

  ///A special implementation that uses icons
  ///and defins a specific [child] for the
  ///middle of the card
  factory FormCardAppButton.icons({
    Key? key,
    required VoidCallback onPressed,
    bool isHighlighted,
    bool isDisabled,
    Widget? child,
    Widget? prefix,
    Widget? suffix,
    required IconData prefixIcon,
    Color? prefixIconColor,
    IconData? suffixIcon,
    Color? suffixIconColor,
    Color? color,
    double? size,
    required String title,
    String? subtitle,
  }) = _FormCardAppButtonWithIcons;
}

///Builds specific [prefix] and [suffix] using [_ConstrainedIcon]
///and the [child] as [_FormCardAppButtonChild]
class _FormCardAppButtonWithIcons extends FormCardAppButton {
  _FormCardAppButtonWithIcons({
    super.key,
    required super.onPressed,
    required super.title,
    super.subtitle,
    super.isHighlighted,
    super.isDisabled,
    super.color,
    Widget? child,
    Widget? prefix,
    Widget? suffix,
    required IconData prefixIcon,
    Color? prefixIconColor,
    IconData? suffixIcon,
    Color? suffixIconColor,
    double? size,
  }) : super(
          prefix: _ConstrainedIcon(
            icon: prefixIcon,
            size: size,
            color: prefixIconColor,
          ),
          suffix: suffixIcon != null
              ? _ConstrainedIcon(
                  icon: suffixIcon,
                  size: size,
                  color: suffixIconColor,
                )
              : const SizedBox(),
        );
}

///A simple [title] and [subtitle] TextSpan
class _FormCardAppButtonChild extends StatelessWidget {
  const _FormCardAppButtonChild({
    required this.title,
    this.subtitle,
    this.color,
  });

  final String title;
  final String? subtitle;

  ///The color of the [title] and [subtitle]
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: '$title\n',
            style: context.primaryTextTheme?.titleSmall?.copyWith(
              color: color,
            ),
            children: [
              TextSpan(
                text: subtitle,
                style: context.bodyMedium?.copyWith(
                  color: color,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}

///A specific [Icon] with constraints for the [height] and
///[width]
class _ConstrainedIcon extends StatelessWidget {
  const _ConstrainedIcon({
    required this.icon,
    this.color,
    this.size,
  });

  ///The icon to show
  final IconData icon;

  ///Color of the Icon
  final Color? color;

  ///Size of the icon
  final double? size;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 64.h,
        maxWidth: 20.w,
      ),
      child: Icon(
        icon,
        color: color,
        size: size,
      ),
    );
  }
}
