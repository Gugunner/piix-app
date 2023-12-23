import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/frequent_questions_dialog.dart';

@Deprecated('Will be removed in 4.0')
class FrequentQuestionsButtonDeprecated extends StatelessWidget {
  const FrequentQuestionsButtonDeprecated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => handleFrequentDialog(context),
      child: Text(
        PiixCopiesDeprecated.youHaveAQuestion,
        style: context.accentTextTheme?.headlineLarge?.copyWith(
          color: PiixColors.active,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  void handleFrequentDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => const FrequentQuestionsDialogDeprecated(),
    );
  }
}
