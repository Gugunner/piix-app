import 'package:piix_mobile/general_app_feature/domain/model/selector_model.dart';

/// Interface for Catalogs Repository
abstract class CatalogsRepositoryInterface {
  /// This method is used to get all countries
  Future<List<SelectorModel>> getAllCountries();

  /// This method is used to get all Kinships
  Future<List<SelectorModel>> getAllKinships();

  /// This method is used to get all states by a country id
  Future<List<SelectorModel>> getStateByCountryId({String? countryId});

  /// This method is used to get all prefixes
  Future<List<SelectorModel>> getAllPrefixes();

  /// This method is used to get all genders
  Future<List<SelectorModel>> getAllGenders();

  //TODO: Delete method when no relationship exists in the app
  /// This method is used to get all packages
  // Future<List<SelectorModel>> getAllPackages();
}
