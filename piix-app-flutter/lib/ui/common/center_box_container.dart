import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/ui_bloc.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/responsive.dart';
import 'package:provider/provider.dart';

/// Creates a center container with a circular background
///
/// [child] is the widget to be placed inside the container
/// [button] is the button to be placed just below the container
class CenterBoxContainer extends StatelessWidget {
  const CenterBoxContainer({Key? key, this.child, this.button, this.padding})
      : super(key: key);
  final Widget? child;
  final Widget? button;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final screenSize = Responsive.of(context);
    final uiBLoC = context.watch<UiBLoC>();
    return Center(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (uiBLoC.isHeightUp || uiBLoC.isLargeContainer)
                SizedBox(
                    height: ScreenUtil()
                        .setHeight(uiBLoC.isLargeContainer ? 100 : 50)),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: PiixColors.white,
                margin:
                    EdgeInsets.symmetric(horizontal: screenSize.width * 0.078),
                child: Container(
                  padding: padding ??
                      EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.106,
                          vertical: screenSize.height * .07),
                  child: child,
                ),
              ),
              if (button != null)
                const SizedBox(height: kMinInteractiveDimension * 0.5)
            ],
          ),
          if (button != null) button as Widget
        ],
      ),
    );
  }
}
