import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:provider/provider.dart';

/// Creates a tab row that shows coverage and addition tabs in [MembershipScreen].
class TabRow extends StatelessWidget {
  const TabRow({Key? key, required this.isAdditions, required this.toggleTab})
      : super(key: key);

  final bool isAdditions;
  final VoidCallback toggleTab;

  @override
  Widget build(BuildContext context) {
    final membershipBLoC = context.watch<MembershipProviderDeprecated>();

    return DecoratedBox(
      decoration: BoxDecoration(color: PiixColors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.25),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ]),
      child: Row(
        children: [
          _Tab(
            isActive: !isAdditions,
            onTap: toggleTab,
            text: PiixCopiesDeprecated.myCoverage,
          ),
          if (membershipBLoC.selectedMembership != null)
            _Tab(
              isActive: isAdditions,
              onTap: toggleTab,
              text: PiixCopiesDeprecated.myAdditions,
            ),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab(
      {Key? key,
      required this.onTap,
      required this.isActive,
      required this.text})
      : super(key: key);

  final String text;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Material(
      child: InkWell(
        onTap: onTap,
        splashColor: PiixColors.active30,
        highlightColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(12)),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: isActive ? PiixColors.active : Colors.transparent,
                  width: 2),
            ),
          ),
          child: Text(
            text.toUpperCase(),
            textAlign: TextAlign.center,
            style: context.primaryTextTheme?.titleSmall?.copyWith(
              color: isActive ? PiixColors.active : PiixColors.infoDefault,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    ));
  }
}
