import 'dart:io';

import 'package:dio/dio.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/data/repository/catalog_repository.dart';
import 'package:piix_mobile/general_app_feature/domain/model/country_model.dart';

///Handles all real implementations of calling api services for Piix Catalog.
extension CatalogRepositoryImplementation on CatalogRepository {
  ///Calls the [CatalogApi] and if data is retrieved it is stored inside a new Map property [selectors],
  ///
  /// A new Map is returned that includes bot the data and the [CatalogStateDeprecated].
  ///
  Future<dynamic> getAllFromCatalogNameRequestedImpl(CatalogName name,
      [CountryModel? countryModel]) async {
    try {
      final response =
          await catalogApi.getAllFromCatalogNameApi(name, countryModel);
      final statusCode = response.statusCode ?? 500;
      if (PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        if (response.data != null) {
          final selectors = response.data;
          final data = <String, dynamic>{
            'selectors': selectors,
            'state': CatalogStateDeprecated.retrieved,
          };
          return data;
        }
      }
      return CatalogStateDeprecated.error;
    } on DioError catch (dioError) {
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.conflict) {
        return CatalogStateDeprecated.isEmpty;
      }
      throw piixApiExceptions;
    }
  }
}
