import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_feature/domain/provider/user_provider.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/model/form_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_answer_provider_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/header_description_rich_text_widget.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_events_constants.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_parameter_constants.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_values.dart';
import 'package:piix_mobile/membership_verification_feature/domain/provider/membership_verification_provider.dart';
import 'package:piix_mobile/user_form_feature/domain/user_form_provider_deprecated.dart';
import 'package:piix_mobile/utils/app_copies_barrel_file.dart';
import 'package:piix_mobile/widgets/screen/app_form_screen/app_user_form_screen.dart';

@Deprecated('The documentation form is no longer used')
class UserDocumentationFormScreenDeprecated extends AppUserFormScreen {
  static const routeName = '/user_documentation_form_screen';
  UserDocumentationFormScreenDeprecated({super.key})
      : super(
          title: AuthUserFormCopies.completeYourDocumentation,
          message: AuthUserFormCopies.nowFillTheInformation,
          informationalContent: _UserDocumentationFormInformationalContent(),
        );

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserDocumentationFormScreenState();
}

class _UserDocumentationFormScreenState extends AppUserFormScreenState {
  @override
  void onCheckForm() {
    //If there is no key related to form do nothing
    if (screenFormKey.currentState == null) return;
    //If any field has an errorText set a generic error
    //that is shown at the end of the form
    if (!(screenFormKey.currentState!.validate())) {
      ref
          .read(formFieldErrorNotifierDeprecatedPodProvider.notifier)
          .setFormFieldError(FormFieldErrorDeprecated.generic);
      return;
    }
    //Unfocus any form field selected by the user when submitting the form
    onUnfocus();

    ///Sets the images paths to prepare them for uploading
    ref.read(documentationFormNotifierProvider.notifier).setFormImageUrls();
    setState(() {
      isSending = true;
    });
  }

  ///Retrieves the communityTypeId formField
  ///and updates the [CommunityType] based on the
  ///selected value of the formField
  void onChangedCommunityType() {
    final form = ref.read(formNotifierProvider);
    if (form == null) return;
    final formField = form.formFieldBy('communityTypeId');
    if (formField == null) return;
    ref
        .read(communityDeprecatedPodProvider.notifier)
        .updateCommunityType(formField, context);
  }

  @override
  Future<void> whileIsRequesting() async => ref
          .watch(
              userFormServiceNotifierProvider(formId: 'userDocumentationForm'))
          .whenOrNull(data: (_) {
        endRequest();
        Future.microtask(() {
          final form = ref.read(formNotifierProvider);
          var communityTypeFormField = form?.formFieldBy('communityTypeId');
          if (communityTypeFormField == null) return;

          ///As soon as the information is retrieved the communityTypeFormField
          ///is assigned a listener method
          communityTypeFormField =
              communityTypeFormField.setOnchanged(onChangedCommunityType);
          ref
              .read(formNotifierProvider.notifier)
              .replaceFormField(communityTypeFormField);
        });
      }, error: (_, __) {
        endRequest();
      });

  @override
  void whileIsSending() async {
    final formFields = ref.read(formNotifierProvider.notifier).formFields;
    //To concatenate multiple providers each AsyncValue is stored
    final imageAnswerAsyncValue =
        ref.watch(s3ImageAnswerNotifierProvider(formFields));
    //While it is loading it just exits the method
    //without ending the loop
    if (imageAnswerAsyncValue is AsyncLoading) return;
    //If the response of the AsyncNotifier [imageAnswerAsyncValue]
    //throws an error the execution ends the loop and exits
    if (imageAnswerAsyncValue is AsyncError) {
      Future.microtask(() {
        ref
            .read(userFormStateNotifierProvider.notifier)
            .setUserFormState(UserFormState.SENT_ERROR);
        setState(() {
          isSending = false;
        });
      });
      return;
    }

    ///Finally calls the AsyncNotifier to request to send the user
    ///documentation form
    ref.watch(userFormServiceNotifierProvider(send: true)).whenOrNull(
        data: (_) {
      Future.microtask(() {
        ///Updates locally the information submitted in the form if it
        ///is succesfully sent
        ref.read(userPodProvider.notifier).setUpDocumentation();
        logEvent(
          eventName: PiixAnalyticsEvents.submitAuthForm,
          eventParameters: {
            PiixAnalyticsParameters.formName:
                PiixAnalyticsValues.documentationForm,
          },
        );
        setState(() {
          isSending = false;
        });
        NavigatorKeyState().getNavigator()?.pop();
      });
    }, error: (_, __) {
      Future.microtask(() {
        ref
            .read(userFormStateNotifierProvider.notifier)
            .setUserFormState(UserFormState.SENT_ERROR);
        setState(() {
          isSending = false;
        });
      });
    });
  }
}

class _UserDocumentationFormInformationalContent extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final community = ref.watch(communityDeprecatedPodProvider);
    final showCommunityInstructions = community.showCommunityInstructions;
    final loadImageInstructions = community.loadImageInstructions ?? '';
    final communityNameInstructions = community.communityNameInstructions ?? '';
    final idNumberInstructions = community.idNumberInstructions ?? '';
    if (!showCommunityInstructions) return const SizedBox();
    return Container(
      padding: EdgeInsets.all(8.w),
      margin: EdgeInsets.only(top: 16.h),
      width: context.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: PiixColors.successMain,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AuthUserFormCopies.fillInstructions,
            style: context.primaryTextTheme?.titleMedium?.copyWith(
              color: PiixColors.infoDefault,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          HeaderDescriptionRichTextWidget(
            header: AuthUserFormCopies.loadingImages,
            text: loadImageInstructions,
          ),
          SizedBox(
            height: 8.h,
          ),
          HeaderDescriptionRichTextWidget(
            header: AuthUserFormCopies.communityName,
            text: communityNameInstructions,
          ),
          SizedBox(
            height: 8.h,
          ),
          HeaderDescriptionRichTextWidget(
            header: AuthUserFormCopies.idNumber,
            text: idNumberInstructions,
          ),
        ],
      ),
    );
  }
}
