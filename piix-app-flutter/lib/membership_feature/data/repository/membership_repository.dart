import 'package:piix_mobile/membership_benefits_feature/domain/model/membership_benefits_model.dart';
import 'package:piix_mobile/membership_feature/data/repository/imembership_repository.dart';
import 'package:piix_mobile/membership_feature/domain/model/linkup_code_type_model.dart';
import 'package:piix_mobile/membership_feature/domain/model/linkup_membership_model.dart';
import 'package:piix_mobile/membership_feature/domain/model/membership_model.dart';
import 'package:piix_mobile/notifications_feature/domain/model/membership_notification_model.dart';
import 'package:piix_mobile/utils/endpoints.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

///Contains all the service calls that handle the user memberships
///and its core information.
final class MembershipRepository
    with RepositoryAuxiliaries
    implements IMembershipRepository {
  @override
  Future<MembershipBenefitsModel> getMembershipBenefits(
      {required String membershipId}) async {
    final path = '${EndPoints.getMembershipBenefitsEndpoint}?'
        'membershipId=$membershipId';
    final response = await dio.get(path);
    return MembershipBenefitsModel.fromJson(response.data);
  }

  @override
  Future<MembershipNotificationModel> getMembershipNotifications(
      {required String membershipId}) async {
    final path = '${EndPoints.getMembershipNotificationsEndpoint}?'
        'membershipId=$membershipId';
    final response = await dio.get(path);
    return MembershipNotificationModel.fromJson(response.data);
  }

  @override
  Future<MembershipModel> getUserMembership() async {
    final path = EndPoints.getUserMembershipsEndpoint;
    final response = await dio.get(path);
    return MembershipModel.fromJson(response.data);
  }

  @override
  Future<LinkupCodeTypeModel> getLinkupCodeType(String linkupCode) async {
    final path =
        '${EndPoints.getLinkupCodeTypeEndpoint}?linkupCode=$linkupCode';
    final response = await dio.get(path);
    return LinkupCodeTypeModel.fromJson(response.data);
  }

  @override
  Future<void> linkupMembershipToCommunity(LinkupMembershipModel linkupModel) {
    final path = EndPoints.linkupMembershipByCodeEndpoint;
    return dio.post(path, data: linkupModel.toJson());
  }

  @override
  Future<void> linkupMembershipToFamilyGroup(
      LinkupMembershipModel linkupModel) {
    final path = EndPoints.linkUserToSlotEndpoint;
    return dio.post(path, data: linkupModel.toJson());
  }
}

//Declare a simple Riverpod Provider that can modify the repository
final membershipRepositoryPod =
    Provider<IMembershipRepository>((ref) => MembershipRepository());
