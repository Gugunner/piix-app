import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/navigation_feature/navigation_utils_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/modal/modal_barrel_file.dart';
import 'package:piix_mobile/widgets/stepper/app_stepper_barrel_file.dart';

final class HowToLinkupMyMembershipDialog extends StatelessWidget
    with StepperAppBadgeStepper {
  const HowToLinkupMyMembershipDialog({super.key});

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

  String _getHowToLinkupMyMembershipMessage(BuildContext context) =>
      context.localeMessage.howToLinkupMyMembership;

  String _getToAFamilyGroupMessage(BuildContext context) =>
      context.localeMessage.toAFamilyGroup;

  String _getEnterTheCodeAFamilyMemberMessage(BuildContext context) =>
      context.localeMessage.enterTheCodeAFamilyMember;

  String _getToACommunityMessage(BuildContext context) =>
      context.localeMessage.toACommunity;

  String _getIfYouBelongToACommunityMessage(BuildContext context) =>
      context.localeMessage.ifYouBelongToACommunity;

  String _getImportantMessage(BuildContext context) =>
      '${context.localeMessage.important}:';

  String _getMakeSureToLinkupYourMembershipMessage(BuildContext context) =>
      context.localeMessage.makeSureToLinkupYourMembership;

  String _getAcceptActionMessage(BuildContext context) =>
      context.localeMessage.accept;

  @override
  Map<int, List<String>> getSteps(BuildContext context) => {
        1: [
          _getToAFamilyGroupMessage(context),
          _getEnterTheCodeAFamilyMemberMessage(context),
        ],
        2: [
          _getToACommunityMessage(context),
          _getIfYouBelongToACommunityMessage(context),
        ],
      };

  @override
  Widget build(BuildContext context) {
    return AppModal(
      title: AppModalTitle(
        _getHowToLinkupMyMembershipMessage(context),
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
                _getMakeSureToLinkupYourMembershipMessage(context),
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
