import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/data/utils/preferences.dart';
import 'package:piix_mobile/env/test.env.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/general_app_feature/ui/piix_app.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';

late List<CameraDescription> cameras;

/// Prepares all the resources required before running app.
///
/// Initializes [Firebase];
/// Configures [Preferences] data;
/// Configures [Dio];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  cameras = await availableCameras();
  await Firebase.initializeApp();
  await Preferences.configurePrefs();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(
      error,
      stack,
      fatal: true,
    );
    return true;
  };
  PiixApiDeprecated.configureDio();
  await setupGetIt();
  setUpEndpoints();
  PiixLoggerFilter.loggerBuild = PiixLoggerBuild.debug;
  //Change the index value to change debug mode logger level filter
  PiixLoggerFilter.minLevelIndex = Level.verbose.index;
  runApp(
    const ProviderScope(
      child: PiixApp(),
    ),
  );
}

void setUpEndpoints() {
  AppConfig.instance
    ..setBackendEndPoint(TestEnv.backendEndpoint)
    ..setCatalogSQLURL(TestEnv.catalogEndpoint)
    ..setSignUpEndpoint(TestEnv.signUpEndpoint)
    ..setPaymentEndpoint(TestEnv.paymentEndpoint)
    ..setPiixAppS3(TestEnv.piixAppS3);
}
