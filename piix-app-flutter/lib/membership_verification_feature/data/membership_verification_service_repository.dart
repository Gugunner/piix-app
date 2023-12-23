import 'package:piix_mobile/api_deprecated/piix_dio_provider_deprecated.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'membership_verification_service_repository.g.dart';

abstract class _MembershipVerificationServiceRepositoryInterface {
  Future<void> startMembershipVerification();
}

@riverpod
class MembershipVerificationServiceRepositoryPod
    extends _$MembershipVerificationServiceRepositoryPod
    implements _MembershipVerificationServiceRepositoryInterface {
  @override
  void build() => {};

  @override
  Future<void> startMembershipVerification() {
    final appConfig = AppConfig.instance;
    final path = '${appConfig.backendEndpoint}/user/mainForms/confirm';
    return ref.read(piixDioProvider).post(path, data: {});
  }
}
