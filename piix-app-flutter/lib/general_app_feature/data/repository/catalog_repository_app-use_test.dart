// ignore_for_file: file_names
import 'package:piix_mobile/general_app_feature/data/repository/catalog_repository.dart';
import 'package:piix_mobile/general_app_feature/domain/model/country_model.dart';

///Handles all fake implementations used for testing use cases of calling api services for Piix Catalog.
extension CatalogRepositoryAppUseTest on CatalogRepository {
  Future<dynamic> getAllFromCatalogNameRequestedTest(CatalogName name,
      [CountryModel? countryModel]) async {
    var selectors = <Map<String, dynamic>>[];
    switch (name) {
      case CatalogName.countries:
        selectors = fakeJsonCountries();
        break;
      case CatalogName.genders:
        selectors = fakeJsonGenders();
        break;
      case CatalogName.kinships:
        selectors = fakeJsonKinships();
        break;
      case CatalogName.prefixes:
        selectors = fakeJsonPrefixes();
        break;
      case CatalogName.states:
        selectors = fakeJsonStates();
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
    return {
      'selectors': selectors,
      'state': CatalogStateDeprecated.retrieved,
    };
  }

  List<Map<String, dynamic>> fakeJsonCountries() {
    return [
      {
        'countryId': 'MEX',
        'folio': 'MX',
        'name': 'México',
      },
      {
        'countryId': 'COL',
        'folio': 'CO',
        'name': 'Colombia',
      },
      {
        'countryId': 'USA',
        'folio': 'US',
        'name': 'Estados Unidos',
      },
    ];
  }

  List<Map<String, dynamic>> fakeJsonGenders() {
    return [
      {
        'genderId': 'gender1',
        'folio': 'H',
        'name': 'Hombre',
      },
      {
        'genderId': 'gender2',
        'folio': 'M',
        'name': 'Mujer',
      },
      {
        'genderId': 'gender3',
        'folio': 'O',
        'name': 'Otro',
      },
    ];
  }

  List<Map<String, dynamic>> fakeJsonKinships() {
    return [
      {
        'kinshipId': 'kinship1',
        'folio': 'I',
        'name': 'Individual',
      },
      {
        'kinshipId': 'kinship2',
        'folio': 'C',
        'name': 'Conyuge',
      },
      {
        'kinshipId': 'kinship3',
        'folio': 'P',
        'name': 'Padre',
      },
    ];
  }

  List<Map<String, dynamic>> fakeJsonPrefixes() {
    return [
      {
        'prefixId': 'prefix1',
        'folio': 'MR',
        'name': 'Sr.',
      },
      {
        'prefixId': 'prefix2',
        'folio': 'MRS',
        'name': 'Sra.',
      },
    ];
  }

  List<Map<String, dynamic>> fakeJsonStates() {
    return [
      {
        'stateId': 'MEXCDMX',
        'folio': 'MEXCDMX',
        'name': 'Ciudad de México',
      },
      {
        'stateId': 'MEXCHI',
        'folio': 'MEXCHI',
        'name': 'Chihuahua',
      },
      {
        'stateId': 'MEXAGS',
        'folio': 'MEXAGS',
        'name': 'Aguas Calientes',
      },
    ];
  }
}
