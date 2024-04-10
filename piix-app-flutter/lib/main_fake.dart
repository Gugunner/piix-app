import 'package:flutter/material.dart';
import 'package:piix_mobile/app_bootstrap.dart';
import 'package:piix_mobile/app_bootstrap_fake.dart';

/// The main entry point for the "fakes" project configuration
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // * Get the environment from the environment variables
  // * Initialize the app with the environment
  const appBootstrap = AppBootstrap('fake');
  final container = await appBootstrap.createFakeProviderContainer();
  runApp(appBootstrap.createHome(container: container));
}
