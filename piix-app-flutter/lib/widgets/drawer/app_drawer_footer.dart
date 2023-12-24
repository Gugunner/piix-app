import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';


///A composed widget that works as a footer element [Container] for
///the [AppDrawer].
class AppDrawerFooter extends StatelessWidget {
  const AppDrawerFooter({
    super.key,
    required this.child,
  });

  ///The content of the footer.
  final Widget child; 
  
  EdgeInsets get _padding => const EdgeInsets.fromLTRB(16, 16, 16, 12);

  double get _height => 80.h;

  Color get _color => PiixColors.primary;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      padding: _padding,
      color: _color,
      child: child,
    );
  }
}
