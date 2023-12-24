import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/widgets/app_bar/logo_app_bar.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';
import 'package:piix_mobile/widgets/screen/app_screen/app_screen.dart';

@Deprecated('Use instead AppRequestResultScreen')
class SuccessAppScreen extends AppScreen {
  SuccessAppScreen({
    super.key,
    required String title,
    required String message,
    required VoidCallback onSuccess,
    String buttonText = PiixCopiesDeprecated.continueText,
    Widget? image,
  }) : super(
          appBar: LogoAppBar(),
          body: _SuccessAppScreenBody(
            title: title,
            image: image,
            message: message,
            buttonText: buttonText,
            onSuccess: onSuccess,
          ),
        );
}

class _SuccessAppScreenBody extends StatelessWidget {
  const _SuccessAppScreenBody({
    required this.title,
    required this.image,
    required this.message,
    required this.buttonText,
    required this.onSuccess,
  });

  final String title;
  final Widget? image;
  final String message;
  final String buttonText;
  final VoidCallback onSuccess;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: context.height,
        maxWidth: context.width,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 40.h,
        horizontal: 24.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: context.primaryTextTheme?.displayMedium?.copyWith(
              color: PiixColors.infoDefault,
            ),
          ),
          if (image != null)
            image!
          else
            Icon(
              Icons.warning_amber_outlined,
              size: 95.w,
              color: PiixColors.success,
            ),
          Row(
            children: [
              Flexible(
                child: Text(
                  message,
                  style: context.titleMedium?.copyWith(
                    color: PiixColors.infoDefault,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
          AppFilledSizedButton(
            text: buttonText,
            onPressed: onSuccess,
          ),
        ],
      ),
    );
  }
}
