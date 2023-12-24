import 'package:flutter/material.dart';

///This is a scale transition for navigation
///
class ScalePageRoute extends PageRouteBuilder {
  final Widget widget;
  final String routeName;
  final Curve? curve;
  final Duration? duration;
  ScalePageRoute(
      {required this.widget,
      required this.routeName,
      this.curve,
      this.duration})
      : super(
            settings: RouteSettings(name: routeName),
            transitionDuration: duration ?? const Duration(milliseconds: 500),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secAnimation,
                Widget child) {
              animation = CurvedAnimation(
                parent: animation,
                curve: curve ?? Curves.decelerate,
              );
              return ScaleTransition(
                  alignment: Alignment.center, scale: animation, child: child);
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secAnimation) {
              return widget;
            });
}

class SlideTopRoute<T> extends PageRouteBuilder<T> {
  final Widget? page;
  SlideTopRoute({this.page})
      : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                page!,
            transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) =>
                SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 1),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                        parent: animation,
                        curve:
                            const Interval(0.00, 1.00, curve: Curves.easeOut))),
                    child: child));
}
