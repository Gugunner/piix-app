import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/domain/repository/protected_repository_interface.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/model/available_protected_slots_model/available_protected_slots_model.dart';

///Here are all the implementations of the api calls for protecteds.
class ProtectedRepositoryImpl extends ProtectedRepositoryInterface {
  final appConfig = AppConfig.instance;

  ///Validates correct StatusCodes,
  ///Get all protecteds and slots by membershipId and planId
  ///Args
  ///[membershipId],[planId]
  @override
  Future<AvailableProtectedSlotsModel> getProtectedAndSlotsByMembershipId(
      {required String membershipId}) async {
    try {
      final _response = await PiixApiDeprecated.get(
          '${appConfig.backendEndpoint}/protected/slots/byMembership?membershipId=$membershipId');
      if (PiixApiDeprecated.checkStatusCode(
          statusCode: _response.statusCode!)) {
        return AvailableProtectedSlotsModel.fromJson(_response.data);
      }
      throw Exception(_response.data);
    } catch (e) {
      rethrow;
    }
  }
}
