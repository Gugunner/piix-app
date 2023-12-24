import 'package:flutter/material.dart';

abstract class AppScreen extends StatelessWidget {
  const AppScreen({
    super.key,
    this.onWillPop,
    this.shouldIgnore = false,
    this.appBar,
    this.bottomNavigationBar,
    this.drawer,
    this.body,
    this.onUnfocus,
  });

  final bool shouldIgnore;
  final AppBar? appBar;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Widget? body;
  final Future<bool> Function()? onWillPop;
  final VoidCallback? onUnfocus;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: IgnorePointer(
        ignoring: shouldIgnore,
        child: GestureDetector(
          onTap: onUnfocus,
          child: Scaffold(
            appBar: appBar,
            bottomNavigationBar: bottomNavigationBar,
            drawer: drawer,
            body: body,
          ),
        ),
      ),
    );
  }
}
