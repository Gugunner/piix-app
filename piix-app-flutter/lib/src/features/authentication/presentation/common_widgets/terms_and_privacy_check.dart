import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/src/constants/app_sizes.dart';
import 'package:piix_mobile/src/localization/string_hardcoded.dart';
import 'package:piix_mobile/src/routing/app_router.dart';
import 'package:piix_mobile/src/theme/theme_barrel_file.dart';

///A general checkbox that is used by the user to accept the app
///"Term conditions" and "Privacy Policy".
///
///Pass [onChanged] as a [void] function that controls [check] from
///the parent [Widget].
class TermsAndPrivacyCheck extends ConsumerStatefulWidget {
  const TermsAndPrivacyCheck({
    super.key,
    this.check = false,
    required this.onChanged,
  });

  ///Signals the [Checkbox] to either be filled or not.
  final bool check;

  ///Controls [check].
  final void Function(bool?)? onChanged;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __TermsAndPrivacyCheckState();
}

class __TermsAndPrivacyCheckState extends ConsumerState<TermsAndPrivacyCheck> {

  final _termsGesture = TapGestureRecognizer();
  final _privacyGesture = TapGestureRecognizer();

  void _navigateToTermsOfServicePage() =>
      ref.read(goRouterProvider).goNamed(AppRoute.termsOfService.name);

  void _navigateToPrivacyPolicyPage() =>
      ref.read(goRouterProvider).goNamed(AppRoute.privacyPolicy.name);

  @override
  void initState() {
    super.initState();
    // * Initialize the tap gesture recognizer
    // * Navigate to the terms of service page when the user taps on the "Terms of Service" text \\
    _termsGesture.onTap = _navigateToTermsOfServicePage;
    // * Navigate to the privacy policy page when the user taps on the "Privacy Policy" text \\
    _privacyGesture.onTap = _navigateToPrivacyPolicyPage;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Checkbox(
            value: widget.check,
            onChanged: widget.onChanged,
          ),
          gapW4,
          Expanded(
            child: Text.rich(
              TextSpan(
                text: 'I have read and accept the '.hardcoded,
                children: [
                  TextSpan(
                    text: 'Terms of Service '.hardcoded,
                    style: const TextStyle(
                      color: PiixColors.active,
                    ),
                    recognizer: _termsGesture,
                  ),
                  TextSpan(
                    text: 'and '.hardcoded,
                  ),
                  TextSpan(
                    text: 'Privacy Policy'.hardcoded,
                    style: const TextStyle(
                      color: PiixColors.active,
                    ),
                    recognizer: _privacyGesture,
                  ),
                  TextSpan(
                    text: '.'.hardcoded,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
