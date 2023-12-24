import 'package:piix_mobile/membership_feature/data/repository/imembership_repository.dart';
import 'package:piix_mobile/membership_feature/data/repository/membership_repository.dart';
import 'package:piix_mobile/membership_feature/membership_model_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'linkup_code_provider.g.dart';

///Calls the repository to check the [linkupCode] and
///retrieve a [LinkupCodeTypeModel]
@riverpod
final class LinkupCodeTypePod extends _$LinkupCodeTypePod {
  String get _className => 'LinkupCodeTypePod';

  @override
  Future<LinkupCodeTypeModel> build(String linkupCode) =>
      _getLinkupCodeType(linkupCode);

  Future<LinkupCodeTypeModel> _getLinkupCodeType(String linkupCode) async {
    try {
      return await ref
          .read(membershipRepositoryPod)
          .getLinkupCodeType(linkupCode);
    } catch (error) {
      AppApiExceptionHandler.handleError(_className, error);
      rethrow;
    }
  }
}

///Calls the repository to link the membership.
@riverpod
final class LinkupMembershipPod extends _$LinkupMembershipPod {
  String get _className => 'LinkupMembershipPod';

  IMembershipRepository get _repository => ref.read(membershipRepositoryPod);

  @override
  Future<void> build({
    required String userId,
    required LinkupCodeType linkupCodeType,
    required String linkupCode,
  }) async {
    try {
      if (linkupCodeType == LinkupCodeType.community)
        return await _linkupMembershipToCommunity(userId, linkupCode);
      return await _linkupMembershipToFamilyGroup(userId, linkupCode);
    } catch (error) {
      AppApiExceptionHandler.handleError(_className, error);
      rethrow;
    }
  }

  Future<void> _linkupMembershipToCommunity(userId, linkupCode) async {
    final linkupModel =
        LinkupMembershipModel.community(userId: userId, linkupCode: linkupCode);
    return _repository.linkupMembershipToCommunity(linkupModel);
  }

  Future<void> _linkupMembershipToFamilyGroup(userId, linkupCode) async {
    final linkupModel =
        LinkupMembershipModel.group(userId: userId, invitationCode: linkupCode);
    return _repository.linkupMembershipToFamilyGroup(linkupModel);
  }
}
