import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/app_bootstrap.dart';
import 'package:piix_mobile/src/localization/string_hardcoded.dart';
import 'package:piix_mobile/src/routing/app_router.dart';
import 'package:piix_mobile/src/theme/theme_barrel_file.dart';
import 'package:piix_mobile/src/theme/theme_context.dart';

/// The main entry point for the app.
class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    // * Save the platform where the app is running
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _savePlatform(context);
    });
  }

  /// Save the platform where the app is running in the [PlatformProvider].
  Future<void> _savePlatform(BuildContext context) async {
    ref
        .read(platformProvider.notifier)
        .platform = context.theme.platform;
  }

  @override
  Widget build(BuildContext context) {
    //* Watches the [GoRouter] provider
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      //go Router controls the navigation of the app
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      onGenerateTitle: (context) => 'Piix'.hardcoded,
      theme: AppTheme.themeData,
    );
  }
}
