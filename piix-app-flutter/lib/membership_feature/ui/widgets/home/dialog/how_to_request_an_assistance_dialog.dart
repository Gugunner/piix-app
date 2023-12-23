import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/modal/modal_barrel_file.dart';
import 'package:piix_mobile/widgets/stepper/app_stepper_barrel_file.dart';

///A predefined [Dialog] that shows the instructions step by step
///on how to request an assistance.
final class HowToRequestAnAssistanceDialog extends StatelessWidget
    with StepperAppBadgeStepper {
  const HowToRequestAnAssistanceDialog({super.key});

  ///The space between the title of the [AppModal]
  ///and its child.
  double get _childGap => 32.h;

  ///The space between the child of the [AppModal]
  ///and its actions.
  double get _actionGap => 36.h;

  ///The space between the steps and the note.
  double get _gap => 16.h;

  ///Pops the [AppModal]
  void _exit(BuildContext context) {
    NavigatorKeyState().getNavigator()?.pop();
  }

  ///Retrieves the 'How to request an assistance?' message.
  String _getHowToRequestMessage(BuildContext context) =>
      context.localeMessage.howToRequestAssistance;

  String _getFromTheAssistanceListMessage(BuildContext context) =>
      context.localeMessage.fromTheAssistanceList;

  String _getRequestDirectlyMessage(BuildContext context) =>
      context.localeMessage.requestDirectly;

  String _getInsideTheAssistanceDetailMessage(BuildContext context) =>
      context.localeMessage.insideTheAssistanceDetail;

  String _getFromAnyAssistanceMessage(BuildContext context) =>
      context.localeMessage.fromAnyAssistance;

  String _getImportantMessage(BuildContext context) =>
      '${context.localeMessage.important}:';

  String _getToBeAbleToRequestMessage(BuildContext context) =>
      context.localeMessage.toBeAbleToRequest;

  String _getAcceptActionMessage(BuildContext context) =>
      context.localeMessage.accept;

  @override
  Map<int, List<String>> getSteps(BuildContext context) => {
        1: [
          _getFromTheAssistanceListMessage(context),
          _getRequestDirectlyMessage(context)
        ],
        2: [
          _getInsideTheAssistanceDetailMessage(context),
          _getFromAnyAssistanceMessage(context)
        ],
      };

  @override
  Widget build(BuildContext context) {
    return AppModal(
      title: AppModalTitle(
        _getHowToRequestMessage(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...getSteps(context).entries.map(
                (entry) => getAppStepper(entry, context),
              ),
          SizedBox(height: _gap),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _getImportantMessage(context),
                style: context.primaryTextTheme?.titleSmall,
              ),
              Text(
                _getToBeAbleToRequestMessage(context),
                style: context.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          )
        ],
      ),
      childGap: _childGap,
      actionGap: _actionGap,
      onAccept: () => _exit(context),
      onAcceptText: _getAcceptActionMessage(context),
    );
  }
}
