import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:piix_mobile/env/env_barrel.dart';
import 'package:piix_mobile/env/env_interface.dart';
import 'package:piix_mobile/src/localization/string_hardcoded.dart';

enum ENV { fake, dev, stage, prod }

/// An auxiliary class to bootstrap the app with the given environment
class AppBootstrap {
  const AppBootstrap(this.env);

  ///The environment to use between fake, dev, stage, and prod
  final String env;

  ///Get the environment values from the environment variables
  Env? get environment {
    if (env == ENV.dev.name) return DevEnv();
    if (env == ENV.stage.name) return StageEnv();
    if (env == ENV.prod.name) return ProdEnv();
    return null;
  }

  ///Create the home widget for the app
  Widget createHome() {
    _registerErrorHandlers();
    return MaterialApp(
      //TODO: Add hardcoded extension to String class
      title: 'Piix Dev'.hardcoded,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: Center(
          child: Text('Piix $env'),
        ),
      ),
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