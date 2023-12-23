import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/animation_bloc_deprecated.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_error_screen_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/store_feature/data/repository/plans/plans_repository.dart';
import 'package:piix_mobile/store_feature/domain/bloc/plans_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/quote_price_request_model/plans_quote_price_request_model_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/plans/managing_deprecated/plan_ui_state_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/loaders/quotation_loading_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/plans_data_quotation.dart';
import 'package:piix_mobile/ui/common/piix_confirm_alert_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget is a main screen of quotation plans, in this screen depending on
///the state can show the charger, the data or the empty screen.
/// When there is an error, a navigation is made to the quote creation screen.
///
class PlanQuotationHomeScreenDeprecated extends StatefulWidget {
  static const routeName = '/plans_quotation__home_screen';
  const PlanQuotationHomeScreenDeprecated({super.key});

  @override
  State<PlanQuotationHomeScreenDeprecated> createState() =>
      _PlanQuotationHomeScreenDeprecatedState();
}

class _PlanQuotationHomeScreenDeprecatedState
    extends State<PlanQuotationHomeScreenDeprecated> {
  PlanStateDeprecated get idle => PlanStateDeprecated.idle;
  PlanStateDeprecated get getting => PlanStateDeprecated.getting;
  PlanStateDeprecated get accomplished => PlanStateDeprecated.accomplished;
  PlanStateDeprecated get empty => PlanStateDeprecated.empty;
  PlanStateDeprecated get error => PlanStateDeprecated.error;
  PlanStateDeprecated get unexpectedError =>
      PlanStateDeprecated.unexpectedError;
  AnimationStatesDeprecated get animationLoading =>
      AnimationStatesDeprecated.LOADING;
  AnimationStatesDeprecated get animationFinish =>
      AnimationStatesDeprecated.FINISH;
  int get millisecondsDelayeTime => 4500;
  late PlansBLoCDeprecated plansBLoC;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final planUiState =
          ModalRoute.of(context)!.settings.arguments as PlanUiStateDeprecated;
      final _state = await getPlanDetail();
      Future.delayed(Duration(milliseconds: millisecondsDelayeTime), () {
        if (_state == error) {
          planUiState
            ..planAlertState = AlertStateDeprecated.show
            ..planAlertType = AlertTypeDeprecated.error
            ..hidePlanAlert();
          NavigatorKeyState().getNavigator()?.pop();
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final usefullScreenHeight = context.height - kToolbarHeight;
    plansBLoC = context.watch<PlansBLoCDeprecated>();
    final quotationPlanState = plansBLoC.quotationPlanState;
    final quotationAnimatedState =
        context.watch<AnimationBLoCDeprecated>().quotationAnimatedState;
    final isGetting = quotationAnimatedState == animationLoading ||
        quotationPlanState == getting ||
        quotationPlanState == idle ||
        quotationPlanState == unexpectedError ||
        quotationPlanState == error;

    return WillPopScope(
      onWillPop: () => exitQuotation(context),
      child: Scaffold(
          appBar: AppBar(
            title: const Text(PiixCopiesDeprecated.quoteGenerated),
            centerTitle: true,
            elevation: 0,
          ),
          body: SizedBox(
            height: usefullScreenHeight,
            width: context.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isGetting)
                  const Expanded(child: QuotationLoadingScreenDeprecated())
                else if (quotationPlanState == accomplished &&
                    quotationAnimatedState == animationFinish)
                  const Expanded(child: PlansDataQuotation())
                else if (quotationPlanState == empty ||
                    quotationPlanState == PlanStateDeprecated.error ||
                    quotationPlanState == PlanStateDeprecated.unexpectedError ||
                    quotationPlanState == PlanStateDeprecated.conflict ||
                    quotationPlanState == PlanStateDeprecated.notFound)
                  PiixErrorScreenDeprecated(
                    errorMessage: PiixCopiesDeprecated.emptyErrorQuotation,
                    onTap: () async => getPlanDetail(),
                  )
              ],
            ),
          )),
    );
  }

  ///This future shows the dialog when you want to exit or return to the
  ///previous screen
  Future<bool> exitQuotation(BuildContext context) async {
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
          actionBottomPadding: 16.h,
        ),
      );

  //This future, retreive a quotation for package combo
  Future<PlanStateDeprecated> getPlanDetail() async {
    final membershipBLoC = context.read<MembershipProviderDeprecated>();
    final planIds = plansBLoC.currentPlanIds;
    final requestModel = PlansQuotePriceRequestModel(
      membershipId: membershipBLoC.selectedMembership!.membershipId,
      planIds: planIds!,
    );
    final _planState = await plansBLoC.getPlansQuotationByMembership(
      requestModel: requestModel,
    );
    return _planState;
  }
}
