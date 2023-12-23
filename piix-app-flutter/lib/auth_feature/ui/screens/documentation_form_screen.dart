import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_feature/auth_provider_barrel_file.dart';
import 'package:piix_mobile/auth_feature/auth_ui_screen_barrel_file.dart';
import 'package:piix_mobile/auth_feature/auth_utils_barrel_file.dart';
import 'package:piix_mobile/file_feature/file_model_barrel_file.dart';
import 'package:piix_mobile/file_feature/file_provider_barrel_file.dart';
import 'package:piix_mobile/form_feature/form_model_barrel_file.dart';
import 'package:piix_mobile/form_feature/form_provider_barrel.file.dart';
import 'package:piix_mobile/form_feature/form_ui_barrel_file.dart';
import 'package:piix_mobile/form_feature/form_utils_barrel_file.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/navigation_feature/navigation_utils_barrel_file.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/app_bar/logo_app_bar.dart';
import 'package:piix_mobile/widgets/banner/banner_barrel_file.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';
import 'package:piix_mobile/widgets/stepper/app_stepper_barrel_file.dart';
import 'package:piix_mobile/widgets/widgets_barrel_file.dart';

import '../../../file_feature/file_utils_barrel_file.dart';

final class DocumentationFormScreen extends AppLoadingWidget {
  static const routeName = '/documentation_form_screen';

  const DocumentationFormScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DocumentationFormScreenState();
}

final class _DocumentationFormScreenState
    extends AppLoadingWidgetState<DocumentationFormScreen>
    with FormManager, S3FormManager, FileManager, ExitPrompt {
  ///The universal key which controls and validates the [Form].
  final _formKey = GlobalKey<FormState>();

  ///The request data is stored in this property.
  RequestFormModel? _requestForm;

  ///The data to send to the service is inside this property.
  ResponseFormModel? _responseForm;

  ///Stores the specific files that will be uploaded to S3 when [_onSubmit]
  ///is executed.
  List<S3FileModel> _s3Files = [];

  ///Stores the error if the api service fails.
  AppApiException? _apiException;

  FormType get _formType => FormType.INDIVIDUAL_REGISTRY;

  FormGroup get _formGroup => FormGroup.documentation;

  bool get _allRequiredFilled => _responseForm!.answers.every(
        //Checks for both cases when required is true and answer is not null
        //If required is true the evalutation will be false and it will proceed
        // to check that answer is not null.
        //If required is false then the evaluation will be true.
        (a) => !a.required || a.answer != null,
      );

  ///Checks if any of the answers in this form which contains images
  ///is not null meaning it has a saved picture inside its answer.
  bool get _hasSavedPictures =>
      _responseForm?.answers.any((answer) => answer.maybeMap(
            (value) => false,
            s3: (value) => value.answer != null,
            orElse: () => false,
          )) ??
      false;

  ///Shows a specific error when an error prevents from
  ///verifying the verification code.
  void _launchErrorBanner(String description) {
    final localeMessage = context.localeMessage;
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

  void _onSubmit() async {
    //No data is expected but this is considered a succesful
    //submission and launches the next navigation in the steps.
    if (equalDefaultValuesToAnswers(_requestForm!, _responseForm!)) {
     return _navigateToMembershipConfirmationScreen();
    }
    final currentState = _formKey.currentState;
    //Checks if the current state of the form is available and if
    //not it exits without submitting.
    if (currentState == null) return;
    //Executes in each [FormField] inside the [Form] the
    //onSave callback if not null.
    currentState.save();
    //Checks each validator method in each [FormField] inside
    //the [Form] and if any returns an error text then it exits
    //without submitting.
    if (!currentState.validate()) return;
    _clearApiException();
    final userId = ref.read(userPodProvider)?.userId ?? '';
    //Creates a new [ResponseFormModel] where the answers that
    //will upload s3 files are processed.
    final responseForm = await prepareS3FileModelInAnswer(
      responseForm: _responseForm!,
      userId: userId,
    );
    //Gets all [S3FileModel]s from each [AnswerModel] that is not null and
    //is has a valid s3 constructor.
    final s3Files = responseForm.answers
        .map((answer) =>
            answer.mapOrNull((value) => null, s3: (value) => value.s3File))
        .whereNotNull()
        .toList();
    setState(() {
      _responseForm = responseForm;
      _s3Files = s3Files;
    });
    startSubmit();
  }

  void _clearApiException() {
    setState(() {
      _apiException = null;
      submitError = false;
    });
  }

  void _navigateToMembershipConfirmationScreen() {
    final pictures = _responseForm!.answers
        .map((answer) =>
            answer.mapOrNull((value) => null, s3: (value) => value.fileContent))
        .whereNotNull()
        .toList();
    Future.microtask(
      () => NavigatorKeyState().slideToLeftRoute(
        page: MembershipConfirmationScreen(
          pictures: pictures,
        ),
        routeName: MembershipConfirmationScreen.routeName,
      ),
    );
  }

  Future<bool> _onWillPop() async {
    //If the form already has pictures stored in the [answers]
    //then it prompts the user to confirm the pop action.
    if (_hasSavedPictures) {
      return await showExitProgressPrompt(context) ?? false;
    }
    return true;
  }

  ///Stores the [AppApiException] if [error] is that
  ///type and launches a specific general error banner
  ///when requesting the form fails.
  void _onErrorRequestingForm(Object? error) {
    Future.microtask(() => setState(() {
          if (error is AppApiException) {
            _apiException = error;
          }
          requestError = true;
          final description = context.localeMessage.loadContentError;
          _launchErrorBanner(description);
        }));
    return endRequest();
  }

  void _onErrorUploadingImages(Object? error) {
    Future.microtask(() => setState(() {
          if (error is AppApiException) {
            _apiException = error;
          }
          submitError = true;
          final description = context.localeMessage.uploadCapturedImagesError;
          _launchErrorBanner(description);
        }));
    return endSubmit();
  }

  void _onErrorSubmittingForm(Object? error) {
    Future.microtask(() => setState(() {
          if (error is AppApiException) {
            _apiException = error;
            final apiException = error;
            //If no api error is found then no error is shown.
            if (apiException.errorCodes == null) return null;
            if (apiException.errorCodes.isNullOrEmpty) return null;
          }
          submitError = true;
          final description = context.localeMessage.submitFormError;
          _launchErrorBanner(description);
        }));
    endSubmit();
  }

  @override
  Future<void> whileIsRequesting() async {
    //Gets the [AsyncValue] of the executing riverpod provider to
    //request the form.
    //Note that since it is listening for any change no matter how many
    //times the method is called it will not execute again unless,
    //the reference to the arguments change.
    final asyncValue = ref.watch(
        requestFormPodProvider(formGroup: _formGroup, formType: _formType));
    //If the asyncValue type is loading then it exits the request.
    if (asyncValue is AsyncLoading) return;
    //If the asyncValue type is an error then it obtains the
    //error object from it and launches the [_onErrorRequestingForm].
    if (asyncValue is AsyncError) {
      final error = asyncValue.error;
      return _onErrorRequestingForm(error);
    }
    //Since it is no longer loading or is not an error then
    //it is safe to obtain the value and declare it as not null.
    //The value contains a [RequestFormModel].
    var requestForm = asyncValue.value!;
    final userId = ref.read(userPodProvider)?.userId ?? '';
    //Executes an iterable action to retrieve all the [AsyncValues]
    //for each form field that may contain an s3UrlPath.
    final asyncImageValues =
        getAsyncImageValues(requestForm.formFields, userId: userId, ref: ref);
    //Iterates over each [AsyncImage] which is a tupple with two value,
    //one the first one $1 is the [AsyncValue] of the corresponding call
    //to the [SubmitS3Pod] Riverpod provider, and the second one $2 is the
    //index of the form field for easier referencing when updating values in
    //the [requestForm].
    for (final asyncImage in asyncImageValues) {
      final asyncImageValue = asyncImage.$1;
      final index = asyncImage.$2;
      //If the image file is still loading then it exits the method.
      //Note that since it is listening for any change no matter how many
      //times the method is called it will not execute again unless,
      //the reference to the arguments change.
      if (asyncImageValue is AsyncLoading) return;
      //If the image file has an error then it continues to the next one
      //or finishes the for loop.
      if (asyncImageValue is AsyncError) {
        continue;
      }
      //If it is not loading or an error then the asyncImageValue has
      //either no data in value or a [FileModel] value.
      final formFields = <FormFieldModel>[];
      for (final formField in requestForm.formFields) {
        //This evaluation of different index prevents checking form fields
        //that are not the same one by adding the form field without any
        //modification.
        if (formField.index != index) {
          formFields.add(formField);
          continue;
        }
        final fileContent = asyncImageValue.value;
        //If file has no value then it can safely add the same form field
        //without modifications.
        if (fileContent == null) {
          formFields.add(formField);
          continue;
        }
        //It only adds the file value to the document or selfie
        //form fields since this models have the fileModel optional
        //property.
        final newFormField = formField.maybeMap<FormFieldModel>(
          document: (value) => value.copyWith(
            fileContent: fileContent,
          ),
          selfie: (value) => value.copyWith(
            fileContent: fileContent,
          ),
          orElse: () => formField,
        );
        formFields.add(newFormField);
      }
      //To avoid processing each form field when modifying the form fields
      //property a single write operation is executed.
      requestForm = requestForm.copyWith(formFields: formFields);
    }
    //Once finished it will update all values in the proper state.
    Future.microtask(() => setState(() {
          _requestForm = requestForm;
          _responseForm = createResponseForm(
            requestForm: requestForm,
            userId: userId,
            formType: _formType,
          );
        }));
    //Stops executing this method again.
    endRequest();
  }

  @override
  Future<void> whileIsSubmitting() async {
    //Gets the [AsyncValue] of the executing riverpod provider
    //to upload the S3Files.
    //Note that since it is listening for any change no matter how many
    //times the method is called it will not execute again unless,
    //the reference to the arguments change.
    final asyncValue = ref.watch(submitS3FilePodProvider(_s3Files));
    //If the asyncValue type is loading then it exits the submit.
    if (asyncValue is AsyncLoading) return;
    //If the asyncValue type is an error then it obtains the
    //error object from it and launches the [_onErrorSubmittingForm].
    if (asyncValue is AsyncError) {
      final error = asyncValue.error;
      return _onErrorUploadingImages(error);
    }
    //If the S3Files were successfully uploaded then it will
    //try to submit the form.
    //Note that in this case the [AsyncValue] is handled inside
    //the callbacks methods instead of outside.
    ref
        .watch(submitFormPodProvider(
            formGroup: _formGroup, responseForm: _responseForm!))
        .whenOrNull(
      //Successful submission.
      data: (_) {
        endSubmit();
        _navigateToMembershipConfirmationScreen();
      },
      //Failure of submission.
      error: (error, stackTrace) {
        //If an error occurs
        _onErrorSubmittingForm(error);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isRequesting) whileIsRequesting();
    if (isSubmitting) whileIsSubmitting();
    return WillPopScope(
      onWillPop: _onWillPop,
      child: IgnorePointer(
        ignoring: isRequesting || isSubmitting,
        child: Scaffold(
          appBar: _requestForm == null ? LogoAppBar() : null,
          body: SafeArea(
            child: Builder(builder: (context) {
              if (isRequesting && _requestForm == null) {
                return _LoadingDocumentationFormScreen(isLoading: isRequesting);
              }
              if (_requestForm != null) {
                return _DocumentationForm(
                  formFields: _requestForm!.formFields,
                  onSubmit: _onSubmit,
                  onHandleForm: _onHandleForm,
                  apiException: _apiException,
                  formKey: _formKey,
                  allRequiredFilled: _allRequiredFilled,
                  isSubmitting: isSubmitting,
                );
              }
              return const SizedBox();
            }),
          ),
        ),
      ),
    );
  }
}

class _LoadingDocumentationFormScreen extends StatelessWidget {
  const _LoadingDocumentationFormScreen({this.isLoading = false});

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
                  child: SizedBox(
                    width: context.width,
                    height: 24.h,
                  ),
                ),
                SizedBox(height: 16.h),
                ShimmerWrap(
                  child: SizedBox(width: context.width, height: 33.h),
                ),
                ...List.generate(
                  2,
                  (index) => Container(
                    margin: EdgeInsets.only(bottom: 8.h),
                    child: ShimmerWrap(
                      child: SizedBox(
                        width: context.width,
                        height: 202.h,
                      ),
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

final class _DocumentationForm extends StatelessWidget {
  const _DocumentationForm({
    required this.formFields,
    required this.onSubmit,
    required this.onHandleForm,
    this.allRequiredFilled = false,
    this.isSubmitting = false,
    this.formKey,
    this.apiException,
  });

  final List<FormFieldModel> formFields;

  final VoidCallback onSubmit;

  final HandleFormValue? onHandleForm;

  final bool allRequiredFilled;

  final bool isSubmitting;

  final GlobalKey<FormState>? formKey;

  final AppApiException? apiException;

  VerificationType get _verificationType => VerificationType.signUp;

  int get _currentStep => 4;

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
                  context.localeMessage.uploadPhotographs,
                  style: context.displaySmall?.copyWith(
                    color: PiixColors.infoDefault,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                Text(
                  context.localeMessage.makeSureToUploadRequestedImages,
                  style: context.accentTextTheme?.headlineLarge?.copyWith(
                    color: PiixColors.infoDefault,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      ...formFields.map(
                        (formField) => Container(
                          margin: EdgeInsets.only(bottom: 8.h),
                          child: FormFieldModelBuilder(
                            formField: formField,
                            totalFields:
                                formFields.where((f) => !f.isHidden).length,
                            onHandleForm: onHandleForm,
                            apiException: apiException,
                          ),
                        ),
                      ),
                      SizedBox(height: 32.h),
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
