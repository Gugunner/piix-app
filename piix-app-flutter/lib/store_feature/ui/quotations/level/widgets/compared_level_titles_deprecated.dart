import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')

///This widget contains a row with a current level and acquired level
///
class ComparedLevelTitlesDeprecated extends StatelessWidget {
  const ComparedLevelTitlesDeprecated({
    super.key,
    required this.newLevelName,
    required this.currentLevelName,
  });

  final String newLevelName;
  final String currentLevelName;

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
              text: currentLevelName,
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
                text: newLevelName,
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
