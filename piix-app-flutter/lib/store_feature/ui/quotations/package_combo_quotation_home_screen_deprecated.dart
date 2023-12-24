import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/ui/quotations/package_combo_quotation_builder_deprecated.dart';
import 'package:piix_mobile/ui/common/piix_confirm_alert_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a package combo quotation home screen, this screen
///shows a diferent ui depends of the [PackageComboState]
///
class PackageComboQuotationHomeScreenDeprecated extends StatelessWidget {
  static const routeName = '/package_combo_quotation_screen';
  const PackageComboQuotationHomeScreenDeprecated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exitComboQuotation(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(PiixCopiesDeprecated.quoteGenerated),
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: PiixColors.greyWhite,
        body: const PackageComboQuotationBuilderDeprecated(),
      ),
    );
  }

  ///This future shows the dialog when you want to exit or return to the
  ///previous screen
  Future<bool> exitComboQuotation(BuildContext context) async {
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
