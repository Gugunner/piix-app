// ignore_for_file: avoid_annotating_with_dynamic

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_feature/auth_ui_screen_barrel_file.dart';
import 'package:piix_mobile/auth_feature/auth_utils_barrel_file.dart';
import 'package:piix_mobile/auth_feature/domain/provider/user_provider.dart';

import 'package:piix_mobile/form_feature/form_model_barrel_file.dart';
import 'package:piix_mobile/form_feature/form_provider_barrel.file.dart';
import 'package:piix_mobile/form_feature/form_utils_barrel_file.dart';
import 'package:piix_mobile/form_feature/ui/widgets/form_field_model_builder.dart'
    as fBuilder;
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/navigation_feature/navigation_utils_barrel_file.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/app_bar/logo_app_bar.dart';
import 'package:piix_mobile/widgets/app_card/app_card.dart';
import 'package:piix_mobile/widgets/banner/banner_barrel_file.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';
import 'package:piix_mobile/widgets/stepper/app_stepper_barrel_file.dart';
import 'package:piix_mobile/widgets/widgets_barrel_file.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final class PersonalInformationFormScreen extends AppLoadingWidget {
  static const routeName = '/personal_information_form_screen';

  const PersonalInformationFormScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PersonalInformationFormScreenState();
}

final class _PersonalInformationFormScreenState
    extends AppLoadingWidgetState<PersonalInformationFormScreen>
    with FormManager, ExitPrompt {
  ///The universal key which controls and validates the [Form].
  final _formKey = GlobalKey<FormState>();

  ///The request data is stored in this property.
  RequestFormModel? _requestForm;

  ///The data to send to the service is inside this property.
  ResponseFormModel? _responseForm;

  ///Stores the error if the api service fails.
  AppApiException? _apiException;

  List<FocusNode> _focusNodes = <FocusNode>[];

  FormType get _formType => FormType.INDIVIDUAL_REGISTRY;

  FormGroup get _formGroup => FormGroup.personal;

  bool get _allRequiredFilled => _responseForm!.answers.every(
        //Checks for both cases when required is true and answer is not null
        //If required is true the evalutation will be false and it will proceed to
        //check that answer is not null.
        //If required is false then the evaluation will be true.
        (a) => !a.required || a.answer != null,
      );

  ///Shows a specific error when an error prevents from
  ///verifying the verification code.
  void _launchErrorBanner() {
    final localeMessage = context.localeMessage;
    final description = requestError
        ? localeMessage.loadContentError
        : localeMessage.submitFormError;
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
                //Clears any error once the user acknowledges the error.
                if (_apiException != null) _apiException = null;
                if (requestError) {
                  isRequesting = true;
                  requestError = false;
                }
                if (submitError) {
                  isSubmitting = true;
                  submitError = false;
                }
              });
            }
          },
        )
        ..build();
    });
  }

  ///Checks for the specific form field with the corresponding [index]
  ///and if found it updates the [AnswerModel] of the [_responseForm]
  ///with the new [value].
  void _onHandleForm({
    required value,
    bool? required,
    int? index,
  }) {
    //For this form index must always be passed from each
    //form field.
    if (index == null || _requestForm == null) return;
    final formField =
        _requestForm!.formFields.firstWhere((f) => f.index == index);
    setState(() {
      _responseForm = updateForm(
        responseForm: _responseForm!,
        formField: formField,
        required: required ?? false,
        value: value,
      );
      _clearApiException();
    });
  }

  void _onSubmit() {
    if (equalDefaultValuesToAnswers(_requestForm!, _responseForm!)) {
      return _navigateToDocumentationFormScreen();
    }
    final currentState = _formKey.currentState;
    if (currentState == null) return;
    currentState.save();
    if (!currentState.validate()) return;
    _clearApiException();
    startSubmit();
  }

  void _clearApiException() {
    setState(() {
      _apiException = null;
      submitError = false;
    });
  }

  ///Updates the current user personal information.
  ///
  ///Obtains each formFieldId in a new list then retrieves the index
  ///of the specific personal information properties.
  void _updateUserPersonalInformation() {
    Future.microtask(() {
      //Gets the current user.
      final user = ref.read(userPodProvider);
      //If there is no user it cannot update the information.
      if (user == null) return;
      //Creates a new list of just the form field ids.
      final formFieldIds =
          _requestForm!.formFields.map((f) => f.formFieldId).toList();
      //Reads the list of answers.
      final answers = _responseForm!.answers;
      //Gets the index of where the form field id is in and then uses the index
      //to get the corresponding answer value.
      final name = answers[formFieldIds.indexOf('name')].answer;
      final middleName = answers[formFieldIds.indexOf('middleName')].answer;
      final firstLastName =
          answers[formFieldIds.indexOf('firstLastName')].answer;
      final secondLastName =
          answers[formFieldIds.indexOf('secondLastName')].answer;
      final birthdate = answers[formFieldIds.indexOf('birthdate')].answer;
      final email = answers[formFieldIds.indexOf('email_optional')].answer;
      final genderId = answers[formFieldIds.indexOf('genderId')].answer;
      //Using the genderId it checks each form field for the form field
      //with the 'genderId' form field id.
      final genderName = _requestForm!.formFields
          .firstWhereOrNull((f) => f.formFieldId == 'genderId')
          ?.mapOrNull(
        //Once found the form field should be of 'modelType' uniqueIdSelect
        //and searches for the specific ValueModel which id matches the
        // genderId found.
        uniqueIdSelect: (formField) {
          //Finally it returns the name for the specific ValueModel.
          return formField.values
              .firstWhereOrNull((v) => v.id == genderId)
              ?.name;
        },
      );

      ///Clones the current user with the updated personal
      ///information values.
      final updatedUser = user.copyWith(
        name: name,
        middleName: middleName,
        firstLastName: firstLastName,
        secondLastName: secondLastName,
        genderId: genderId,
        genderName: genderName,
        birthdate: birthdate is String
            ? DateTime.parse(birthdate)
            : birthdate as DateTime?,
        email: email,
      );
      //Stores the information in the user provider to make
      //it available through all the app.
      ref.read(userPodProvider.notifier).set(updatedUser);
    });
  }

  void _navigateToDocumentationFormScreen() {
    Future.microtask(
      () => NavigatorKeyState().slideToLeftRoute(
        page: const DocumentationFormScreen(),
        routeName: DocumentationFormScreen.routeName,
      ),
    );
  }

  @override
  Future<void> whileIsRequesting() async => ref
          .watch(requestFormPodProvider(
              formGroup: _formGroup, formType: _formType))
          .whenOrNull(data: (requestForm) {
        final userId = ref.read(userPodProvider)?.userId ?? '';
        Future.microtask(() => setState(() {
              _requestForm = requestForm;
              _responseForm = createResponseForm(
                requestForm: requestForm,
                userId: userId,
                formType: _formType,
              );
              _focusNodes = mapToFocusNodes(requestForm);
            }));

        endRequest();
      }, error: (error, stackTrace) {
        Future.microtask(() => setState(() {
              if (error is AppApiException) {
                _apiException = error;
              }
              requestError = true;
              _launchErrorBanner();
            }));

        endRequest();
      });

  @override
  Future<void> whileIsSubmitting() async {
    final user = ref.read(userPodProvider);
    //If there is no user it cannot update the information.
    if (user == null) return;
    //This prevents the form from submitting when the user
    //is starting the process of revision.
    ref
        .watch(submitFormPodProvider(
      formGroup: _formGroup,
      responseForm: _responseForm!,
      context: context,
    ))
        .whenOrNull(data: (_) {
      _updateUserPersonalInformation();
      endSubmit();
      _navigateToDocumentationFormScreen();
    }, error: (error, stackTrace) {
      Future.microtask(() => setState(() {
            if (error is AppApiException) {
              _apiException = error;
              final apiException = error;
              //If no api error is found then no error is shown.
              if (apiException.errorCodes == null) return null;
              if (apiException.errorCodes.isNullOrEmpty) return null;
              //Checks for the email error code which is handled by the field itself
              if (apiException.errorCodes!.contains(apiEmailAlreadyUsed))
                return;
            }
            submitError = true;
            _launchErrorBanner();
          }));
      endSubmit();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isRequesting) whileIsRequesting();
    if (isSubmitting) whileIsSubmitting();
    return WillPopScope(
      onWillPop: () async => await showExitAppPrompt(context) ?? false,
      child: IgnorePointer(
        ignoring: isRequesting || isSubmitting,
        child: Scaffold(
          appBar: _requestForm == null ? LogoAppBar() : null,
          body: SafeArea(
            child: Builder(builder: (context) {
              if (isRequesting && _requestForm == null)
                return _LoadingPersonalInformationFormScreen(
                  isLoading: isRequesting,
                );
              if (_requestForm != null)
                return _PersonalInformationForm(
                  formFields: _requestForm!.formFields,
                  focusNodes: _focusNodes,
                  onSubmit: _onSubmit,
                  onHandleForm: _onHandleForm,
                  apiException: _apiException,
                  formKey: _formKey,
                  allRequiredFilled: _allRequiredFilled,
                  isSubmitting: isSubmitting,
                );
              return const SizedBox();
            }),
          ),
        ),
      ),
    );
  }
}

final class _LoadingPersonalInformationFormScreen extends StatelessWidget {
  const _LoadingPersonalInformationFormScreen({this.isLoading = false});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: ShimmerLoading(
        isLoading: isLoading,
        child: Container(
          width: context.width,
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ShimmerWrap(
                  child: SizedBox(width: context.width, height: 24.h),
                ),
                SizedBox(height: 16.h),
                ShimmerWrap(
                  child: SizedBox(width: context.width, height: 33.h),
                ),
                SizedBox(height: 20.h),
                ...List.generate(
                  8,
                  (index) => Container(
                    margin: EdgeInsets.only(bottom: 15.h),
                    child: ShimmerWrap(
                      child: SizedBox(width: context.width, height: 60.h),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final class _PersonalInformationForm extends StatelessWidget {
  const _PersonalInformationForm({
    required this.formFields,
    required this.focusNodes,
    required this.onSubmit,
    required this.onHandleForm,
    this.allRequiredFilled = false,
    this.isSubmitting = false,
    this.formKey,
    this.apiException,
  });

  final List<FormFieldModel> formFields;

  final List<FocusNode> focusNodes;

  final VoidCallback onSubmit;

  final HandleFormValue? onHandleForm;

  final bool allRequiredFilled;

  final bool isSubmitting;

  final GlobalKey? formKey;

  final AppApiException? apiException;

  VerificationType get _verificationType => VerificationType.signUp;

  int get _currentStep => 3;

  @override
  Widget build(BuildContext context) {
    return AppFilledStepperScrollView(
      totalSteps: _verificationType.totalSteps,
      currentStep: _currentStep,
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            width: context.width,
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  context.localeMessage.basicInformation,
                  style: context.displaySmall?.copyWith(
                    color: PiixColors.infoDefault,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                Text(
                  context.localeMessage.enterTheInformationRequired,
                  style: context.accentTextTheme?.headlineLarge?.copyWith(
                    color: PiixColors.infoDefault,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                AppCard(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        ...formFields.map(
                          (formField) => Container(
                            margin: EdgeInsets.only(bottom: 15.h),
                            child: fBuilder.FormFieldModelBuilder(
                              formField: formField,
                              totalFields:
                                  formFields.where((f) => !f.isHidden).length,
                              onHandleForm: onHandleForm,
                              focusNode: focusNodes[formField.index],
                              apiException: apiException,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 140.w,
                          height: 32.h,
                          child: AppFilledSizedButton(
                            text: context.localeMessage.continued.toUpperCase(),
                            onPressed: allRequiredFilled ? onSubmit : null,
                            loading: isSubmitting,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
