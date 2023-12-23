import 'package:piix_mobile/form_feature/data/repository/form_repository.dart';
import 'package:piix_mobile/form_feature/form_model_barrel_file.dart';
import 'package:piix_mobile/form_feature/utils/form_group_enum.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'request_form_provider.g.dart';


@riverpod
class RequestFormPod extends _$RequestFormPod {
  String get _className => 'RequestFormPod';

  @override
  Future<RequestFormModel> build({
    required FormGroup formGroup,
    required FormType formType,
  }) {
    switch (formGroup) {
      case FormGroup.personal:
        return _getPersonalInformationForm(formType);
      case FormGroup.documentation:
        return _getDocumentationForm(formType);
    }
  }

  Future<RequestFormModel> _getPersonalInformationForm(
      FormType formType) async {
    try {
      return await ref
          .read(formRepositoryPod)
          .getPersonalInformationForm(formType);
    } catch (error) {
      AppApiExceptionHandler.handleError(_className, error);
      rethrow;
    }
  }

  Future<RequestFormModel> _getDocumentationForm(FormType formType) async {
    try {
      return await ref.read(formRepositoryPod).getDocumentationForm(formType);
    } catch (error) {
      AppApiExceptionHandler.handleError(_className, error);
      rethrow;
    }
  }
}
