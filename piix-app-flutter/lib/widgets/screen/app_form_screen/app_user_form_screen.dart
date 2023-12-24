import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/comms_feature/domain/provider/communication_provider.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/form_feature/ui/form_field_input_builder_deprecated.dart';
import 'package:piix_mobile/utils/providers/app_banner_provider.dart';
import 'package:piix_mobile/utils/shimmer/shimmer.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_loading.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_wrap.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/form_generic_error_text.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_icons.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/user_form_feature/domain/user_form_provider_deprecated.dart';
import 'package:piix_mobile/utils/app_copies_barrel_file.dart';
import 'package:piix_mobile/utils/log_utils.dart';
import 'package:piix_mobile/widgets/app_bar/logo_app_bar.dart';
import 'package:piix_mobile/widgets/banner/banner_barrel_file.dart';
import 'package:piix_mobile/widgets/button/elevated_app_button_deprecated/elevated_app_button_deprecated.dart';
import 'package:piix_mobile/widgets/button/text_app_button/text_app_button_deprecated.dart';
import 'package:piix_mobile/widgets/app_loading_widget/app_loading_widget.dart';
import 'package:piix_mobile/widgets/screen/app_screen/pop_app_screen.dart';

abstract class AppUserFormScreen extends AppLoadingWidget {
  const AppUserFormScreen({
    super.key,
    required this.title,
    super.message,
    this.informationalContent,
  });

  final String title;
  final Widget? informationalContent;
}

abstract class AppUserFormScreenState
    extends AppLoadingWidgetState<AppUserFormScreen> with LogAnalytics {
  final screenFormKey = GlobalKey<FormState>();
  final scrollController = ScrollController();
  bool isSending = false;
  final bool _isLaunchingSupport = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      endRequest();
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void onUnfocus() {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    setState(() {});
  }

  @mustCallSuper
  Future<bool> onWillPop() async {
    ref.read(bannerPodProvider.notifier).removeBanner();
    return true;
  }

  void onCheckForm();

  ///Executes an Asynchrounous operation that can be run with
  ///a ref.watch(provider).whenOrNull()
  ///``` @override
  ///
  ///Widget build(BuildContext context) {
  ///
  ///if (isSending) whileIsSending()();
  ///
  ///return Container()
  ///
  ///} ```

  void whileIsSending();

  @override
  Widget build(BuildContext context) {
    final formNotifier = ref.watch(formNotifierProvider.notifier);
    final formFields = formNotifier.formFields;
    final submitDisable =
        isSending || !formNotifier.requiredFieldsFilled(formFields);
    if (isRequesting) whileIsRequesting();
    if (isSending) whileIsSending();
    return PopAppScreen(
      onWillPop: onWillPop,
      onUnfocus: onUnfocus,
      shouldIgnore: isRequesting || isSending || _isLaunchingSupport,
      appBar: LogoAppBar(),
      body: SizedBox(
        height: context.height,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              if (isRequesting)
                _RequestingUserFormLoader(
                  isLoading: isRequesting,
                )
              else ...[
                _AppUserForm(
                  title: widget.title,
                  screenFormKey: screenFormKey,
                  isRequesting: isRequesting,
                  isSending: isSending,
                  message: widget.message,
                  informationalContent: widget.informationalContent,
                ),
                SizedBox(
                  height: 20.h,
                ),
                _UserFormButtons(
                  isSending: isSending,
                  onPressed: submitDisable ? null : onCheckForm,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _AppUserForm extends ConsumerWidget {
  const _AppUserForm({
    required this.screenFormKey,
    required this.title,
    this.isRequesting = false,
    this.isSending = false,
    this.message,
    this.informationalContent,
  });

  final GlobalKey<FormState> screenFormKey;
  final String title;
  final bool isRequesting;
  final bool isSending;
  final String? message;
  final Widget? informationalContent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formNotifier = ref.watch(formNotifierProvider.notifier);
    ref.watch(formNotifierProvider);
    final formFields = formNotifier.formFields;
    final formFieldError =
        ref.watch(formFieldErrorNotifierDeprecatedPodProvider);
    final userFormState = ref.watch(userFormStateNotifierProvider);
    return Form(
      key: screenFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 0,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 40.h,
                ),
                Text(
                  title,
                  style: context.primaryTextTheme?.displayMedium?.copyWith(
                    color: PiixColors.infoDefault,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (message.isNotNullEmpty) ...[
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    message!,
                    style: context.textTheme?.titleMedium
                        ?.copyWith(color: PiixColors.infoDefault),
                    textAlign: TextAlign.justify,
                  ),
                ],
                if (informationalContent != null) informationalContent!,
                ...formFields.map(
                  (formField) =>
                      FormFieldInputBuilderDeprecated(formField: formField),
                ),
                if (formFieldError == FormFieldErrorDeprecated.generic ||
                    userFormState == UserFormState.SENT_ERROR) ...[
                  FormGenericErroText(
                    text: formFieldError.errorMessage ??
                        PiixCopiesDeprecated.sorryPleaseTryAgain,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UserFormButtons extends ConsumerWidget {
  const _UserFormButtons({
    this.isSending = false,
    this.onPressed,
  });

  final bool isSending;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: PiixColors.primary,
      height: 60.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 1,
            child: TextAppButtonDeprecated(
              type: 'two',
              onPressed: () async {
                try {
                  ref.read(whatsappCommsProvider(context));
                } catch (_) {
                  final bannerNotifier = ref.read(bannerPodProvider.notifier);
                  bannerNotifier
                    ..setBanner(context,
                        description: PiixCopiesDeprecated.errorWhatsapp,
                        cause: BannerCause.error);
                }
              },
              icon: PiixIcons.whatsapp,
              text: PiixCopiesDeprecated.help,
              buttonStyle: const ButtonStyle(
                foregroundColor: MaterialStatePropertyAll<Color>(
                  PiixColors.space,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          Flexible(
            flex: 1,
            child: ElevatedAppButtonDeprecated(
              text: PiixCopiesDeprecated.continueText,
              onPressed: onPressed,
            ),
          ),
          SizedBox(
            width: 28.w,
          ),
        ],
      ),
    );
  }
}

class _RequestingUserFormLoader extends StatelessWidget {
  const _RequestingUserFormLoader({this.isLoading = false});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: ShimmerLoading(
        isLoading: isLoading,
        child: ShimmerWrap(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 20.h,
            ),
            width: context.width,
            height: 32.h,
          ),
        ),
      ),
    );
  }
}
