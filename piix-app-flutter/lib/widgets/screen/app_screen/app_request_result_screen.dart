import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_icons.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/app_bar/app_bar_barrel_file.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';


///A defined structure screen that is used to show either
///a success or error api request result.
final class AppRequestResultScreen extends StatelessWidget {
  const AppRequestResultScreen({
    super.key,
    required this.appBarTitleText,
    this.result = RequestResult.success,
    this.titleText,
    this.title,
    this.messageText,
    this.message,
    this.onAccept,
    this.onWillPop,
  });

  final String appBarTitleText;

  final RequestResult result;

  ///Pass a value to show defined [TextStyle].
  ///If [title] is not null it will be used instead of [titleText].
  final String? titleText;
  ///Pass a value to show defined [TextStyle].
  ///If [message] is not null it will be used instead of [titleText].
  final String? messageText;

  final Widget? title;

  final Widget? message;

  ///The callback to execute when the user accepts the result.
  final VoidCallback? onAccept;

  ///Handles the pop callback execution
  final Future<bool> Function()? onWillPop;

  IconData get _iconData {
    if (result == RequestResult.success) return Icons.check_circle;
    return PiixIcons.info;
  }

  Color get _iconColor {
    if (result == RequestResult.success) return PiixColors.success;
    return PiixColors.alert;
  }

  ///The space between the [title] or [titleText] and 
  ///the [message] or [messageText]
  double get _gap => 28.h;

  void _exit() => (BuildContext context) => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: TitleAppBar(
          appBarTitleText,
          //Hide the back button of the Appbar
          leading: const SizedBox(),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 21.h, 24.w, 50.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Builder(builder: (context) {
                if (title != null) return title!;
                if (titleText.isNotNullEmpty)
                  return Text(
                    titleText!,
                    style: context.primaryTextTheme?.displayMedium?.copyWith(
                      color: PiixColors.infoDefault,
                    ),
                    textAlign: TextAlign.center,
                  );
                return const SizedBox();
              }),
              SizedBox(height: _gap),
              Icon(
                _iconData,
                size: 95.h,
                color: _iconColor,
              ),
              SizedBox(height: _gap),
              Builder(builder: (context) {
                if (message != null) return message!;
                if (messageText.isNotNullEmpty)
                  return Text(
                    messageText!,
                    style: context.titleMedium?.copyWith(
                      color: PiixColors.infoDefault,
                    ),
                    textAlign: TextAlign.center,
                  );
                return const SizedBox();
              }),
              SizedBox(height: _gap),
              AppFilledSizedButton(
                text: context.localeMessage.accept.toUpperCase(),
                onPressed: onAccept ?? _exit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
