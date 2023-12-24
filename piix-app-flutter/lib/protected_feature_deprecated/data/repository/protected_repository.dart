import 'package:piix_mobile/protected_feature_deprecated/data/repository/protected_repository_impl.dart';
import 'package:piix_mobile/protected_feature_deprecated/data/repository/protected_repository_test.dart';
import 'package:piix_mobile/protected_feature_deprecated/data/service/protected_api.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/model/request_available_protected_model.dart';

enum ProtectedState {
  idle,
  notFound,
  error,
  retrieving,
  retrieved,
}

class ProtectedRepository {
  const ProtectedRepository(this.protectedApi);

  final ProtectedApi protectedApi;

  Future<dynamic> getAvailableProtectedRequested({
    required RequestAvailableProtectedModel requestModel,
    bool test = false,
    bool useFirebase = true,
  }) async {
    if (test) {
      return getAvailableProtectedRequestedTest(requestModel: requestModel);
    }
    return getAvailableProtectedRequestedImpl(
      requestModel: requestModel,
      useFirebase: useFirebase,
    );
  }
}
