import 'package:dio/dio.dart';
import 'package:piix_mobile/api_deprecated/piix_dio_provider_deprecated.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/file_feature/domain/model/file_model.dart';
import 'package:piix_mobile/file_feature/domain/model/request_file_model.dart';
import 'package:piix_mobile/file_feature/domain/model/s3_file_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'file_repository_deprecated.g.dart';

@Deprecated('Will be removed in 4.0')
///An interface that must be implemented in all
///the file repository classes
abstract class _FileRepositoryInterface {
  @Deprecated('Will be removed in 4.0')
  Future<dynamic> getFile(requestFileModel);
  @Deprecated('Will be removed in 4.0')
  Future<dynamic> sendFile(fileModel);
}

@Deprecated('Will be removed in 4.0')
///A Riverpod Repository class that handles retrieving
///and sending files to and from an S3 path.
@riverpod
class S3FileRepository extends _$S3FileRepository
    implements _FileRepositoryInterface {
  @override
  void build() => {};

  @Deprecated('Will be removed in 4.0')
  ///Retrieves a [FileModel] by reading a [RequestFileModel]
  @override
  Future<FileModel> getFile(requestFileModel) async {
    final appConfig = AppConfig.instance;
    final path = '${appConfig.backendEndpoint}/files/get/fromPath';
    final response = await ref
        .read(piixDioProvider)
        .post(path, data: (requestFileModel as RequestFileModel).toJson());
    return FileModel.fromJson(response.data);
  }

  @Deprecated('Will be removed in 4.0')
  ///Uploads an [S3FileModel] to S3
  @override
  Future<Response> sendFile(fileModel) async {
    final appConfig = AppConfig.instance;
    final path = '${appConfig.catalogEndpoint}/upload/file';
    return ref
        .read(piixDioProvider)
        .put(path, data: (fileModel as S3FileModel).toJson());
  }
}
