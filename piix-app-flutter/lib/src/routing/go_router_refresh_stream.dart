import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

/// Converts a [Stream] into a [Listenable]
///
/// {@tool snippet}
/// Typical usage is as follows:
///
/// ```dart
/// GoRouter(
///  refreshListenable: GoRouterRefreshStream(stream),
/// );
/// ```
/// {@end-tool}
class GoRouterRefreshStream extends ChangeNotifier {
  /// Creates a [GoRouterRefreshStream].
  ///
  /// Every time the [stream] receives an event the [GoRouter] will refresh its
  /// current route.
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subject = BehaviorSubject<dynamic>(
      onListen: () => notifyListeners(),
      onCancel: () => _subject.close(), 
    );
  }

  late final BehaviorSubject<dynamic> _subject;

  @override
  void dispose() {
    _subject.close();
    // _subscription.cancel();
    super.dispose();
  }
}
