import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/data/repository/file_system_repository_deprecated.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/file_feature/domain/model/file_model.dart';
import 'package:piix_mobile/file_feature/domain/model/request_file_model.dart';
import 'package:piix_mobile/file_feature/domain/model/s3_file_model.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';

@Deprecated('Use instead the corresponding provider in file_provider.dart')
class FileSystemBLoC with ChangeNotifier {
  ///Controls if the api requests call the real api or instead read from a
  ///fake response.
  bool _appTest = false;
  bool get appTest => _appTest;
  void setAppTest(bool value) {
    _appTest = value;
  }

  FileStateDeprecated _fileState = FileStateDeprecated.idle;
  FileStateDeprecated get fileState => _fileState;
  set fileState(FileStateDeprecated state) {
    _fileState = state;
    notifyListeners();
  }

  FileModel? _file;
  FileModel? get file => _file;
  set file(FileModel? file) {
    _file = file;
    notifyListeners();
  }

  FileSystemRepositoryDeprecated get fileSystemRepository =>
      getIt<FileSystemRepositoryDeprecated>();

  Future<FileModel?> getFileFromPath({
    required String userId,
    required String filePath,
    required String propertyName,
  }) async {
    try {
      final requestFileModel = RequestFileModel(
        userId: userId,
        filePath: filePath,
        propertyName: propertyName,
      );
      fileState = FileStateDeprecated.retrieving;
      final data =
          await fileSystemRepository.getFileFromPathRequested(requestFileModel);
      if (data is FileStateDeprecated) {
        fileState = data;
      } else {
        file = FileModel.fromJson(data);
        fileState = data['state'];
        return file;
      }
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in getFileFromPath with path $filePath',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      fileState = FileStateDeprecated.error;
    }
    return null;
  }

  Future<void> uploadS3File({
    required String fileFullRoute,
    required String fileContentType,
    required String fileObjectData,
    required String userId,
  }) async {
    try {
      final s3FileModel = S3FileModel(
        fileFullRoute: fileFullRoute,
        fileContentType: fileContentType,
        fileObjectData: fileObjectData,
        userId: userId,
      );
      fileState = FileStateDeprecated.uploading;
      fileState = await fileSystemRepository.uploadS3FileRequested(s3FileModel);
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in uploadS3File with file route $fileFullRoute',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      fileState = FileStateDeprecated.error;
    }
  }

  void clearProvider() {
    _fileState = FileStateDeprecated.idle;
    _file = null;
    notifyListeners();
  }

  /// Get the path of the image
  String getBenefitFormPath(
      {required String packageId,
      required String benefitFormId,
      required String userId,
      required String filename}) {
    return 'packages/$packageId/userBenefitForms/$benefitFormId/$userId/$filename';
  }
}
