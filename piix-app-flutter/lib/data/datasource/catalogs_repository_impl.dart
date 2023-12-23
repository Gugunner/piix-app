import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/domain/repository/catalogs_repository_interface.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/general_app_feature/domain/model/selector_model.dart';

/// Implementation of Catalogs Repository Interface
class CatalogsRepositoryImpl extends CatalogsRepositoryInterface {
  final appConfig = AppConfig.instance;
  @override
  Future<List<SelectorModel>> getAllCountries() async {
    try {
      final countryList = [
        SelectorModel(id: 'MEX', folio: 'MX', name: 'México')
      ];
      return countryList;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<SelectorModel>> getAllGenders() async {
    final url = 'https://${appConfig.catalogEndpoint}/gender/getAll';
    try {
      final response = await PiixApiDeprecated.get(url);
      if (PiixApiDeprecated.checkStatusCode(statusCode: response.statusCode!)) {
        final List<dynamic> genderList = response.data;
        final genders = <SelectorModel>[];
        genderList.forEach((gender) {
          genders.add(SelectorModel(
              id: gender['genderId'],
              folio: gender['genderId'],
              name: gender['name']));
        });
        return genders;
      }
      throw Exception(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<SelectorModel>> getAllKinships() async {
    final url = 'https://${appConfig.catalogEndpoint}/kinship/getAll';
    try {
      final response = await PiixApiDeprecated.get(url);
      if (PiixApiDeprecated.checkStatusCode(statusCode: response.statusCode!)) {
        final List<dynamic> kinshipList = response.data;
        final kinships = <SelectorModel>[];
        kinshipList.forEach((kinship) => kinships.add(SelectorModel(
              id: kinship['kinshipId'],
              folio: kinship['kinshipId'],
              name: kinship['name'],
            )));
        return kinships;
      }
      throw Exception(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<SelectorModel>> getAllPrefixes() async {
    final url = 'https://${appConfig.catalogEndpoint}/prefix/getAll';

    try {
      final response = await PiixApiDeprecated.get(url);
      if (PiixApiDeprecated.checkStatusCode(statusCode: response.statusCode!)) {
        final List<dynamic> prefixList = response.data;
        final prefixes = <SelectorModel>[];
        prefixList.forEach((prefix) {
          prefixes.add(SelectorModel(
              id: prefix['prefixId'],
              folio: prefix['prefixId'],
              name: prefix['name']));
        });
        return prefixes;
      }
      throw Exception(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<SelectorModel>> getStateByCountryId({String? countryId}) async {
    final url =
        'https://${appConfig.catalogEndpoint}/state/getAllByCountryId?countryId=$countryId';

    try {
      final response = await PiixApiDeprecated.get(url);
      if (PiixApiDeprecated.checkStatusCode(statusCode: response.statusCode!)) {
        final List<dynamic> dynamicStates = response.data;

        final stateList = dynamicStates.map((e) {
          return SelectorModel(
            id: e['stateId'],
            folio: e['stateId'],
            name: e['name'],
          );
        }).toList();

        return stateList;
      }
      throw Exception(response.data);
    } catch (e) {
      rethrow;
    }
  }

  //TODO: Delete method when no relationship exists in the app
  // @override
  // Future<List<SelectorModel>> getAllPackages() async {
  //   final url = 'https://$backendSQLURL/package/getAllActive';
  //
  //   try {
  //     final response = await PiixApi.get(url);
  //     if (PiixApi.checkStatusCode(statusCode: response.statusCode!)) {
  //       List<dynamic> dynamicStates = response.data;
  //       int count = 0;
  //
  //       final packageList = dynamicStates.map((e) {
  //         return SelectorModel(
  //             index: count++, id: e['packageId'], name: e['name']);
  //       }).toList();
  //
  //       return packageList;
  //     }
  //     throw Exception(response.data);
  //   } catch (_) {
  //     rethrow;
  //   }
  // }
}
