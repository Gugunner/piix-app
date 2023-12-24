import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

///A simple [X] icon button used for Widgets that overlay in other widgets.
///For example Banners, Snackbars, Dialogs, etc...
class CloseXButton extends StatelessWidget {
  const CloseXButton(this.onClose, {super.key, this.color});

  ///The calback to execute when the [X] icon
  ///is pressed.
  final VoidCallback onClose;

  final Color? color;

  ///The color used by the [X] button.
  @protected
  Color get _color => color ?? PiixColors.space;

  ///The size of the [X] icon.
  @protected
  double get _size => 24.w;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClose,
      child: Icon(
        Icons.close,
        color: _color,
        size: _size,
      ),
    );
  }
}
