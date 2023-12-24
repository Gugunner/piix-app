import 'package:flutter/material.dart';
import 'package:piix_mobile/verification_code_feature/ui/widgets/verification_code/verification_code_widget_deprecated.dart';


@Deprecated('Use instead VerificationCodeBoxes')
class VerificationCodesBuilderDeprecated extends StatelessWidget {
  const VerificationCodesBuilderDeprecated({
    super.key,
    this.codeWidgetCount = 6,
    this.hasError = false,
  });

  final int codeWidgetCount;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final codeWidgets = <Flexible>[];
        for (var index = 0; index < codeWidgetCount; index++) {
          final codeWidget = Flexible(
            child: VerificationCodeWidgetDeprecated(
              index: index,
              hasError: hasError,
            ),
          );
          codeWidgets.add(codeWidget);
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: codeWidgets,
        );
      },
    );
  }
}
