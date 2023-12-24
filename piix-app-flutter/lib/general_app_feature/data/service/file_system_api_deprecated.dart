import 'package:dio/dio.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/file_feature/domain/model/request_file_model.dart';
import 'package:piix_mobile/file_feature/domain/model/s3_file_model.dart';

@Deprecated('Use instead S3FileRepository')
class FileSystemApiDeprecated {
  final appConfig = AppConfig.instance;

  @Deprecated('Will be removed in 4.0')
  Future<Response> getFileFromPathApi(RequestFileModel requestFileModel) async {
    try {
      final path = '${appConfig.backendEndpoint}/files/get/fromPath';
      final response = await PiixApiDeprecated.post(
          path: path, data: requestFileModel.toJson());
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @Deprecated('Will be removed in 4.0')
  Future<Response> uploadS3FileApi(S3FileModel s3fileModel) async {
    try {
      final path = '${appConfig.catalogEndpoint}/upload/file';
      final response =
          await PiixApiDeprecated.put(path: path, data: s3fileModel.toJson());
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
