import 'package:piix_mobile/file_feature/file_repository_barrel_file.dart';
import 'package:piix_mobile/utils/api/app_api_exception_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:piix_mobile/file_feature/file_model_barrel_file.dart';

part 'submit_s3_file_provider.g.dart';

@riverpod
final class SubmitS3FilePod extends _$SubmitS3FilePod {
  String get _className => 'SubmitS3FilePod';

  @override
  Future<void> build(List<S3FileModel> s3Files) => _sendS3Files(s3Files);

  Future<void> _sendS3Files(List<S3FileModel> s3Files) async {
    final fileRepository = ref.read(fileRepositoryPod) as FileRepository;
    try {
      for (final file in s3Files) {
        await fileRepository.sendS3File(file);
      }
    } catch (error) {
      AppApiExceptionHandler.handleError(_className, error);
      rethrow;
    }
  }
}
