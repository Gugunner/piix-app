import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/navigation_deprecated/navigation_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:provider/provider.dart';

/// Creates a blank slate when the list of additions is empty.
class PlaceEmptyList extends StatelessWidget {
  const PlaceEmptyList({Key? key, required this.placeholderText})
      : super(key: key);
  final String placeholderText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              placeholderText,
              style: context.textTheme?.bodyMedium,
            ),
          ),
          TextButton(
              onPressed: () => handleNavigateToStore(context),
              child: Text(
                PiixCopiesDeprecated.buyText,
                style: context.primaryTextTheme?.titleMedium?.copyWith(
                  color: PiixColors.active,
                ),
              ))
        ],
      ),
    );
  }

  void handleNavigateToStore(BuildContext context) {
    final navigationProvider = context.read<NavigationProviderDeprecated>();
    navigationProvider.setCurrentNavigationBottomTab(2);
  }
}
