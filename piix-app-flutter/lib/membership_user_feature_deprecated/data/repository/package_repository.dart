import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/package_repository_impl.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/package_repository_use_case_test.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/service/package_api.dart';
import 'package:piix_mobile/general_app_feature/utils/app_use_case_test.dart';

enum ObtainedPackageState {
  idle,
  retrieving,
  retrieved,
  ready,
  notFound,
  empty,
  error
}

//TODO: Add documentation to class repository
class PackageRepository {
  PackageRepository(this.packageApi);

  final _appTest = getIt<AppUseCaseTestFlag>().test;
  final PackageApi packageApi;

  Future<dynamic> getAllPackagesRequested() async {
    if (_appTest) {
      return getAllPackagesRequestedTest();
    }
    return getAllPackagesRequestedImpl();
  }
}
