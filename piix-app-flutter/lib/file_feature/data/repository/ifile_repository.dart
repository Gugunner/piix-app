import 'package:dio/dio.dart';
import 'package:piix_mobile/file_feature/domain/model/file_content_model.dart';
import 'package:piix_mobile/file_feature/file_model_barrel_file.dart';

abstract interface class IFileRepository {
  ///Returns a [FileModel] given a [RequestFileModel].
  Future<FileContentModel> getFile(RequestFileModel requestFileModel);

  ///Submits a [file] in json format.
  Future<Response> sendFile(Map<String, dynamic> file);
}
