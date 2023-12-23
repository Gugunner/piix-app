import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/user_credential_model.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/user_repository_use_case_test.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/user_repository_impl.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/service/user_api.dart';
import 'package:piix_mobile/user_profile_feature/domain/model/update_credential_model.dart';
import 'package:piix_mobile/general_app_feature/utils/app_use_case_test.dart';

@Deprecated('Will be removed in 4.0')
enum UserActionStateDeprecated {
  idle,
  retrieving,
  updating,
  retrieved,
  updated,
  notFound,
  notAuthorized,
  empty,
  alreadyExists,
  errorUpdating,
  error
}

@Deprecated('Will be removed in 4.0')
//TODO: Add documentation
class UserRepositoryDeprecated {
  UserRepositoryDeprecated(this.userApi);

  final UserApi userApi;
  final _appTest = getIt<AppUseCaseTestFlag>().test;

  Future<dynamic> getUserByEmailRequested(
      UserCredentialModel credentialModel) async {
    if (_appTest) {
      return getUserByEmailRequestedTest(credentialModel);
    }
    return getUserByEmailRequestedImpl(credentialModel);
  }

  Future<dynamic> getUserByPhoneRequested(
      UserCredentialModel credentialModel) async {
    if (_appTest) {
      return getUserByPhoneRequestedTest(credentialModel);
    }
    return getUserByPhoneRequestedImpl(credentialModel);
  }

  Future<dynamic> getUserLevelsAndPlansRequested() async {
    if (_appTest) {
      return getUserLevelsAndPlansRequestedTest();
    }
    return getUserLevelsAndPlansRequestedImpl();
  }

  Future<UserActionStateDeprecated> updateUserEmailRequested(
    UpdateEmailRequestModel requestModel,
  ) async {
    if (_appTest) {
      return updateUserEmailRequestedTest(requestModel);
    }
    return updateUserEmailRequestedImpl(requestModel);
  }

  Future<UserActionStateDeprecated> updateUserPhoneNumberRequested(
    UpdatePhoneNumberRequestModel requestModel,
  ) async {
    if (_appTest) {
      return updateUserPhoneNumberRequestedTest(requestModel);
    }
    return updateUserPhoneNumberRequestedImpl(requestModel);
  }
}
