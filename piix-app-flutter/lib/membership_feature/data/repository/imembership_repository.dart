import 'package:piix_mobile/membership_benefits_feature/domain/model/membership_benefits_model.dart';
import 'package:piix_mobile/membership_feature/membership_model_barrel_file.dart';
import 'package:piix_mobile/notifications_feature/domain/model/membership_notification_model.dart';

abstract interface class IMembershipRepository {
  ///Returns all the user memberships
  Future<MembershipModel> getUserMembership();

  ///Given a [membershipId] retrieves all the benefits of the membership.
  Future<MembershipBenefitsModel> getMembershipBenefits(
      {required String membershipId});

  ///Given a [membershipId] retrieves all the open notifications of the
  ///membership.
  Future<MembershipNotificationModel> getMembershipNotifications(
      {required String membershipId});

  ///Given a [linkupCode] retrieves the type and name.
  Future<LinkupCodeTypeModel> getLinkupCodeType(String linkupCode);

  Future<void> linkupMembershipToCommunity(LinkupMembershipModel linkupModel);

  Future<void> linkupMembershipToFamilyGroup(LinkupMembershipModel linkupModel);
}
