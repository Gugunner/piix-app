import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/env/env_barrel.dart';
import 'package:piix_mobile/env/env_interface.dart';
import 'package:piix_mobile/src/localization/string_hardcoded.dart';
import 'package:piix_mobile/src/my_app.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_bootstrap.g.dart';

///All avaliable environments where the app is run
///during app development cycle.
enum ENV { fake, local, dev, stage, prod }

///A provider that allows the environment to be read
///inside any Consumer Widget or Riverpod provider.
///
///Acts as a singleton.
@Riverpod(keepAlive: true)
final envProvider = StateProvider<Env?>((ref) {
  return null;
});

///A provider that stores and retrieves the platform
///where the app is currently running.
///
///It also has specific values to check for specific
///conditions such as [isNotMobileOrTablet].
@Riverpod(keepAlive: true)
class Platform extends _$Platform {
  @override
  TargetPlatform build() {
    return TargetPlatform.android;
  }

  set platform(TargetPlatform platform) {
    state = platform;
  }

  ///Checks if the platform is not Android or iOS which'
  ///ensures that the app is not run in mobile or tablet.
  bool get isNotMobileOrTablet =>
      state != TargetPlatform.android && state != TargetPlatform.iOS;
}

/// An auxiliary class to bootstrap the app with the given environment
class AppBootstrap {
  const AppBootstrap(this.env);

  ///The environment to use between fake, dev, stage, and prod
  final String env;

  ///Get the environment values from the environment variables
  Env? get environment {
    if (env == ENV.local.name) return LocalEnv();
    if (env == ENV.dev.name) if (env == ENV.stage.name) return StageEnv();
    if (env == ENV.prod.name) return ProdEnv();
    return null;
  }

  ///Create the home widget for the app
  Widget createHome({required ProviderContainer container}) {
    //Sets the environment value for the provider.
    container.read(envProvider.notifier).state = environment;
    //Initializes the platform provider before being used.
    container.read(platformProvider);
    //TODO: Initialize providers here
    //* Set Android orientations
    if (environment != null) {
      //* This cannot be tested in any unit, widget, or integration test
      //* since it is a last resort as explained by the Flutter team in https://github.com/flutter/flutter/issues/110301 //
      _registerErrorHandlers();
    }
    return UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    );
  }

  ///Register error handlers for the app
  void _registerErrorHandlers() {
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
          title: Text('An error occurred'.hardcoded),
        ),
        body: Center(
          child: Text(details.toString()),
        ),
      );
    };
  }
}
