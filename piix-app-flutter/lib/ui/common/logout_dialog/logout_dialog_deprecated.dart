import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/ui/common/logout_dialog/widgets/logout_dialog_buttons_deprecated.dart';

@Deprecated('Use instead SignOutDialog')

/// This widget render a confirmation dialog to sign out.
///
class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  Decoration get whiteDecoration => BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(
          4,
        ),
        color: PiixColors.white,
      );

  Decoration get blueDecoration => const BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(4),
          topLeft: Radius.circular(
            4,
          ),
        ),
        color: PiixColors.twilightBlue,
      );
  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: MediaQuery(
        data: query.copyWith(
            textScaleFactor: query.textScaleFactor.clamp(
          1.0,
          1.4,
        )),
        child: SizedBox(
          height: 176,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  decoration: whiteDecoration,
                  child: Center(
                    child: Text(
                      PiixCopiesDeprecated.logoutMessage,
                      style: context.textTheme?.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: context.width,
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: blueDecoration,
                  child: Text(
                    PiixCopiesDeprecated.oneMoment,
                    style: context.primaryTextTheme?.displayMedium?.copyWith(
                      color: PiixColors.space,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: LogoutDialogButtons(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
