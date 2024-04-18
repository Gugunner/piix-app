
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/src/constants/app_sizes.dart';
import 'package:piix_mobile/src/localization/string_hardcoded.dart';
import 'package:piix_mobile/src/theme/theme_barrel_file.dart';


///A general checkbox that is used by the user to accept the app
///"Term conditions" and "Privacy Policy".
///
///Pass [onChanged] as a [void] function that controls [check] from
///the parent [Widget].
class TermsAndPrivacyCheck extends ConsumerWidget {
  const TermsAndPrivacyCheck({
    super.key,
    this.check = false,
    required this.onChanged,
  });

  ///Signals the [Checkbox] to either be filled or not.
  final bool check;
  ///Controls [check].
  final void Function(bool?)? onChanged;

  //TODO: Add navigation to TermsOfServicePage
  
  //TODO: Add navigation to PrivacyPolicyPage

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      child: Row(
        children: [
          Checkbox(
            value: check,
            onChanged: onChanged,
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
                  ),
                  TextSpan(
                    text: 'and '.hardcoded,
                  ),
                  TextSpan(
                    text: 'Privacy Policy'.hardcoded,
                    style: const TextStyle(
                      color: PiixColors.active,
                    ),
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