import 'package:piix_mobile/file_feature/file_model_barrel_file.dart';
import 'package:piix_mobile/file_feature/file_repository_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'request_file_provider.g.dart';

@riverpod
final class RequestFilePod extends _$RequestFilePod {
  String get _className => 'RequestFilePod';

  @override
  Future<FileContentModel> build(RequestFileModel requestFile) =>
      _getFile(requestFile);

  Future<FileContentModel> _getFile(RequestFileModel requestFile) async {
    try {
      return await ref.read(fileRepositoryPod).getFile(requestFile);
    } catch (error) {
       AppApiExceptionHandler.handleError(_className, error);
      rethrow;
    }
  }
}
