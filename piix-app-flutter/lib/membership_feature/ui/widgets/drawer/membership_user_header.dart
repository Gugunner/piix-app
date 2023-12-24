import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

///The header used for the [AppDrawer].
///
///Pass the [userName] to show below the [_userMainMessage].
class MembershipUserHeader extends StatelessWidget {
  const MembershipUserHeader(this.userName, {super.key});

  ///The name of the user with the current active session.
  final String userName;

  ///The color for all the [Text] widgets in this.
  Color get _color => PiixColors.space;

  ///The maxmimum lines before the [Text] widgets overflow.
  int get _maxLines => 2;

  ///Returns the [membership] messgage in [AppLocalization].
  String _getMainUserMessage(BuildContext context) =>
      context.localeMessage.mainHolder;

  ///The space between both [Text] widgets.
  double get _space => 8.h;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _getMainUserMessage(context),
            style: context.titleMedium?.copyWith(
              color: _color,
            ),
            maxLines: _maxLines,
            textAlign: TextAlign.start,
          ),
          SizedBox(height: _space),
          Text(
            userName,
            style: context.primaryTextTheme?.headlineSmall
                ?.copyWith(color: _color),
          ),
        ],
      ),
    );
  }
}
