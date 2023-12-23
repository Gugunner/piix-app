import 'package:flutter/cupertino.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/data/repository/catalog_repository.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/general_app_feature/domain/model/country_model.dart';
import 'package:piix_mobile/general_app_feature/domain/model/selector_model.dart';

/// This BLoC is where all catalog data is stored.
class CatalogBLoC with ChangeNotifier {
  bool _appTest = false;
  bool get appTest => _appTest;
  void setAppTest(bool value) {
    _appTest = value;
  }

  SelectorsModel _kinships = SelectorsModel(selectors: []);
  List<SelectorModel> get kinships => _kinships.selectors;
  set kinships(List<SelectorModel> selectors) {
    _kinships = SelectorsModel(selectors: selectors);
    notifyListeners();
  }

  SelectorsModel _countries = SelectorsModel(selectors: []);
  List<SelectorModel> get countries => _countries.selectors;
  set countries(List<SelectorModel> selectors) {
    _countries = SelectorsModel(selectors: selectors);
    notifyListeners();
  }

  SelectorsModel _states = SelectorsModel(selectors: []);
  List<SelectorModel> get states => _states.selectors;
  set states(List<SelectorModel> selectors) {
    _states = SelectorsModel(selectors: selectors);
    notifyListeners();
  }

  SelectorsModel _prefixes = SelectorsModel(selectors: []);
  List<SelectorModel> get prefixes => _prefixes.selectors;
  set prefixes(List<SelectorModel> selectors) {
    _prefixes = SelectorsModel(selectors: selectors);
    notifyListeners();
  }

  SelectorsModel _genders = SelectorsModel(selectors: []);
  List<SelectorModel> get genders => _genders.selectors;
  set genders(List<SelectorModel> selectors) {
    _genders = SelectorsModel(selectors: selectors);
    notifyListeners();
  }

  ///A CatalogRepository singleton
  CatalogRepository get catalogRepository => getIt<CatalogRepository>();

  ///Used to manage the request of a catalog
  CatalogStateDeprecated _catalogState = CatalogStateDeprecated.idle;
  CatalogStateDeprecated get catalogState => _catalogState;
  set catalogState(CatalogStateDeprecated state) {
    _catalogState = state;
    notifyListeners();
  }

  ///Sets a list of [SelectorModel] on the corresponding [CatalogBLoC] property, based on the [CatalogName]
  ///
  /// Depending on the value of [catalogName] retrieves the corresponding list, creates a SelectorsModel from the data
  /// and sets the list in one of the properties of [CatalogBLoC].
  /// The use of [countryId] is only when states are being retrieved.
  ///
  Future<void> getAllFromCatalogName(CatalogName catalogName,
      [String? countryId]) async {
    //Delete once the app handles more countries
    if (catalogName == CatalogName.countries) {
      countries = [
        SelectorModel(
          id: 'MEX',
          folio: 'MX',
          name: 'México',
        )
      ];
      catalogState = CatalogStateDeprecated.retrieved;
      return;
    }
    try {
      CountryModel? countryModel;
      if (catalogName == CatalogName.states && countryId.isNotNullEmpty) {
        countryModel = CountryModel(countryId: countryId!);
      }
      final data = await catalogRepository.getAllFromCatalogNameRequested(
          catalogName, countryModel, appTest);
      if (data is CatalogStateDeprecated) {
        catalogState = data;
      } else {
        final selectors = SelectorsModel.fromJson(data).selectors;
        switch (catalogName) {
          //Right now is not used
          case CatalogName.countries:
            countries = selectors;
            break;
          case CatalogName.genders:
            genders = selectors;
            break;
          case CatalogName.kinships:
            kinships = selectors;
            break;
          case CatalogName.prefixes:
            prefixes = selectors;
            break;
          case CatalogName.states:
            states = selectors;
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
        catalogState = data['state'];
      }
    } catch (e) {
      if (e is AppApiLogException) {
        debugPrint('Piix Api Exceptions - ${e.toString()}');
      } else {
        debugPrint('Piix App Exception - ${e.toString()}');
      }
      catalogState = CatalogStateDeprecated.error;
    }
  }

  void clearProvider() {
    _kinships = SelectorsModel(selectors: []);
    _countries = SelectorsModel(selectors: []);
    _states = SelectorsModel(selectors: []);
    _prefixes = SelectorsModel(selectors: []);
    _genders = SelectorsModel(selectors: []);
    _catalogState = CatalogStateDeprecated.idle;
    notifyListeners();
  }
}
