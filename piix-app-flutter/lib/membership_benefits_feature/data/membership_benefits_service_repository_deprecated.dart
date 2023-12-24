import 'package:piix_mobile/api_deprecated/piix_dio_provider_deprecated.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/membership_benefits_feature/domain/model/membership_benefits_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'membership_benefits_service_repository_deprecated.g.dart';

@Deprecated('Will be removed in 4.0')
///The interface to implement when calling the request to get
///user membership benefits
abstract class _MembershipBenefitsServiceRepository {
  Future<MembershipBenefitsModel> getMembershipBenefits(
      String userId, String membershipId);
}

@Deprecated('Will ve removed in 4.0')
///A Riverpod Service Notifier Repository class that contains the call to
///the api call to request the user membership benefits
@riverpod
class MembershipBenefitsServiceRepository
    extends _$MembershipBenefitsServiceRepository
    implements _MembershipBenefitsServiceRepository {
  @override
  void build() => {};

  ///Calls the dio provider to make a Get HTTP request to obtain the user 
  ///memberhips by her [userId] and [membershipId]
  @override
  Future<MembershipBenefitsModel> getMembershipBenefits(
      String userId, String membershipId) async {
    final appConfig = AppConfig.instance;
    final path =
        '${appConfig.backendEndpoint}/users/memberships/benefits?userId=$userId&membershipId=$membershipId';
    final response = await ref.read(piixDioProvider).get(path);
    return MembershipBenefitsModel.fromJson(response.data);
  }
}
