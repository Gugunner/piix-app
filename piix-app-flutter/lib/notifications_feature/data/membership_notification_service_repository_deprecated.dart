import 'package:piix_mobile/api_deprecated/piix_dio_provider_deprecated.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/notifications_feature/domain/model/membership_notification_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'membership_notification_service_repository_deprecated.g.dart';

@Deprecated('Will ve removed in 4.0')
abstract class _MembershipNotificationServiceRepositoryInterface {
  Future<MembershipNotificationModel> getMembershipNotifications(
      String membershipId);
}

@Deprecated('Will ve removed in 4.0')
@riverpod
class MembershipNotificationServiceRepository
    extends _$MembershipNotificationServiceRepository
    implements _MembershipNotificationServiceRepositoryInterface {
  @override
  void build() => {};

  @override
  Future<MembershipNotificationModel> getMembershipNotifications(
      String membershipId) async {
    final appConfig = AppConfig.instance;
    final path =
        '${appConfig.backendEndpoint}/users/memberships/notifications?membershipId=$membershipId';
    final response = await ref.read(piixDioProvider).get(path);
    return MembershipNotificationModel.fromJson(response.data);
  }
}
