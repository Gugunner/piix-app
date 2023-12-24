import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/data/repository/levels_deprecated/levels_repository_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/levels_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/level/level_quotation_builder_deprecated.dart';
import 'package:piix_mobile/ui/common/piix_confirm_alert_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget is a main level quotation screen, includes a level quotation
///builder
///
class LevelQuotationHomeScreenDeprecated extends StatelessWidget {
  static const routeName = '/levels_quotation__home_screen';
  const LevelQuotationHomeScreenDeprecated({super.key});

  static const getting = LevelStateDeprecated.getting;
  static const idle = LevelStateDeprecated.idle;

  @override
  Widget build(BuildContext context) {
    final levelState = context.watch<LevelsBLoCDeprecated>().levelState;
    final isGetting = levelState == getting || levelState == idle;

    return WillPopScope(
      onWillPop: () => exitLevelQuotation(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(isGetting
              ? PiixCopiesDeprecated.quotationLabel
              : PiixCopiesDeprecated.quoteGenerated),
          centerTitle: true,
          elevation: 0,
        ),
        body: const LevelQuotationBuilderDeprecated(),
      ),
    );
  }

  ///This future shows the dialog when you want to exit or return to the
  ///previous screen
  Future<bool> exitLevelQuotation(BuildContext context) async {
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
