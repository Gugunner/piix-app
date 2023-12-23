import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/data/repository/file_system_repository_deprecated.dart';
import 'package:piix_mobile/file_feature/domain/model/request_file_model.dart';
import 'package:piix_mobile/file_feature/domain/model/s3_file_model.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';

@Deprecated('Will be removed in 4.0')
extension FileSystemRepositoryImplementationDeprecated on FileSystemRepositoryDeprecated {
  Future<dynamic> getFileFromPathRequestedImpl(
      RequestFileModel requestFileModel) async {
    try {
      final response = await fileSystemApi.getFileFromPathApi(requestFileModel);
      final statusCode = response.statusCode ?? 500;
      if (PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        if (response.data != null) {
          response.data['state'] = FileStateDeprecated.retrieved;
          return response.data;
        }
      }
      return FileStateDeprecated.error;
    } on DioError catch (dioError) {
      var fileState = FileStateDeprecated.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.notFound) {
        fileState = FileStateDeprecated.notFound;
      }
      if (fileState != FileStateDeprecated.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in getFileFromPathRequestedImpl '
              'with path ${requestFileModel.filePath}',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.error,
        );
        return fileState;
      }
      throw piixApiExceptions;
    }
  }

  Future<FileStateDeprecated> uploadS3FileRequestedImpl(
      S3FileModel s3FileModel) async {
    try {
      final response = await fileSystemApi.uploadS3FileApi(s3FileModel);
      final statusCode = response.statusCode ?? 500;
      if (PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        return FileStateDeprecated.uploaded;
      }
      return FileStateDeprecated.error;
    } on DioError catch (dioError) {
      var fileState = FileStateDeprecated.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.conflict ||
          statusCode == HttpStatus.unauthorized) {
        fileState = FileStateDeprecated.uploadError;
      }
      if (fileState != FileStateDeprecated.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in getFileFromPathRequestedImpl '
              'with file route ${s3FileModel.fileFullRoute}',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.error,
        );
        return fileState;
      }
      throw piixApiExceptions;
    }
  }
}
