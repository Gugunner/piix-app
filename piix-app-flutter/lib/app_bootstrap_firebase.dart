

import 'package:firebase_core/firebase_core.dart';
import 'package:piix_mobile/app_bootstrap.dart';
import 'package:piix_mobile/env/env_interface.dart';

/// Extension to initialize Firebase app.
extension AppBootstrapFirebase on AppBootstrap {
  /// Get the Firebase options for the given environment
  FirebaseOptions _getEnvOptions(Env environment) {
  return FirebaseOptions(
    apiKey: environment.apiKey,
    appId: environment.appId,
    messagingSenderId: environment.messageSenderId,
    projectId: environment.projectId,
    storageBucket: environment.storageBucket,
  );
  }

  /// Initialize the Firebase app with the given environment
  /// if the environment is null then it will not initialize the Firebase app
  /// and the app will be run in fake mode.
  Future<void> initializeFirebaseApp() async {
    // If the environment is null then the app will run in fake mode
    if (environment == null) return;
    final options = _getEnvOptions(environment!);
    await Firebase.initializeApp(options: options);
  }


}