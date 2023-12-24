import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'html_provider.g.dart';

@riverpod
final class TermsAndConditionsPod extends _$TermsAndConditionsPod {
  String get _className => 'TermsAndConditionsPod';

  @override
  Future<HtmlModel> build() => _getTermsAndConditions();

  Future<HtmlModel> _getTermsAndConditions() async {
    try {
      //TODO: Uncomment when the service is working
      // return await ref.read(htmlRepositoryPod).getTermsAndConditions();
      //TODO: Delete error
      throw Error();
    } catch (error) {
      AppApiExceptionHandler.handleError(_className, error);
      rethrow;
    }
  }
}
