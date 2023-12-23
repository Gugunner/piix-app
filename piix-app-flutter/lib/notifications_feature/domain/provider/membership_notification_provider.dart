import 'package:dio/dio.dart';
import 'package:piix_mobile/membership_feature/domain/provider/membership_provider.dart';
import 'package:piix_mobile/notifications_feature/data/membership_notification_service_repository_deprecated.dart';
import 'package:piix_mobile/notifications_feature/domain/model/membership_notification_model.dart';
import 'package:piix_mobile/utils/log_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'membership_notification_provider.g.dart';

@Riverpod(keepAlive: true)
class MembershipNotificationNotifier extends _$MembershipNotificationNotifier {
  @override
  MembershipNotificationModel? build() => null;

  void setNotification(MembershipNotificationModel? notificationModel) {
    state = notificationModel;
  }

  MembershipNotificationModel? get notification => state;
}

@riverpod
class MembershipNotificationServiceNotifier
    extends _$MembershipNotificationServiceNotifier
    with LogApiCall, LogAppCall {
  @override
  FutureOr<void> build() => _getMembershipNotifications();

  Future<void> _getMembershipNotifications() async {
    try {
      final membershipId =
          ref.read(membershipNotifierPodProvider)?.membershipId ?? '';
      final repository =
          ref.read(membershipNotificationServiceRepositoryProvider.notifier);
      final notificationModel =
          await repository.getMembershipNotifications(membershipId);
      ref
          .read(membershipNotificationNotifierProvider.notifier)
          .setNotification(notificationModel);
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
