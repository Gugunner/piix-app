
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/src/localization/string_hardcoded.dart';
import 'package:piix_mobile/src/routing/app_router.dart';
import 'package:piix_mobile/src/theme/theme_barrel_file.dart';
import 'package:piix_mobile/src/theme/theme_context.dart';

/// A label that says "Don't have an account? Sign up".
/// When the user taps on the "Sign up" text, the user is navigated to the sign 
/// up page.
/// 
/// This widget is used in the web version of the app.
class OrSignUpLabel extends ConsumerStatefulWidget {
  const OrSignUpLabel({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __OrSignUpLabelState();
}

class __OrSignUpLabelState extends ConsumerState<OrSignUpLabel> {
  final tapGesture = TapGestureRecognizer();

  @override
  void initState() {
    super.initState();
    // * Intialize the tap gesture recognizer
    // * Navigate to the sign up page when the user taps on the "Sign up" text
    tapGesture.onTap = () {
      ref.read(goRouterProvider).goNamed(AppRoute.signUp.name);
    };
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'Don\'t have an account?'.hardcoded,
        style: context.theme.textTheme.labelLarge?.copyWith(
          color: PiixColors.secondary,
        ),
        children: [
          TextSpan(
            text: ' Sign up'.hardcoded,
            style: context.theme.textTheme.labelLarge?.copyWith(
              color: PiixColors.primary,
            ),
            recognizer: tapGesture,
          ),
        ],
      ),
    );
  }
}