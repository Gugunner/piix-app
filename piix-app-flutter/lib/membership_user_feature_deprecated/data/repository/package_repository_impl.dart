import 'dart:io';

import 'package:dio/dio.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/package_repository.dart';

//TODO: Add documentation to extension repository
extension PackageRepositoryImplementation on PackageRepository {
  Future<dynamic> getAllPackagesRequestedImpl() async {
    try {
      final response = await packageApi.getAllPackagesApi();
      final statusCode = response.statusCode ?? 500;
      if (PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        if (response.data != null) {
          if (response.data is List) {
            final packages = response.data;
            final data = <String, dynamic>{
              'packages': packages,
              'state': ObtainedPackageState.retrieved,
            };
            return data;
          }
        }
      }
      return ObtainedPackageState.error;
    } on DioError catch (dioError) {
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.conflict) {
        //TODO: Do something
      }
      throw piixApiExceptions;
    }
  }
}
