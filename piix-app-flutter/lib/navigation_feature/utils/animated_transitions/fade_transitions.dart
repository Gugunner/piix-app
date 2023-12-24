import 'package:flutter/material.dart';

class SimpleFadeInRoute<T> extends PageRouteBuilder<T> {
  SimpleFadeInRoute({
    required this.page,
    Duration? transitionDuration,
  }) : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              page,
          transitionDuration:
              transitionDuration ?? const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation =
                CurvedAnimation(parent: animation, curve: Curves.easeIn);
            return FadeTransition(
              opacity: curvedAnimation,
              child: child,
            );
          },
        );

  final Widget page;
}
