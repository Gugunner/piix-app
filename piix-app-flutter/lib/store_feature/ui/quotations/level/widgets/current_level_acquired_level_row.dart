import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

///This widget contains a row with a current level and acquired level
///
class CurrentLevelAcquiredLevelRow extends StatelessWidget {
  const CurrentLevelAcquiredLevelRow({
    super.key,
    required this.currentQuotationLevel,
    required this.currentLevel,
  });
  final String currentQuotationLevel;
  final String currentLevel;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text.rich(
          TextSpan(children: [
            const TextSpan(
              text: '${PiixCopiesDeprecated.currentLevelIs}\n',
            ),
            TextSpan(
              text: currentLevel,
              style: context.primaryTextTheme?.titleMedium,
            ),
          ], style: context.textTheme?.bodyMedium),
          textAlign: TextAlign.center,
        ),
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: '${PiixCopiesDeprecated.quotationLevelIs}\n',
              ),
              TextSpan(
                text: currentQuotationLevel,
                style: context.primaryTextTheme?.titleMedium,
              ),
            ],
            style: context.textTheme?.bodyMedium,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
