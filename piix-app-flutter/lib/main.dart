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
}
