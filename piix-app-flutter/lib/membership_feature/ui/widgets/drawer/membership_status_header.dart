import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_feature/ui/widgets/home/membership_tag/membership_status_tag.dart';
import 'package:piix_mobile/widgets/tag/app_tag.dart';

///A composed header bottomline for the [AppDrawer] that shows the [membership]
///[active] or [inactive] state.
class MembershipStatusHeader extends StatelessWidget {
  const MembershipStatusHeader({super.key, this.isActive = false});

  ///The status of the membership.
  final bool isActive;

  ///Returns the [membership] message.
  String _getMembershipMessage(BuildContext context) =>
      '${context.localeMessage.membership}:';

  ///The color of the [Text] font.
  Color get _color => PiixColors.space;

  ///The space between the [Text] and the [Tag]
  double get _space => 8.w;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Row(children: [
        Text(
          _getMembershipMessage(context),
          style: context.titleMedium?.copyWith(color: _color),
        ),
        SizedBox(width: _space),
        MembershipStatusTag(isActive),
      ]),
    );
  }
}
