<<<<<<< HEAD
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      //TODO: Add hardcoded extension to String class
      title: 'Piix',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('Piix'),
        ),
      ),
    ),
  );
}

void registerErrorHandlers() {
  // * Show some error UI if any uncaught exception happens
  FlutterError.onError = (FlutterErrorDetails details) {
    debugPrint('FlutterError.onError: $details');
  };
  // * Handle errors from underlying platform/OS
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    debugPrint('PlatformDispatcher.instance.onError: $error');
    return true;
  };
  // * Show some error UI when any widget in the app fails to build
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        //TODO: Add hardcoded extension to String class
        title: const Text('An error occurred'),
      ),
      body: Center(
        child: Text(details.toString()),
      ),
    );
  };
=======
import 'package:flutter/material.dart';
import 'package:piix_mobile/app_bootstrap.dart';
import 'package:piix_mobile/app_bootstrap_firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // * Get the environment from the environment variables
  const env = String.fromEnvironment('ENV', defaultValue: 'fake');
  // * Initialize the app with the environment
  const appBootstrap = AppBootstrap(env);
  final container = await appBootstrap.createFirebaseProviderContainer();
  // * Initialize the Firebase app
  appBootstrap.initializeFirebaseApp();
  runApp(appBootstrap.createHome(container: container));
>>>>>>> develop
}
