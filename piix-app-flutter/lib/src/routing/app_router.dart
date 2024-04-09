import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:piix_mobile/app_bootstrap.dart';
import 'package:piix_mobile/src/common_widgets/common_widgets_barrel_file.dart';
import 'package:piix_mobile/src/features/authentication/application/auth_service_barrel_file.dart';
import 'package:piix_mobile/src/features/authentication/presentation/authentication_page_barrel_file.dart';
import 'package:piix_mobile/src/routing/go_router_refresh_stream.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

/// The routes of the app.
enum AppRoute {
  welcome('/'),
  home('/home'),
  signIn('/sign_in'),
  signUp('/sign_up'),
  verification('/verification'),
  ;

  const AppRoute(this.path);
  ///The actual path of the route
  final String path;
}

final goRouterProvider = Provider<GoRouter>((ref) {
  // * Get the [AuthService] instance
  final authService = ref.watch(authServiceProvider);
  // * Get if the app is running on a mobile or tablet device
  final isNotMobileOrTablet =
      ref.watch(platformProvider.notifier).isNotMobileOrTablet;
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      final user = authService.currentUser;
      final isLoggedIn = user != null;
      // * Redirect the user to the appropriate page based on the platform
      if (isNotMobileOrTablet) return _redirectWeb(context, state, isLoggedIn);
      return _redirectMobileAndTablet(context, state, isLoggedIn);
    },
    refreshListenable: GoRouterRefreshStream(authService.authStateChange()),
    routes: [
      GoRoute(
        path: AppRoute.welcome.path,
        name: AppRoute.welcome.name,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: WelcomePage(),
          );
        },
      ),
    ],
    errorBuilder: (context, state) => const LostPage(),
  );
});

//TODO: Implement the _redirectMobileAndTablet method
FutureOr<String?> _redirectMobileAndTablet(
    BuildContext context, GoRouterState state, bool isLoggedIn) async {
  return null;
}

FutureOr<String?> _redirectWeb(
    BuildContext context, GoRouterState state, bool isLoggedIn) async {
  final path = state.uri.path;
  if (!isLoggedIn) return AppRoute.welcome.path;
  if (isLoggedIn && path == '/') return AppRoute.home.path;
  return null;
}
