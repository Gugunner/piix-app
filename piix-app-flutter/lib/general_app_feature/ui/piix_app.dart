import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/home_loading_screen.dart';
import 'package:piix_mobile/general_app_feature/utils/provider_list_util.dart';
import 'package:piix_mobile/navigation_feature/navigation_utils_barrel_file.dart';
import 'package:piix_mobile/navigation_feature/utils/routes_utils.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class PiixApp extends StatelessWidget {
  const PiixApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: getProviderList(),
      child: ScreenUtilInit(
          useInheritedMediaQuery: true,
          designSize: const Size(320.0, 568.0),
          builder: (context, child) {
            return const PiixMaterialApp();
          }),
    );
  }
}

final class PiixMaterialApp extends ConsumerWidget {
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
      home: Builder(builder: (context) {
        return const HomeLoadingScreen();
      }),
      routes: RegisteredRouteUtils.getAppRoutes(),
      locale: const Locale('es', 'MX'),
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateRoute: UnregisteredRouteUtils.onGenerateRoute,
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
