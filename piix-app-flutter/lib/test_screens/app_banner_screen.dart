import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/providers/app_banner_provider.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/widgets/banner/banner_barrel_file.dart';
import 'package:piix_mobile/widgets/button/elevated_app_button_deprecated/elevated_app_button_deprecated.dart';

class AppBannerScreen extends ConsumerWidget {
  static const routeName = '/app_banner_screen';
  const AppBannerScreen({super.key});

  void buildBanner(BuildContext context, WidgetRef ref) {
    final bannerProviderNotifier = ref.read(bannerPodProvider.notifier);
    bannerProviderNotifier.setBanner(
      context,
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
          'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
          'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi '
          'ut aliquip ex ea commodo consequat. Duis aute irure dolor in '
          'reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla '
          'pariatur. Excepteur sint occaecat cupidatat non proident, sunt in '
          'culpa qui officia deserunt mollit anim id est laborum.',
      cause: BannerCause.success,
      title: 'Title',
      action: () {
        print('Click');
      },
      actionText: 'OK',
      addIcon: true,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 8.w,
              ),
              height: context.height,
              child: Center(
                child: ElevatedAppButtonDeprecated(
                  text: 'Success',
                  isMain: false,
                  onPressed: () => buildBanner(context, ref),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
