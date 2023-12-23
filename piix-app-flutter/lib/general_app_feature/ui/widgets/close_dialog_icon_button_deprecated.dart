import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

@Deprecated('Will be removed in 4.0')

///This widget is used for all dialogs, is a icon close button, this widget make
///a navigation pop for a dialog
///
class CloseDialogIconButtonDeprecated extends StatelessWidget {
  const CloseDialogIconButtonDeprecated({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: () => NavigatorKeyState().getNavigator()?.pop(),
        child: Icon(
          Icons.close,
          color: PiixColors.errorMain,
          size: 24.w,
        ),
      ),
    );
  }
}
