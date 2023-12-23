import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_wrap.dart';
import 'package:piix_mobile/membership_feature/membership_ui_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';

///A [Column] component that has [AppTextSizedButton]s to launch
///specific membership dialogs to let the user know how to
///purchase new assistances and request them.
final class MembershipHomeScreenDialogs extends StatelessWidget {
  const MembershipHomeScreenDialogs({
    super.key,
    this.isLoading = false,
  });

  final bool isLoading;

  ///Launches a dialog that explains where to purchase new assistances.
  void _showWhereToPurchaseDialog(BuildContext context) async => showDialog(
      context: context,
      builder: (buildContext) => const WhereToPurchaseAssistanceDialog());

  ///Launches a dialog that explains how to request an assistance.
  void _showHowToRequestDialog(BuildContext context) async => showDialog(
      context: context,
      builder: (buildContext) => const HowToRequestAnAssistanceDialog());

  ///Retrieves the 'Where to buy assistances?' message.
  String _getWhereToBuyMessage(BuildContext context) =>
      context.localeMessage.whereToBuy;

  ///Retrieves the 'How to request an assistance?' message.
  String _getHowToRequestMessage(BuildContext context) =>
      context.localeMessage.howToRequestAssistance;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerWrap(
          child: AppTextSizedButton.title(
            onPressed: () => _showWhereToPurchaseDialog(context),
            text: _getWhereToBuyMessage(context),
          ),
        ),
        SizedBox(height: 4.h),
        ShimmerWrap(
          child: AppTextSizedButton.title(
            onPressed: () => _showHowToRequestDialog(context),
            text: _getHowToRequestMessage(context),
          ),
        ),
      ],
    );
  }
}
