import 'package:flutter/material.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

class ProtectedWithMembershipTitle extends StatelessWidget {
  const ProtectedWithMembershipTitle({
    Key? key,
    required this.title,
    this.protectedWithMembershipCount = 0,
  }) : super(key: key);

  final String title;
  final int protectedWithMembershipCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: title,
              style: context.primaryTextTheme?.headlineSmall,
            ),
            TextSpan(
              text: ' ($protectedWithMembershipCount)',
              style: context.primaryTextTheme?.labelLarge,
            ),
          ],
        ),
      ),
    );
  }
}
