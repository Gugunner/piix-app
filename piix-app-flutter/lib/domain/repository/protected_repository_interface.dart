import 'package:piix_mobile/protected_feature_deprecated/domain/model/available_protected_slots_model/available_protected_slots_model.dart';

/// Class to define [ProtectedRepositoryInterface] protected functions
abstract class ProtectedRepositoryInterface {
  ///This is a interfece for a get all protected list request.
  Future<AvailableProtectedSlotsModel> getProtectedAndSlotsByMembershipId(
      {required String membershipId});
}
