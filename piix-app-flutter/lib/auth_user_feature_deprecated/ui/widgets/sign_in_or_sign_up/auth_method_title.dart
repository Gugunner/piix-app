import 'package:flutter/material.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_text.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

///Contains a specific text
class AuthTitle extends StatelessWidget {
  const AuthTitle({
    super.key,
    required this.title,
    this.isLoading = false,
  });

  final String title;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ShimmerText(
        isLoading: isLoading,
        child: Text(
          title,
          style: context.primaryTextTheme?.displayMedium,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
