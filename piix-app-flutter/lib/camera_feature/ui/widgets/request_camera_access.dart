import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';


///Contains a predefined message that instructs the user
///that the camera and microphone access must be granted by opening
///app settings before the camera can be used.
class RequestCameraAccess extends StatelessWidget {
  const RequestCameraAccess({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 8.h,
        horizontal: 16.h,
      ),
      child: Column(
        children: [
          Text(
            context.localeMessage.cameraAccessDenied,
            style: context.headlineSmall?.copyWith(
              color: PiixColors.infoDefault,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20.h,
          ),
          AppFilledSizedButton(
            text: context.localeMessage.viewSettings,
            onPressed: () {
              openAppSettings();
            },
          )
        ],
      ),
    );
  }
}
