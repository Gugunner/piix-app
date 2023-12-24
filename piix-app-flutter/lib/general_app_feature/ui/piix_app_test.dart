import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/providers/theme_provider.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/provider_list_util.dart';
import 'package:piix_mobile/navigation_feature/utils/routes_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:piix_mobile/test_screens/test_screen.dart';
import 'package:provider/provider.dart';

import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';

class PiixAppTest extends StatelessWidget {
  const PiixAppTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: getProviderList(),
      child: ScreenUtilInit(
          useInheritedMediaQuery: true,
          designSize: ConstantsDeprecated.designSize,
          builder: (context, child) {
            return const PiixMaterialApp();
          }),
    );
  }
}

class PiixMaterialApp extends ConsumerWidget {
  const PiixMaterialApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = ref.watch(themePodProvider);
    return MaterialApp(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: true,
          ),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      title: 'Piix',
      theme: themeData,
      initialRoute: TestScreen.routeName,
      routes: {
        ...RegisteredRouteUtils.getAppRoutes(),
        ...RegisteredRouteUtils.getTestRoutes(),
      },
      locale: const Locale('es', 'MX'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      navigatorKey: NavigatorKeyState().currentNavigatorKey,
    );
  }
}
