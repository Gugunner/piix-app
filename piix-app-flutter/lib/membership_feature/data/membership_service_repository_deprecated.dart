import 'package:piix_mobile/api_deprecated/piix_dio_provider_deprecated.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/membership_feature/membership_model_barrel_file.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'membership_service_repository_deprecated.g.dart';

@Deprecated('Will be removed in 4.0')

///An interface that must be implemented in any memberships
///repository
abstract class _MembershipServiceRepositoryInterface {
  Future<List<MembershipModel>> getUserMemberships(String usernameCredential);
}

@Deprecated('Will be removed in 4.0')

///A Riverpod Repository class that handles retrieving
///the [user] memberships
@riverpod
class UserMembershipServiceRepository extends _$UserMembershipServiceRepository
    implements _MembershipServiceRepositoryInterface {
  @override
  void build() => {};

  @override
  Future<List<MembershipModel>> getUserMemberships(String userId) async {
    final appConfig = AppConfig.instance;
    final path =
        '${appConfig.backendEndpoint}/users/memberships?userId=$userId';
    final response = await ref.read(piixDioProvider).get(path);
    final data = response.data;
    return (data as List<dynamic>)
        .map((json) => MembershipModel.fromJson(json))
        .toList();
  }
}
