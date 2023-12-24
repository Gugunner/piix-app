import 'package:flutter/material.dart';

@Deprecated('Use instead SimpleFadeInTransition')
class FadeInRouteBuilder extends PageRouteBuilder {
  FadeInRouteBuilder({
    required Widget screen,
    required String routeName,
    int? milliseconds,
  }) : super(
          settings: RouteSettings(name: routeName),
          transitionDuration: Duration(milliseconds: milliseconds ?? 500),
          pageBuilder: (context, animation, secondaryAnimation) => screen,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation =
                CurvedAnimation(parent: animation, curve: Curves.easeIn);
            return FadeTransition(
              opacity: curvedAnimation,
              child: child,
            );
          },
        );
}
