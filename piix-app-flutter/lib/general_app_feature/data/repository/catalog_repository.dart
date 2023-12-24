import 'package:piix_mobile/general_app_feature/data/repository/catalog_repository_app-use_test.dart';
import 'package:piix_mobile/general_app_feature/data/repository/catalog_repository_impl.dart';
import 'package:piix_mobile/general_app_feature/data/service/catalog_api.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/general_app_feature/domain/model/country_model.dart';
import 'package:piix_mobile/general_app_feature/utils/app_use_case_test.dart';

enum CatalogName {
  countries,
  genders,
  kinships,
  prefixes,
  states,
  packages,
  unknowns,
}

@Deprecated('Will be removed in 4.0')
enum CatalogStateDeprecated { idle, retrieving, retrieved, isEmpty, error }

///Handles all calls to different data sources whether real or fake information regarding Piix Catalogs.
class CatalogRepository {
  CatalogRepository(this.catalogApi);

  final CatalogApi catalogApi;
  final _appTest = getIt<AppUseCaseTestFlag>().test;

  Future<dynamic> getAllFromCatalogNameRequested(CatalogName name,
      [CountryModel? countryModel, bool test = false]) async {
    if (test || _appTest) {
      return getAllFromCatalogNameRequestedTest(name, countryModel);
    }
    return getAllFromCatalogNameRequestedImpl(name, countryModel);
  }
}
