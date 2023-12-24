import 'package:piix_mobile/protected_feature_deprecated/data/repository/protected_form_repository_impl.dart';
import 'package:piix_mobile/protected_feature_deprecated/data/repository/protected_form_repository_test.dart';
import 'package:piix_mobile/protected_feature_deprecated/data/service/protected_form_api.dart';

enum ProtectedFormState {
  idle,
  retrieving,
  retrieved,
  retrievedError,
  sending,
  sent,
  sendError,
  ready,
}

class ProtectedFormRepository {
  const ProtectedFormRepository(this.formApi);

  final ProtectedFormApi formApi;

  Future<dynamic> getProtectedRegisterFormRequested({
    required String membershipId,
    bool test = false,
    bool useFirebase = true,
  }) async {
    if (test) {
      return getProtectedRegisterFormRequestedTest();
    }
    return getProtectedRegisterFormRequestedImpl(
      membershipId: membershipId,
      useFirebase: useFirebase,
    );
  }
}
