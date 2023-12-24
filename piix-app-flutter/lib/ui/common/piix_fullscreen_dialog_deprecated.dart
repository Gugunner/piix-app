import 'package:flutter/material.dart';
import 'package:piix_mobile/ui/common/clamping_scale_deprecated.dart';

@Deprecated('Will be removed in 4.0')

/// Creates a custom full screen dialog with a slide transition.
class PiixFullScreenDialogDeprecated extends ModalRoute<void> {
  PiixFullScreenDialogDeprecated({required this.child, this.title});

  final Widget child;
  final String? title;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => '';

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> _,
    Animation<double> __,
  ) {
    return ClampingScaleDeprecated(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(title ?? ''),
              leading: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: child),
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position:
          Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeOut),
      ),
      child: child,
    );
  }
}
