import 'package:dio/dio.dart';
import 'package:piix_mobile/auth_feature/domain/provider/user_provider.dart';
import 'package:piix_mobile/membership_benefits_feature/data/membership_benefits_service_repository_deprecated.dart';
import 'package:piix_mobile/membership_benefits_feature/domain/model/membership_benefits_model.dart';
import 'package:piix_mobile/membership_feature/domain/provider/membership_provider.dart';
import 'package:piix_mobile/utils/log_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'membership_benefits_provider.g.dart';

///A Riverpod Notifier class that handles and stores the user
///membership benefits and manipulates all changes to them
@Riverpod(keepAlive: true)
class MembershipBenefitsNotifier extends _$MembershipBenefitsNotifier {
  @override
  MembershipBenefitsModel? build() => null;

  void setBenefits(MembershipBenefitsModel? model) {
    state = model;
  }

  MembershipBenefitsModel? get benefits => state;
}

///A Riverpod Notifier Service class that handles the request
///to obtain the user membership benefits.
@riverpod
class MembershipBenefitsServiceNotifier
    extends _$MembershipBenefitsServiceNotifier with LogApiCall, LogAppCall {
  @override
  FutureOr<void> build() => _getMembershipBenefits();

  ///Calls the user membership benefits and sets the values in the
  ///MembershipBenefitsNotifier provider
  Future<void> _getMembershipBenefits() async {
    try {
      final membershipId =
          ref.read(membershipNotifierPodProvider)?.membershipId ?? '';
      final userId = ref.read(userPodProvider)?.userId ?? '';
      final repository =
          ref.read(membershipBenefitsServiceRepositoryProvider.notifier);
      final model =
          await repository.getMembershipBenefits(userId, membershipId);
      ref.read(membershipBenefitsNotifierProvider.notifier).setBenefits(model);
    } catch (error) {
      if (error is! DioError) {
        logError(error, className: 'MembershipNotificationServiceNotifier');
      } else {
        logDioException(error,
            className: 'MembershipNotificationServiceNotifier');
      }
      rethrow;
    }
  }
}
