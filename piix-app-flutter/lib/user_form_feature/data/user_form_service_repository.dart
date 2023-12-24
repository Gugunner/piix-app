import 'package:piix_mobile/api_deprecated/piix_dio_provider_deprecated.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/domain/model/auth_user_form_model.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/domain/model/basic_form_model.dart';
import 'package:piix_mobile/form_feature/domain/model/form_model_deprecated.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_form_service_repository.g.dart';

abstract class _UserFormServiceRepositoryInterface {
  Future<FormModelOld> getUserForm(AuthUserFormModel formModel);
  Future<void> sendUserForm(BasicFormAnswerModel answerModel);
}

@riverpod
class UserFormServiceRepository extends _$UserFormServiceRepository
    implements _UserFormServiceRepositoryInterface {
  @override
  void build() => {};

  @override
  Future<FormModelOld> getUserForm(AuthUserFormModel formModel) async {
    final appConfig = AppConfig.instance;
    final path =
        '${appConfig.catalogEndpoint}/mainUserForms?mainUserInfoFormId=${formModel.mainUserInfoFormId}'
        '&userId=${formModel.userId}';
    final response = await ref.read(piixDioProvider).get(path);
    return FormModelOld.fromJson(response.data);
  }

  @override
  Future<void> sendUserForm(BasicFormAnswerModel answerModel) {
    final appConfig = AppConfig.instance;
    final path = '${appConfig.backendEndpoint}/user/mainForms/basicInformation';
    return ref.read(piixDioProvider).put(path, data: answerModel.toJson());
  }
}
