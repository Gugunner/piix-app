import 'package:dio/dio.dart';
import 'package:piix_mobile/form_feature/data/repository/form_repository.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'confirm_form_provider.g.dart';

@riverpod
final class ConfirmUserMainFormsPod extends _$ConfirmUserMainFormsPod {
  String get _className => 'ConfirmUserMainFormsPod';

  @override
  Future<Response> build() => _confirmUserMainForms();

  Future<Response> _confirmUserMainForms() async {
    try {
      final formRepository = ref.read(formRepositoryPod) as FormRepository;
      return await formRepository.confirmUserMainForms();
    } catch (error) {
      AppApiExceptionHandler.handleError(_className, error);
      rethrow;
    }
  }
}
