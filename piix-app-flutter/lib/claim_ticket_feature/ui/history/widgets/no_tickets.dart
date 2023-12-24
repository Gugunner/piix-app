import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/navigation_deprecated/navigation_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:provider/provider.dart';

/// Screen to show when there are no tickets.
class NoTickets extends StatelessWidget {
  const NoTickets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: PiixCopiesDeprecated.actuallyDontHave,
                ),
                TextSpan(
                  text: ' ${PiixCopiesDeprecated.requests.toLowerCase()}',
                  style: context.accentTextTheme?.headlineLarge?.copyWith(
                    color: PiixColors.infoDefault,
                  ),
                )
              ],
              style: context.textTheme?.titleMedium,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            PiixCopiesDeprecated.requestsScreenInfo,
            style: context.textTheme?.titleMedium,
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 8.h,
          ),
          GestureDetector(
            onTap: () => handleNavigationToMembership(context),
            child: Text(
              '${PiixCopiesDeprecated.benefits} >>',
              style: context.accentTextTheme?.headlineLarge?.copyWith(
                color: PiixColors.active,
              ),
            ),
          )
        ],
      ),
    );
  }

  void handleNavigationToMembership(BuildContext context) {
    final navigationProvider = context.read<NavigationProviderDeprecated>();
    navigationProvider.setCurrentNavigationBottomTab(0);
    NavigatorKeyState().getNavigator()?.pop();
  }
}
