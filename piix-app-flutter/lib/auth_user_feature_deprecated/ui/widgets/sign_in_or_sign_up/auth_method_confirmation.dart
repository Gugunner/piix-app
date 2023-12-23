import 'package:flutter/material.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_text.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

///Contains a specific text
class AuthMessage extends StatelessWidget {
  const AuthMessage({
    super.key,
    required this.message,
    this.isLoading = false,
  });

  final String message;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ShimmerText(
        isLoading: isLoading,
        child: Text(
          message,
          style: context.textTheme?.titleMedium,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
