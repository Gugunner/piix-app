import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/plans_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/plans/create_plan_alerts_wrap_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/plans/widgets/plans_info_dialog_deprecated.dart';
import 'package:piix_mobile/ui/common/piix_confirm_alert_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This is the main screen for Plans module, only shows a scaffold, actions,
///pop up dialog and ui wrapper
///

class PlansHomeScreenDeprecated extends StatelessWidget {
  static const routeName = '/plans_home_screen';
  const PlansHomeScreenDeprecated({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exitQuoteCreation(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(PiixCopiesDeprecated.createYourQuotation),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () => handleInfoDialog(context),
                icon: const Icon(Icons.info_outline)),
          ],
        ),
        body: const CreatePlanAlertsWrapDeprecated(),
      ),
    );
  }

  ///This future shows the dialog when you want to exit or return to the
  ///previous screen
  Future<bool> exitQuoteCreation(BuildContext context) async {
    final shouldPop = await handlePopDialog(context);
    if (shouldPop ?? false) {
      final plansBLoC = context.read<PlansBLoCDeprecated>();
      plansBLoC.protectedCount = 0;
    }
    return shouldPop ?? false;
  }

  //This feature open a pop dialog to tell the user if he really wants to quit
  Future<bool?> handlePopDialog(BuildContext context) async => showDialog<bool>(
        context: context,
        builder: (_) => PiixConfirmAlertDialogDeprecated(
          title: PiixCopiesDeprecated.sureToExit,
          message: PiixCopiesDeprecated.loseQuotation,
          child: Text(
            PiixCopiesDeprecated.alwaysCanQuote,
            style: context.textTheme?.bodyMedium,
          ),
          onCancel: () => Navigator.pop(context, false),
          onConfirm: () => Navigator.pop(context, true),
          actionBottomPadding: 16.h,
        ),
      );

  //This function open a info plans dialog
  void handleInfoDialog(BuildContext context) => showDialog<void>(
        context: context,
        barrierColor: PiixColors.mainText.withOpacity(0.62),
        builder: (context) => const PlansInfoDialogDeprecated(),
      );
}
