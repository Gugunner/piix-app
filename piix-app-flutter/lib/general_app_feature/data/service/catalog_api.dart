import 'package:dio/dio.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/general_app_feature/data/repository/catalog_repository.dart';
import 'package:piix_mobile/general_app_feature/domain/model/country_model.dart';

///Works as a proxy class that is between the repository and [PiixApiDeprecated] to control errors and endpoints.
class CatalogApi {
  final appConfig = AppConfig.instance;

  ///Uses a different [path] endpoint depending on the catalog [name]
  Future<Response> getAllFromCatalogNameApi(CatalogName name,
      [CountryModel? countryModel]) async {
    var path = '';
    try {
      switch (name) {
        case CatalogName.countries:
          path = 'https://${appConfig.catalogEndpoint}/country/getAll';
          break;
        case CatalogName.genders:
          path = 'https://${appConfig.catalogEndpoint}/gender/getAll';
          break;
        case CatalogName.kinships:
          path = 'https://${appConfig.catalogEndpoint}/kinship/getAll';
          break;
        case CatalogName.prefixes:
          path = 'https://${appConfig.catalogEndpoint}/prefix/getAll';
          break;
        case CatalogName.states:
          path =
              'https://${appConfig.catalogEndpoint}/state/getAllByCountryId?countryId=${countryModel!.countryId}';
          break;
        case CatalogName.packages:
          // ignore: todo
          // TODO: Handle this case.
          break;
        case CatalogName.unknowns:
          // ignore: todo
          // TODO: Handle this case.
          break;
      }
      final response = await PiixApiDeprecated.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
