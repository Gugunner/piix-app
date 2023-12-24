import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/modal/modal_barrel_file.dart';
import 'package:piix_mobile/widgets/stepper/app_stepper_barrel_file.dart';

///A predefined [Dialog] that shows the instructions step by step
///on where to purchase new assistances.
class WhereToPurchaseAssistanceDialog extends StatelessWidget
    with StepperAppBadgeStepper {
  const WhereToPurchaseAssistanceDialog({super.key});

  ///The space between the title of the [AppModal]
  ///and its child.
  double get _childGap => 32.h;

  ///The space between the child of the [AppModal]
  ///and its actions.
  double get _actionGap => 20.h;

  void _navigateToStore(BuildContext context) {
    //TODO: navigate to StoreScreen
  }

  ///Pops the [AppModal]
  void _exit(BuildContext context) {
    NavigatorKeyState().getNavigator()?.pop();
  }

  ///Retrieves the 'Where to buy assistances?' message.
  String _getWhereToBuyMessage(BuildContext context) =>
      context.localeMessage.whereToBuy;

  String _getEnterStoreMessage(BuildContext context) =>
      context.localeMessage.enterStore;

  String _getFromTheStoreExploreMessage(BuildContext context) =>
      context.localeMessage.fromTheStoreExplore;

  String _getAddEventsMessage(BuildContext context) =>
      context.localeMessage.addEvents;

  String _getImproveYourCoverageMessage(BuildContext context) =>
      context.localeMessage.improveYourCoverage;

  String _getQuoteAndPayMessage(BuildContext context) =>
      context.localeMessage.quoteAndPay;

  String _getGeneratePaymentLineMessage(BuildContext context) =>
      context.localeMessage.generatePaymentLine;

  String _getGoToStoreActionMessage(BuildContext context) =>
      context.localeMessage.goToStore;

  String _getAcceptActionMessage(BuildContext context) =>
      context.localeMessage.accept;

  @override
  Map<int, List<String>> getSteps(BuildContext context) => {
        1: [
          _getEnterStoreMessage(context),
          _getFromTheStoreExploreMessage(context)
        ],
        2: [
          _getAddEventsMessage(context),
          _getImproveYourCoverageMessage(context)
        ],
        3: [
          _getQuoteAndPayMessage(context),
          _getGeneratePaymentLineMessage(context)
        ],
      };

  @override
  Widget build(BuildContext context) {
    return AppModal(
      title: AppModalTitle(
        _getWhereToBuyMessage(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...getSteps(context).entries.map(
                (entry) => getAppStepper(entry, context),
              ),
        ],
      ),
      childGap: _childGap,
      actionGap: _actionGap,
      onAccept: () => _navigateToStore(context),
      onAcceptText: _getGoToStoreActionMessage(context),
      onCancel: () => _exit(context),
      onCancelText: _getAcceptActionMessage(context),
    );
  }
}
