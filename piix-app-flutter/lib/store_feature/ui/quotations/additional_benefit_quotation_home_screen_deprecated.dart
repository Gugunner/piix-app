import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/ui/quotations/additional_benefit_quotation_builder_deprecated.dart';
import 'package:piix_mobile/ui/common/piix_confirm_alert_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This widget is a main screen for additional benefit quotation
///depending on the state render screen with data, skeletons, empty screen or
///error screen
///
class AdditionalBenefitQuotationHomeScreenDeprecated extends StatelessWidget {
  static const routeName = '/additional_benefit_quotation_home_screen';
  const AdditionalBenefitQuotationHomeScreenDeprecated({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exitAdditionalBenefitQuotation(context),
      child: Scaffold(
          appBar: AppBar(
            title: const Text(PiixCopiesDeprecated.quoteGenerated),
            centerTitle: true,
            elevation: 0,
          ),
          backgroundColor: PiixColors.greyWhite,
          body: const AdditionalBenefitQuotationBuilderDeprecated()),
    );
  }

  ///This future shows the dialog when you want to exit or return to the
  ///previous screen
  Future<bool> exitAdditionalBenefitQuotation(BuildContext context) async {
    final shouldPop = await handlePopDialog(context);
    return shouldPop ?? false;
  }

  //This feature open a pop dialog to tell the user if he really wants to quit
  Future<bool?> handlePopDialog(BuildContext context) async => showDialog<bool>(
        context: context,
        builder: (_) => PiixConfirmAlertDialogDeprecated(
          title: PiixCopiesDeprecated.sureToExitQuotation,
          titleStyle: context.textTheme?.headlineSmall?.copyWith(
            color: PiixColors.primary,
          ),
          message: PiixCopiesDeprecated.pressAcceptDeleteQuotation,
          onCancel: () => Navigator.pop(context, false),
          onConfirm: () => Navigator.pop(context, true),
        ),
      );
}
