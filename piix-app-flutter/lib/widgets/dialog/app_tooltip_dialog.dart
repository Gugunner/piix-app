import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/widgets/button/elevated_app_button_deprecated/elevated_app_button_deprecated.dart';
import 'package:piix_mobile/widgets/button/text_app_button/text_app_button_deprecated.dart';
import 'package:piix_mobile/widgets/dialog/app_dialog_deprecated.dart';


///Base class to add tooltip dialog.
///
///Use the tooltip dialog to add a [description].
///The [description] can have elements such as icons,
///numbers, badges, steppers or subtitles
///(Text primary/Title Small) to communicate the user
///what this info is about. Those elements follow the
///rules of their structure.
///
///Passing [onPressedTwo] bulds a [Row] with two CTA
///buttons, one is a [TextAppButtonDeprecated] to the left and to the
///right is the [ElevatedAppButtonDeprecated].
///
///Passing only [onPressedOne] centers the [ElevatedAppButtonDeprecated].
///Each button text has a default value when the value is null
///[buttonOneText] default is "Accept" and [buttonTwoText]
///is "Cancel".
///
///By default each CTA onPressed pops the dialog if [onPressedOne]
///and/or [onPressedTwo] are null.
///
abstract class AppTooltipDialog extends AppDialogDeprecated {
  AppTooltipDialog({
    super.key,
    required super.title,
    required this.description,
    super.buttonOneText,
    super.buttonTwoText,
    super.onPressedOne,
    super.onPressedTwo,
  }) : super(
          maxWidth: 272.w,
          minHeight: 202.h,
          maxHeight: 480.h,
          dialogContent: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 240.w,
            ),
            child: description,
          ),
        );

  ///The content of the dialog
  final Widget description;
}
