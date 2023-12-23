import 'package:dio/dio.dart';
import 'package:piix_mobile/file_feature/domain/model/file_content_model.dart';
import 'package:piix_mobile/file_feature/domain/model/file_model.dart';
import 'package:piix_mobile/file_feature/domain/model/request_file_model.dart';
import 'package:piix_mobile/file_feature/domain/model/s3_file_model.dart';
import 'package:piix_mobile/file_feature/file_repository_barrel_file.dart';
import 'package:piix_mobile/utils/api/repository_auxiliaries.dart';
import 'package:piix_mobile/utils/endpoints.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

///Contains all the services calls
final class FileRepository
    with RepositoryAuxiliaries
    implements IFileRepository {
  @override
  Future<FileContentModel> getFile(RequestFileModel requestFileModel) async {
    final path = EndPoints.getFileEndpoint;
    final response = await dio.post(path, data: requestFileModel.toJson());
    final fileContent = response.data['fileContent'];
    return FileContentModel.fromJson(fileContent);
  }

  @override
  Future<Response> sendFile(Map<String, dynamic> file) async {
    final path = EndPoints.sendFileEndpoint;
    return dio.put(path, data: file);
  }

  Future<Response> sendS3File(S3FileModel file) async {
    return sendFile(file.toJson());
  }
}

//Declare a simple Riverpod Provider that can modify the repository
final fileRepositoryPod = Provider<IFileRepository>((ref) => FileRepository());
