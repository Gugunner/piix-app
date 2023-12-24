import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_feature/domain/provider/user_provider.dart';
import 'package:piix_mobile/general_app_feature/api/local/app_shared_preferences.dart';
import 'package:piix_mobile/membership_feature/membership_model_barrel_file.dart';
import 'package:piix_mobile/membership_feature/membership_provider_barrel_file.dart';
import 'package:piix_mobile/membership_feature/membership_screen_barrel_file.dart';
import 'package:piix_mobile/membership_feature/membership_ui_barrel_file.dart';
import 'package:piix_mobile/membership_feature/utils/extension/link_step_extension.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/app_bar/app_bar_barrel_file.dart';
import 'package:piix_mobile/widgets/banner/banner_barrel_file.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';
import 'package:piix_mobile/widgets/app_loading_widget/app_loading_widget.dart';

///This screen is used to enter the invitation code that the user
///has to linkup her membership to either a community or a family group.
///
///The process to linkup its membership has three different stages which
///derive from the [MembershipLinkStep] values.
///
///The first stage is [MembershipLinkStep.idle] and it is where the user
///first submits its [_linkCode] to verified and assigned to either a community
///or a family group, if the [_linkCode] is a valid code it will return a
///[LinkCodeTypeModel] with the [LinkCodeTypeModel.type] and
///[LinkCodeTypeModel.name] of the community or family group to whom the
///[_linkCode] belongs to.
///
///When the code is validated it executes [_advanceMembershipLinkStep]
///and the next stage is [MembershipLinkStep.check] to indicate that the
///check stage has been fulfilled.
///
///Finally the user can submit the code to linkup the community or family group
///to her membership.
class LinkupMembershipScreen extends AppLoadingWidget {
  static const routeName = '/linkup_membership_screen';
  const LinkupMembershipScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LinkupMembershipScreenState();
}

class _LinkupMembershipScreenState
    extends AppLoadingWidgetState<LinkupMembershipScreen> with ExitPrompt {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ///Enables or disables the [LinkupMembershipField].
  bool _canEditCode = true;

  ///Keeps the state of the link step.
  MembershipLinkStep _linkStep = MembershipLinkStep.idle;

  ///Stores any error thrown by the api request.
  AppApiException? _apiError;

  ///Stores the succesful response of the api request.
  String? _linkupCode;

  LinkupCodeTypeModel? _linkupModel;

  ///The space between main elements.
  double get _height => 40.h;

  String get _sendInvitationCodeMessage =>
      context.localeMessage.sendInvitationalCode;

  String get _confirmLinkageMessage => context.localeMessage.confirmLinkage;

  String get _submitMessage {
    if (_linkStep == MembershipLinkStep.idle) return _sendInvitationCodeMessage;
    return _confirmLinkageMessage;
  }

  String get _userId => ref.read(userPodProvider)?.userId ?? '';

  ///Shows a specific error when the code cannot
  ///be checked or cannot be linked.
  void _launchErrorBanner() {
    final localeMessage = context.localeMessage;
    final description = _linkStep == MembershipLinkStep.idle
        ? localeMessage.checkLinkupCodeError
        : localeMessage.linkupCodeError;
    Future.microtask(() {
      ref.read(bannerPodProvider.notifier)
        ..setBanner(
          context,
          cause: BannerCause.error,
          description: description,
          actionText: localeMessage.retry,
          action: () {
            if (mounted) {
              setState(() {
                isSubmitting = true;
              });
            }
          },
        )
        ..build();
    });
  }

  void _onError(Object? error) {
    if (error is! AppApiException ||
        (error.errorCodes?.isNullOrEmpty ?? true) &&
            //All of the following errors are handled in the form field itself.
            !error.errorCodes!.contains(apiInvalidLinkupCode) &&
            !error.errorCodes!.contains(apiUserIsAlreadyInACommunity) &&
            !error.errorCodes!.contains(apiUserIsAlreadyInTheCommunity) &&
            !error.errorCodes!.contains(apiInvalidInvitationCode) &&
            !error.errorCodes!.contains(apiUserCannotUseSlot) &&
            !error.errorCodes!.contains(apiUserIsAlreadyInGroup) &&
            !error.errorCodes!.contains(apiSlotIsNotOpen)) {
      return _launchErrorBanner();
    }
    //The error code is handled by the Field itself and shows
    //an error text.
    Future.microtask(() => setState(() {
          _apiError = error;
        }));
  }

  ///Launches and handles the request of the service to check the
  ///linkup membership invitation code.
  Future<void> whileSubmittingCodeInvitationCheck() async => ref
          .watch(linkupCodeTypePodProvider(_linkupCode ?? ''))
          .whenOrNull(data: (linkupModel) {
        Future.microtask(() {
          setState(() {
            _linkupModel = linkupModel;
            if (_canEditCode) _canEditCode = false;
          });
          _advanceMembershipLinkStep();
        });
        endSubmit();
      }, error: (error, stackTrace) {
        _onError(error);
        endSubmit();
      });

  void _navigateToSuccessLinkupMembershipScreen() => Future.microtask(() async {
        //To pass arguments only pushNamed screens can be used.
        await Navigator.of(context).pushNamed(
          SuccessLinkupMembershipScreen.routeName,
          arguments: _linkupModel,
        );
        //Once the other screen is popped it returns to the previous screen
        //and passes over the linked up values.
        Navigator.pop(context, _linkupModel);
      });

  Future<void> whileSubmittingCodeInvitation() async => ref
          .watch(linkupMembershipPodProvider(
        userId: _userId,
        linkupCodeType: _linkupModel!.type,
        linkupCode: _linkupCode!,
      ))
          .whenOrNull(data: (_) async {
        //Makes sure to store the linkup values if they are not present
        //in the membership so it can be retrieved when the app is closed
        //and opened again.
        await AppSharedPreferences.saveLinkupModel(_linkupModel!);
        _navigateToSuccessLinkupMembershipScreen();
        endSubmit();
      }, error: (error, stackTrace) {
        _onError(error);
        endSubmit();
      });

  @override
  Future<void> whileIsSubmitting() async {
    ///If the step is idle it means that the invitation code
    ///first must be validated.
    if (_linkStep == MembershipLinkStep.idle) {
      return whileSubmittingCodeInvitationCheck();
    }
    return whileSubmittingCodeInvitation();
  }

  ///Handles the next state change for the [_linkStep]
  ///based on its current state
  void _advanceMembershipLinkStep() {
    //Once the step reaches 'check' it will not advance more.
    if (_linkStep == MembershipLinkStep.check) return;

    return setState(() {
      _linkStep = MembershipLinkStep.check;
    });
  }

  ///Handles any submit action in the screen.
  void _onSubmit() {
    //Checks that the form has a valid format input.
    if (_formKey.currentState == null) return;
    _formKey.currentState!.save();
    if (!_formKey.currentState!.validate()) return;
    //Set isRequesting to true so the whileIsRequesting
    //method can be triggered.
    setState(() {
      isSubmitting = true;
      //Resets any api error that may have occurred previously.
      _apiError = null;
    });
  }

  ///Toggles the [_canEditCode] to true
  ///and resest [_linkStep].
  void _onEditCode() {
    setState(() {
      _canEditCode = true;
      _linkStep = MembershipLinkStep.idle;
    });
  }

  ///Stores the value of the [LinkupMembershipField]
  ///to be used in [whileIsRequesting] api call.
  void _onSaved(String? value) {
    if (value == null) return;
    setState(() {
      _linkupCode = value;
    });
  }

  ///Resets all states handled in this [Widget].
  void _reset() {
    setState(() {
      _linkStep = MembershipLinkStep.idle;
      _linkupModel = null;
      _canEditCode = true;
      _apiError = null;
    });
  }

  //If the invitation code is changed it resets
  //all values.
  void _onChanged(String? value) {
    //If the code is changed the code cannot be edited again and the
    //_linkType resets.
    if (_linkStep != MembershipLinkStep.idle ||
        _linkupModel != null ||
        _canEditCode == false ||
        _apiError != null) _reset();
  }

  //Cleans any app state stored when popping the screen
  Future<bool> _onWillPop() async {
    //Can't pop screen while service is requesting
    if (isSubmitting) {
      return showBlockedBackPrompt(context);
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (isSubmitting) whileIsSubmitting();
    return IgnorePointer(
      ignoring: isSubmitting,
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: TitleAppBar(context.localeMessage.linkMembership),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: _height),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    LinkupMembershipCard(
                      canEditCode: _canEditCode,
                      onEditCode: _onEditCode,
                      onChanged: _onChanged,
                      onSaved: _onSaved,
                      apiError: _apiError,
                    ),
                    SizedBox(height: _height),
                    //Only if the api response is succesful and the linkStep
                    //advances it can show to what linkType the membership is
                    //being linked up to.
                    if (_linkupModel != null &&
                        _linkStep != MembershipLinkStep.idle)
                      MembershipLinkupTo(_linkupModel!),
                    SizedBox(height: _height),
                    AppFilledSizedButton(
                      text: _submitMessage,
                      onPressed: _onSubmit,
                      loading: isSubmitting,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
