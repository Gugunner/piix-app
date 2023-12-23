import 'package:piix_mobile/general_app_feature/data/repository/file_system_repository_app_use_test_deprecated.dart';
import 'package:piix_mobile/general_app_feature/data/repository/file_system_repository_impl_deprecated.dart';
import 'package:piix_mobile/general_app_feature/data/service/file_system_api_deprecated.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/file_feature/domain/model/request_file_model.dart';
import 'package:piix_mobile/file_feature/domain/model/s3_file_model.dart';
import 'package:piix_mobile/general_app_feature/utils/app_use_case_test.dart';

@Deprecated('Will be removed in 4.0')
enum FileStateDeprecated {
  idle,
  retrieving,
  retrieved,
  uploading,
  uploaded,
  uploadError,
  notFound,
  error,
}

@Deprecated('Use instead S3FileRepository')
class FileSystemRepositoryDeprecated {
  FileSystemRepositoryDeprecated(this.fileSystemApi);

  final FileSystemApiDeprecated fileSystemApi;
  final _appTest = getIt<AppUseCaseTestFlag>().test;

  Future<dynamic> getFileFromPathRequested(
      RequestFileModel requestFileModel) async {
    if (_appTest) {
      return getFileFromPathRequestedTest(requestFileModel);
    }
    return getFileFromPathRequestedImpl(requestFileModel);
  }

  Future<FileStateDeprecated> uploadS3FileRequested(
      S3FileModel s3FileModel) async {
    if (_appTest) {
      return uploadS3FileRequestedTest(s3FileModel);
    }
    return uploadS3FileRequestedImpl(s3FileModel);
  }
}
