import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/membership_info_repository_impl.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/membership_info_repository_use_case_test.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/service/membership_info_api.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/membership_info_model.dart';
import 'package:piix_mobile/general_app_feature/utils/app_use_case_test.dart';

@Deprecated('Will be removed in 4.0')
enum MembershipInfoStateDeprecated {
  idle,
  retrieving,
  retrieved,
  notFound,
  error
}

@Deprecated('Will be removed in 4.0')

///Handles calling fake or real implementations for all services related to membership information
class MembershipInfoRepositoryDeprecated {
  MembershipInfoRepositoryDeprecated(this.membershipInfoApi);

  final MembershipInfoApi membershipInfoApi;
  final _appTest = getIt<AppUseCaseTestFlag>().test;

  Future<dynamic> getMembershipInfoRequested(
      RequestMembershipInfoModel requestModel) async {
    if (_appTest) {
      return getMembershipInfoRequestedTest(requestModel);
    }
    return getMembershipInfoRequestedImpl(requestModel);
  }
}
