import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/widgets/app_bar/title_app_bar.dart';
import 'package:piix_mobile/widgets/app_card/app_card.dart';
import 'package:piix_mobile/widgets/button/text_app_button/text_app_button_deprecated.dart';

final containerCountProvider = StateProvider<List<int>>((ref) => []);

final rebuildProvider = StateProvider<bool>((ref) => true);

class AppCardScreen extends ConsumerWidget {
  static const routeName = '/app_card_screen';

  const AppCardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(containerCountProvider);
    ref.watch(rebuildProvider);
    return Scaffold(
      appBar: TitleAppBar('App Card Screen'),
      body: Container(
        color: PiixColors.primary,
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        width: context.width,
        height: context.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextAppButtonDeprecated(
              text: 'Add One Container',
              onPressed: () {
                ref.read(containerCountProvider.notifier).state = [
                  ...ref.read(containerCountProvider),
                  1
                ];
                ref.read(rebuildProvider.notifier).state = true;
              },
            ),
            AppCard(
              maxHeight: 204.h,
              rebuild: ref.read(rebuildProvider),
              resizeCard: (resized) {
                if (resized) ref.read(rebuildProvider.notifier).state = false;
              },
              color: PiixColors.alert,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ...ref.read(containerCountProvider).map(
                        (e) => Column(
                          children: [
                            Container(
                              color: PiixColors.success,
                              width: 67.w,
                              height: 31.h,
                              padding: EdgeInsets.zero,
                            ),
                            SizedBox(height: 8.h),
                          ],
                        ),
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
