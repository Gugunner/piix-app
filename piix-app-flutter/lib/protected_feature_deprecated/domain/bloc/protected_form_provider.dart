import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/utils/date_util.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/form_feature/domain/model/form_model_deprecated.dart';
import 'package:piix_mobile/protected_feature_deprecated/data/repository/protected_form_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/model/protected_model.dart';

final protectedFormProvider = ChangeNotifierProvider<ProtectedFormNotifier>(
    (ref) => ProtectedFormNotifier(ref));

class ProtectedFormNotifier extends ChangeNotifier {
  ProtectedFormNotifier(this.ref);

  final ChangeNotifierProviderRef<ProtectedFormNotifier> ref;

  ///Controls if the api requests call the real api or instead read from a
  ///fake response.
  bool _appTest = false;
  bool get appTest => _appTest;
  void setAppTest(bool value) {
    _appTest = value;
  }

  ProtectedFormState _protectedFormState = ProtectedFormState.idle;
  ProtectedFormState get protectedFormState => _protectedFormState;
  void setProtectedFormState(ProtectedFormState state) {
    _protectedFormState = state;
    notifyListeners();
  }

  ProtectedFormRepository get _protectedFormRepository =>
      getIt<ProtectedFormRepository>();

  ///Injects [FormFieldBLoC] into this
  FormNotifier get formNotifier => ref.read(formNotifierProvider.notifier);

  ///Retrieves the [FormModelOld] inside [formNotifier]
  FormModelOld? get protectedRegisterForm => formNotifier.state;

  void setProtectedRegisterForm(FormModelOld? piixFormModel) {
    formNotifier.setForm(piixFormModel);
  }

  void setRegisterFormFields(List<FormFieldModelOld> formFields) {
    if (protectedRegisterForm == null) return;
    setProtectedRegisterForm(
      protectedRegisterForm?.copyWith(
        formFields: formFields,
      ),
    );
    notifyListeners();
  }

  ///Returns either the [formFields] list of [registerForm] if the
  ///form is not null otherwise returns an empty list.
  List<FormFieldModelOld> get registerFormFields {
    if (protectedRegisterForm == null) return [];
    return protectedRegisterForm!.formFields;
  }

  Future<void> getProtectedRegisterForm({
    required String membershipId,
    bool useFirebase = true,
  }) async {
    try {
      setProtectedFormState(ProtectedFormState.retrieving);
      final data =
          await _protectedFormRepository.getProtectedRegisterFormRequested(
        membershipId: membershipId,
        test: appTest,
        useFirebase: useFirebase,
      );
      if (data is ProtectedFormState) {
        setProtectedFormState(data);
        return;
      }
      final protectedRegisterForm = FormModelOld.fromJson(data);
      setProtectedRegisterForm(protectedRegisterForm);
      final protectedFormState = data['state'];
      setProtectedFormState(protectedFormState);
    } catch (e) {
      if (useFirebase) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Error in getProtectedRegisterForm',
          message: e.toString(),
          isLoggable: isApiException(e),
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: e,
          level: Level.error,
          sendToCrashlytics: true,
        );
      }
      setProtectedFormState(ProtectedFormState.retrievedError);
    }
  }

  ProtectedModel getProtectedInfo(WidgetRef ref) {
    final form = ref.read(formNotifierProvider);
    final name = form?.formFieldResponseBy('name');
    final firstLastName = form?.formFieldResponseBy('firstLastName');
    final email = form?.formFieldResponseBy('email');
    final phoneNumber = form?.formFieldResponseBy('protectedPhoneNumber');
    final birthdate = form?.formFieldResponseBy('birthdate');
    final planId = form?.formFieldResponseBy('planId');
    final planName = form?.formFieldBy('planId')?.stringResponse;
    final genderId = form?.formFieldResponseBy('genderId');
    final genderName = form?.formFieldBy('genderId')?.stringResponse;
    final countryId = form?.formFieldResponseBy('countryId');
    final countryName = form?.formFieldBy('countryId')?.stringResponse;
    final stateId = form?.formFieldResponseBy('stateId');
    final stateName = form?.formFieldBy('stateId')?.stringResponse;
    final zipCode = form?.formFieldResponseBy('zipCode');
    final uniqueId = form?.formFieldResponseBy('protectedUniqueId');

    final protectedModel = ProtectedModel(
      userId: '',
      uniqueId: uniqueId ?? '',
      name: name,
      firstLastName: firstLastName,
      email: email,
      phoneNumber: phoneNumber,
      birthdate: toDateTime(birthdate),
      planId: planId,
      planName: planName,
      genderId: genderId,
      genderName: genderName,
      countryId: countryId,
      countryName: countryName,
      stateId: stateId,
      stateName: stateName,
      zipCode: zipCode,
    );
    return protectedModel;
  }

  void clearProvider() {
    _protectedFormState = ProtectedFormState.idle;
    formNotifier.setForm(null);
    notifyListeners();
  }
}
