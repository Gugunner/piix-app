import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_feature/domain/provider/membership_provider.dart';
import 'package:piix_mobile/membership_feature/ui/screens/membership_home_screen.dart';
import 'package:piix_mobile/widgets/app_loading_widget/app_loading_widget.dart';

@Deprecated('Will be removed in 4.0')

///Screen widget that requests the 64bit image [cacheImageMemory]
///for the current selected [membership] it will navigate to
///[MembershipHomeScreen] regardless if the image is succesfully
///loaded or not
class MembershipCardLoadingScreenDeprecated extends AppLoadingWidget {
  static const routeName = '/membership_card_loading_screen';

  const MembershipCardLoadingScreenDeprecated({
    super.key,
    super.message,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MembershipCardLoadingScreenState();
}

class _MembershipCardLoadingScreenState
    extends AppLoadingWidgetState<MembershipCardLoadingScreenDeprecated> {
  @override
  Future<void> whileIsRequesting() async =>
      ref.watch(membershipImageNotifierPodProvider).whenData((_) {
        endRequest();
        Future.microtask(() {
          Timer.periodic(const Duration(seconds: 1), (timer) {
            timer.cancel();
            NavigatorKeyState().fadeInRoute(
              page: const MembershipHomeScreen(),
              routeName: MembershipHomeScreen.routeName,
            );
          });
        });
      });

  @override
  Widget build(BuildContext context) {
    if (isRequesting) whileIsRequesting();
    final packageName =
        ref.read(membershipNotifierPodProvider)?.package?.name ?? '';
    return Scaffold(
      backgroundColor: PiixColors.primary,
      appBar: null,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          height: context.height,
          width: context.width,
          child: Center(
            child: Text(
              'Bienvenido a tu membresía $packageName',
              style: context.displaySmall?.copyWith(
                color: PiixColors.space,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
