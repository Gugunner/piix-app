import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

///A default color and size icon used for the banners
///and snackbars.
class BannerIcon extends StatelessWidget {
  const BannerIcon(this.icon, {super.key});

  ///The specific shape to be shown in the [Icon].
  final IconData icon;

  ///The default color of the [Icon].
  @protected
  Color get _color => PiixColors.space;
  ///The default size for the [Icon]
  @protected
  double get _size => 24.w;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: _size,
      color: _color,
    );
  }
}
