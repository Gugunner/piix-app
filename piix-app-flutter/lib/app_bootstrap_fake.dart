import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/app_bootstrap.dart';
import 'package:piix_mobile/src/features/authentication/application/auth_service_barrel_file.dart';
import 'package:piix_mobile/src/logger/async_error_logger.dart';

/// Extension methods specific for the "fakes" project configuration
extension AppBootstrapFake on AppBootstrap {
  /// Creates the top-level [ProviderContainer] by overriding providers with 
  /// fake repositories only. This is useful for testing purposes and for 
  /// running the app with a "fake" backend.
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
  Future<ProviderContainer> createFakeProviderContainer() async {
    final container = ProviderContainer(overrides: [
      authServiceProvider.overrideWithValue(
        FakeAuthService(),
      ),
    ], observers: [
      AsyncErrorLogger()
    ]);
    return container;
  }
}
