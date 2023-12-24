import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  const fake = String.fromEnvironment('USE_FAKE');
  runApp(
    MaterialApp(
      //TODO: Add hardcoded extension to String class
      title: 'Piix',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('Hello World Main Dev - Use Fake: $fake'),
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
}
