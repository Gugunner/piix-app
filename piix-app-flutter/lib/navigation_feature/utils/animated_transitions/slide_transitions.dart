import 'package:flutter/material.dart';

class SimpleSlideToRightRoute<T> extends PageRouteBuilder<T> {
  SimpleSlideToRightRoute({
    required this.page,
    Duration? transitionDuration,
  }) : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                page,
            transitionDuration:
                transitionDuration ?? const Duration(milliseconds: 300),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              const begin = Offset(-1, 0);
              const end = Offset.zero;
              return SlideTransition(
                position: Tween<Offset>(
                  begin: begin,
                  end: end,
                ).animate(animation),
                child: child,
              );
            });

  final Widget page;
}

class SimpleSlideToLeftRoute<T> extends PageRouteBuilder<T> {
  SimpleSlideToLeftRoute({
    required this.page,
    Duration? transitionDuration,
  }) : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                page,
            transitionDuration:
                transitionDuration ?? const Duration(milliseconds: 300),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              const begin = Offset(1, 0);
              const end = Offset.zero;
              return SlideTransition(
                position: Tween<Offset>(
                  begin: begin,
                  end: end,
                ).animate(animation),
                child: child,
              );
            });

  final Widget page;
}

class SimpleSlideToTopRoute<T> extends PageRouteBuilder<T> {
  SimpleSlideToTopRoute({
    required this.page,
    Duration? transitionDuration,
  }) : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                page,
            transitionDuration:
                transitionDuration ?? const Duration(milliseconds: 300),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              const begin = Offset(0, 1);
              const end = Offset.zero;
              return SlideTransition(
                position: Tween<Offset>(
                  begin: begin,
                  end: end,
                ).animate(animation),
                child: child,
              );
            });

  final Widget page;
}

