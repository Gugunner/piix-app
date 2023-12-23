import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/providers/app_banner_provider.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_icons.dart';
import 'package:piix_mobile/test_screens/branch_app_icon_tag_screen.dart';
import 'package:piix_mobile/widgets/banner/banner_barrel_file.dart';
import 'package:piix_mobile/widgets/button/text_app_button/text_app_button_deprecated.dart';
import 'package:piix_mobile/widgets/tag/tag_barrel_file.dart';

class AppTagScreen extends ConsumerWidget {
  static const routeName = '/app_tag_screen';

  const AppTagScreen({super.key});

  void buildBanner(BuildContext context, WidgetRef ref) {
    final bannerProviderNotifier = ref.read(bannerPodProvider.notifier);
    bannerProviderNotifier.setBanner(
      context,
      description: '''Mensaje de éxito a una línea o más líneas
Mensaje de éxito a una línea o más líneas
Mensaje de éxito a una línea o más líneas
Mensaje de éxito a una línea o más líneas
Mensaje de éxito a una línea o más líneas''',
      cause: BannerCause.warning,
      title: 'Title',
      action: () {
        print('Click');
      },
      actionText: 'OK',
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: WillPopScope(
        onWillPop: () async {
          ref.read(bannerPodProvider.notifier).removeBanner();
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Wrap(
                children: [
                  TagContainer(
                    child: Tag.icon(
                      PiixColors.secondary,
                      icon: PiixIcons.vida,
                    ),
                  ),
                  TagContainer(
                    child: Tag.label(
                      PiixColors.assists,
                      label: 'Asistencia',
                      icon: PiixIcons.asistencias,
                    ),
                  ),
                  TagContainer(
                    child: Tag.label(
                      PiixColors.assists,
                      label: 'Asistencia',
                      icon: PiixIcons.asistencias,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  TagContainer(
                    child: Tag.actionable(
                      PiixColors.success,
                      label: 'Tag Accionable',
                      action: () => buildBanner(context, ref),
                    ),
                  ),
                  TagContainer(
                    child: Tag.actionable(
                      PiixColors.warning,
                      label: 'Tag inaccionable',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              TextAppButtonDeprecated(
                text: 'Branch Icon App Tag Screen',
                onPressed: () {
                  NavigatorKeyState()
                      .getNavigator(context)
                      ?.pushNamed(BranchAppIconTagScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TagContainer extends StatelessWidget {
  final Widget? child;

  const TagContainer({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 8.w,
      ),
      child: child,
    );
  }
}
