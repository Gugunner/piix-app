import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/api/local/app_shared_preferences.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/membership_feature/membership_model_barrel_file.dart';
import 'package:piix_mobile/membership_feature/membership_provider_barrel_file.dart';
import 'package:piix_mobile/membership_feature/membership_screen_barrel_file.dart';
import 'package:piix_mobile/navigation_feature/navigation_utils_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/app_bar/logo_app_bar.dart';
import 'package:piix_mobile/widgets/app_loading_widget/app_loading_widget.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';


///The screen which appears when the user has has confirmed her
///information and is now being reviewd.
///
///This screen allows the user to linkup her inactive membership to either
///a community or a family group as an optional step while waiting.
///
///When this is being loaded for the first time it retrieves the 
///inactive user membership and if an error occurs or the membership
///[linkupModel] property is null then it will try to retrieve a [linkupModel]
///from the [AppSharedPreferences] and set the value into [_linkupModel].
///
///The user cannot link a membership if there is already a [linkupModel]
///loaded. Meaning that the user has already linked up her membership.
final class WaitingMembershipReviewScreen extends AppLoadingWidget {
  static const routeName = '/waiting_membership_revision_screen';

  const WaitingMembershipReviewScreen({super.key});

  @override
  ConsumerState<WaitingMembershipReviewScreen> createState() =>
      _WaitingMembershipReviewScreenState();
}

final class _WaitingMembershipReviewScreenState
    extends AppLoadingWidgetState<WaitingMembershipReviewScreen>
    with ExitPrompt {
  ///Stores the actual value either [whileIsRequesting] or 
  ///after returning from a successful linkup event.
  LinkupCodeTypeModel? _linkupModel;

  ///Navigates to the [LinkupMembershipScreen] and waits
  ///for the popped value which is stored in [_linkupModel].
  void _navigateToLinkupMembershipScreen() async {
    //If this has not finished loading it does nothing and exits.
    if (isRequesting) return;
    final linkupModel =
        await NavigatorKeyState().slideToTopRoute<LinkupCodeTypeModel?>(
      page: const LinkupMembershipScreen(),
      routeName: LinkupMembershipScreen.routeName,
    );
    setState(() {
      _linkupModel = linkupModel;
    });
  }

  String _getSuccesfulFamilyGroupLinkupMessage(String name) =>
      context.localeMessage.successfulFamilyGroupLinkupMessage(name);

  String _getSuccessComunnityLinkupMessage(String name) =>
      context.localeMessage.successfulCommunityLinkupMessage(name);

  String get _successfulLinkupMessage {
    final type = _linkupModel!.type;
    final name = _linkupModel!.name;
    if (type == LinkupCodeType.userGroup)
      return _getSuccesfulFamilyGroupLinkupMessage(name);
    return _getSuccessComunnityLinkupMessage(name);
  }

  @override
  Future<void> whileIsRequesting() async {
    LinkupCodeTypeModel? linkupModel;
    final asyncValue = ref.watch(userMembershipPodProvider);
    //If the request is still in the process it exits the method.
    if (asyncValue is AsyncLoading) return;
    //If data is found then it assigns the linupModel value from the 
    //loaded membership.
    if (asyncValue is AsyncData) {
      linkupModel = ref.read(membershipPodProvider)?.linkupModel;
    }
    //
    if (linkupModel == null || asyncValue is AsyncError) {
      //This is a temporal solution while the service returns the linkupModel
      //in its schematic, for now the model is stored in [SharedPreferences].
      linkupModel = await AppSharedPreferences.recoverLinkupModel();
    }
    Future.microtask(() => setState(() {
          _linkupModel = linkupModel;
        }));
    return endRequest();
  }

  @override
  Widget build(BuildContext context) {
    if (isRequesting) whileIsRequesting();
    return WillPopScope(
      onWillPop: () async => (await showExitAppPrompt(context)) ?? false,
      child: Scaffold(
        appBar: LogoAppBar(
          elevation: 0,
          backgroundColor: PiixColors.space,
          logoColor: PiixColors.primary,
          size: Size(63.w, 36.h),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(16.w, 13.h, 16.w, 0),
          child: Column(
            children: [
              Text(
                context.localeMessage.weAreReviewingYourInformation,
                style: context.primaryTextTheme?.displayMedium
                    ?.copyWith(color: PiixColors.infoDefault),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              SizedBox(
                height: 121.h,
                width: 168.w,
                child: Image.asset(PiixAssets.saveTime),
              ),
              SizedBox(height: 26.h),
              Text(
                context.localeMessage.piixTeamIsReviewingYourInformation,
                style: context.titleMedium
                    ?.copyWith(color: PiixColors.infoDefault),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: context.width,
                child: Text(
                  context.localeMessage.doYouHaveAnInvitationCode,
                  style: context.titleMedium?.copyWith(
                    color: PiixColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: 176.w,
                height: 40.h,
                child: AppOutlinedSizedButton(
                  text: context.localeMessage.enterCode.toUpperCase(),
                  onPressed: _linkupModel == null
                      ? _navigateToLinkupMembershipScreen
                      : null,
                ),
              ),
              if (_linkupModel != null)
                Container(
                  margin: EdgeInsets.only(top: 8.h),
                  child: Text(
                    _successfulLinkupMessage,
                    style: context.primaryTextTheme?.titleSmall
                        ?.copyWith(color: PiixColors.primary),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
