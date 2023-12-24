import 'package:dio/dio.dart';
import 'package:piix_mobile/auth_feature/domain/provider/user_provider.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_input_provider.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/utils/auth_method_enum.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/domain/model/auth_user_form_model.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/domain/model/basic_form_model.dart';
import 'package:piix_mobile/form_feature/domain/model/form_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_answer_provider_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/utils/api/app_api_exception.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/user_form_feature/data/user_form_service_repository.dart';
import 'package:piix_mobile/utils/app_copies_barrel_file.dart';
import 'package:piix_mobile/utils/extensions/list_extend.dart';
import 'package:piix_mobile/utils/log_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_form_provider_deprecated.g.dart';

@Deprecated('Will be removed in 4.0')
///All the values that are used to detect
///what happens when a form is sent
enum UserFormState {
  IDLE,
  //TODO: Add additional errors
  EMAIL_ALREADY_USED(responseErrorText: AuthUserCopies.alreadyUsedEmail),
  PHONE_NUMBER_ALREADY_USED(responseErrorText: AuthUserCopies.alreadyUsedPhone),
  UNIQUE_ID_ALREADY_USED(responseErrorText: AuthUserCopies.uniqueIdDuplicated),
  DOCUMENT_DOES_NOT_EXISTS(responseErrorText: AuthUserCopies.documentNotFound),
  SENT_ERROR,
  ;
  @Deprecated('Will be removed in 4.0')
  const UserFormState({this.responseErrorText});
  @Deprecated('Will be removed in 4.0')
  final String? responseErrorText;
  @Deprecated('Will be removed in 4.0')
  UserFormState fromErrorCodes(List<String> errorCodes) => UserFormState.values
      .firstWhere((value) => errorCodes.contains(value.name),
          orElse: () => UserFormState.IDLE);
}

@Deprecated('Will be removed in 4.0')
///A Riverpod Notifier class that handles the state of the
///[UserFormState] value
@Riverpod(keepAlive: true)
class UserFormStateNotifier extends _$UserFormStateNotifier {
  @override
  UserFormState build() => UserFormState.IDLE;

  @Deprecated('Will be removed in 4.0')
  void setUserFormState(UserFormState value) {
    state = value;
  }
}

@Deprecated('Will be removed in 4.0')
///A Riverpod AsyncNotifier class that exclusively works returning
///an AsyncValue result and depending on the parameter [send] it either
///retrieves or sends a form
@riverpod
class UserFormServiceNotifier extends _$UserFormServiceNotifier
    with LogApiCall, LogAppCall {
  ///When building the provider if [send] is false
  ///the [formId] must be passed to retrieve a specific
  ///form, if [send] is false, the provider will send a form
  ///and the [formId] will be retrieved from the [form]
  @override
  FutureOr<void> build({bool send = false, String? formId}) async {
    if (send) return sendUserForm();
    if (formId == null) return;
    return _getUserFormBy(formId);
  }

  @Deprecated('Will be removed in 4.0')
  ///Retrieves a form by its formId
  Future<void> _getUserFormBy(String formId) async {
    final repository = ref.read(userFormServiceRepositoryProvider.notifier);
    try {
      final userId = ref.read(userPodProvider)?.userId;
      final mainUserInfoFormId = formId;
      if (userId == null || mainUserInfoFormId.isEmpty) {
        throw Exception('UserId or FormId is null');
      }
      final formModel = AuthUserFormModel(
        userId: userId,
        mainUserInfoFormId: mainUserInfoFormId,
      );
      final form = await repository.getUserForm(formModel);
      ref.read(formNotifierProvider.notifier).setForm(form);
      ref
          .read(userFormStateNotifierProvider.notifier)
          .setUserFormState(UserFormState.IDLE);
      return;
    } catch (error) {
      if (error is! DioError) {
        logError(error, className: 'UserFormService');
        rethrow;
      }
      logDioException(error, className: 'UserFormService');
      rethrow;
    }
  }

  @Deprecated('Will be removed in 4.0')
  ///Sends a [form] which is read from the [formNotifierProvider].
  Future<void> sendUserForm() async {
    final repository = ref.read(userFormServiceRepositoryProvider.notifier);
    final formNotifier = ref.read(formNotifierProvider.notifier);
    try {
      final form = ref.read(formNotifierProvider);
      final formFields = formNotifier.formFields;

      ///Converts the formFields into answers
      final answers = ref
          .read(formAnswerNotifierProvider.notifier)
          .formResponsesToFormAnswers(formFields);

      ///Obtains legal answers
      final legalAnswers =
          await ref.read(formLegalAnswerNotifierProvider.notifier).answers();

      ///Concatenates all answers together
      answers.addAll(legalAnswers);
      final userId = ref.read(userPodProvider)?.userId ?? '';
      final formId = form?.formId ?? '';

      ///Creates a model that wraps all answers when sending a form
      final answerModel = BasicFormAnswerModel(
        userId: userId,
        mainUserInfoFormId: formId,
        answers: answers,
      );
      await repository.sendUserForm(answerModel);
    } catch (error) {
      final userFormStateNotifier =
          ref.read(userFormStateNotifierProvider.notifier);
      if (error is! DioError) {
        logError(error, className: 'UserFormService');
        rethrow;
      }
      logDioException(error, className: 'UserFormService');
      final piixApiExceptions = AppApiLogException.fromDioException(error);
      final piixApiError = AppApiException.fromJson(piixApiExceptions.data!);
      if (piixApiError.errorCodes.isNotNullOrEmpty) {
        userFormStateNotifier.setUserFormState(UserFormState.SENT_ERROR);
        rethrow;
      }
      //Check for any errors that need handling in the form
      final errorFormState =
          userFormStateNotifier.state.fromErrorCodes(piixApiError.errorCodes!);
      userFormStateNotifier.setUserFormState(errorFormState);
      final responseErrorText = errorFormState.responseErrorText ?? '';
      //If an errorFormState can be set, then it checks for specific
      //form fields where a specific error text must be set depending on
      //the errorFormState
      switch (errorFormState) {
        case UserFormState.EMAIL_ALREADY_USED:
          formNotifier.addResponseErrorTextToField(
            'email',
            text: responseErrorText,
          );
          break;
        case UserFormState.PHONE_NUMBER_ALREADY_USED:
          formNotifier.addResponseErrorTextToField(
            'phoneNumber',
            text: responseErrorText,
          );
          formNotifier.addResponseErrorTextToField(
            'protectedPhoneNumber',
            text: responseErrorText,
          );
          break;
        case UserFormState.UNIQUE_ID_ALREADY_USED:
          formNotifier.addResponseErrorTextToField(
            'uniqueId',
            text: responseErrorText,
          );
          break;
        case UserFormState.DOCUMENT_DOES_NOT_EXISTS:
          formNotifier.addResponseErrorTextToField(
            'user_validation_documents',
            text: responseErrorText,
          );
          break;
        default:
      }
      rethrow;
    }
  }
}

@Deprecated('Will be removed in 4.0')
///A Riverpod Notifier class that handles extra
///logic needed when preparing to send the
///[PersonalInformationForm]
@riverpod
class PersonalInformationFormNotifier
    extends _$PersonalInformationFormNotifier {
  @override
  void build() {}

  @Deprecated('Will be removed in 4.0')
  bool _hasSameCredential(
    String fieldCredential,
    String? userCredential,
  ) =>
      userCredential != null &&
      fieldCredential.toLowerCase().contains(userCredential);

  @Deprecated('Will be removed in 4.0')
  void _updateCredential(String credential, AuthMethod authMethod) {
    ref.read(usernameCredentialProvider.notifier).set(credential);
    ref.read(authMethodStateProvider.notifier).setAuthMethod(authMethod);
  }

  @Deprecated('Will be removed in 4.0')
  bool? getShouldVerifyCredential() {
    final form = ref.read(formNotifierProvider);
    //If there is no form an error occurs and exits
    if (form == null) {
      ref
          .read(userFormStateNotifierProvider.notifier)
          .setUserFormState(UserFormState.SENT_ERROR);
      return null;
    }
    final phoneNumberFormField = form.formFieldBy('phoneNumber');
    final phoneNumber = form.formFieldResponseBy('phoneNumber');
    final email = form.formFieldResponseBy('email');
    //If neither formField credential is found there
    //is an error and it exits
    if (phoneNumber == null || email == null) {
      ref
          .read(userFormStateNotifierProvider.notifier)
          .setUserFormState(UserFormState.SENT_ERROR);
      return null;
    }
    final user = ref.read(userPodProvider);
    var sameCredential = false;
    //Either the email of phoneNumber formField are editable a simple
    //conditional checks which one.
    final isPhoneNumberEditable = phoneNumberFormField?.isEditable ?? false;
    //Updates the credential in the usernameCredentialProvider state
    //to be read when sending the credential and checking the authMethod
    if (isPhoneNumberEditable) {
      sameCredential = _hasSameCredential(phoneNumber, user?.phoneNumber);
      _updateCredential(phoneNumber, AuthMethod.phoneUpdate);
    } else {
      sameCredential = _hasSameCredential(email, user?.email);
      _updateCredential(email, AuthMethod.emailUpdate);
    }
    final isVerified = isPhoneNumberEditable
        ? user?.phoneVerified ?? false
        : user?.emailVerified ?? false;
    //If it is the same credential as the one the user has
    //and it has already been verified returns false as the
    //credential does not need to be verified
    if (sameCredential && isVerified) return false;
    return true;
  }
}

@Deprecated('Will be removed in 4.0')
///A Riverpod Notifier class that handles extra
///logic needed when preparing to send the
///[DocumentationForm]
@riverpod
class DocumentationFormNotifier extends _$DocumentationFormNotifier {
  @override
  FutureOr<void> build() => {};

  @Deprecated('Will be removed in 4.0')
  ///Sets the imageUrls in the [formFields] of the [form] and
  ///sets the new form with the replaced image urls values
  void setFormImageUrls() {
    final formNotifier = ref.read(formNotifierProvider.notifier);
    final formFields = formNotifier.formFields;
    final newFormFields =
        ref.read(imageUrlNotifierProvider.notifier).setImagesUrls(formFields);
    formNotifier
        .setForm(formNotifier.form?.copyWith(formFields: newFormFields));
  }
}
