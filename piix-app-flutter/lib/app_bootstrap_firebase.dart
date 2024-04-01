import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:piix_mobile/app_bootstrap.dart';
import 'package:piix_mobile/env/env_dev.dart';
import 'package:piix_mobile/env/env_interface.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    if (environment is DevEnv) {
      await setupEmulators();
    }
  }

  /// Creates the top-level [ProviderContainer] by overriding providers with fake
  /// repositories only. This is useful for testing purposes and for running the
  /// app with a "fake" backend.
  ///
  /// Note: all repositories needed by the app can be accessed via providers.
  /// Some of these providers throw an [UnimplementedError] by default.
  ///
  /// Example:
  /// ```dart
  /// @Riverpod(keepAlive: true)
  /// LocalCartRepository localCartRepository(LocalCartRepositoryRef ref) {
  ///   throw UnimplementedError();
  /// }
  /// ```
  ///
  /// As a result, this method does two things:
  /// - create and configure the repositories as desired
  /// - override the default implementations with a list of "overrides"
  Future<ProviderContainer> createFirebaseProviderContainer() async {
    //TODO: Add all Sembast repositories here
    //TODO: Override the default implementations with fake repositories
    //TODO: Add An AsyncErrorLogger
    return ProviderContainer();
  }

  Future<void> setupEmulators() async {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
    // * When running on the emulator, disable persistence to avoid discrepancies
    // * between the emulated database and local caches. More info here:
    // * https://firebase.google.com/docs/emulator-suite/connect_firestore#instrument_your_app_to_talk_to_the_emulators
    FirebaseFirestore.instance.settings =
        const Settings(persistenceEnabled: false);
  }
}
