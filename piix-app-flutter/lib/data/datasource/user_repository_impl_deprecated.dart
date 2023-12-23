import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/membership_model/membership_model_deprecated.dart';

@Deprecated('Will be removed in 4.0')

/// Here are all the implementations of the API calls for user info.
class UserRepositoryImplDeprecated {
  final appConfig = AppConfig.instance;

  ///Updates user email.
  Future<bool> updateUserEmail(
      {required String? currentEmail, required String newEmail}) async {
    final _data = {
      'currentEmail': currentEmail,
      'newEmail': newEmail,
    };
    try {
      final url = '${appConfig.backendEndpoint}/users/email/update';
      final response = await PiixApiDeprecated.put(path: url, data: _data);
      if (PiixApiDeprecated.checkStatusCode(statusCode: response.statusCode!)) {
        return true;
      }
      throw response.data;
    } catch (e) {
      rethrow;
    }
  }

  ///Updates user phone number.
  Future<bool> updateUserPhoneNumber(
      {required String userId,
      required String currentPhoneNumber,
      required String newPhoneNumber}) async {
    final _data = {
      'userId': userId,
      'currentPhoneNumber': currentPhoneNumber,
      'newPhoneNumber': newPhoneNumber
    };
    try {
      final url = '${appConfig.backendEndpoint}/users/phone/update';
      final response = await PiixApiDeprecated.put(
        path: url,
        data: _data,
      );
      if (PiixApiDeprecated.checkStatusCode(statusCode: response.statusCode!)) {
        return true;
      }
      throw response.data;
    } catch (e) {
      rethrow;
    }
  }

  //TODO: Delete after new Implementation
  /// Get new levels and plans for memberships.
  Future<List<MembershipModelDeprecated>> getNewLevelAndPlan() async {
    try {
      final _response = await PiixApiDeprecated.get(
          '${appConfig.backendEndpoint}/users/getPlanAndLevelForMemberships');

      if (PiixApiDeprecated.checkStatusCode(
          statusCode: _response.statusCode!)) {
        final List tempList = _response.data;
        final newMemberships = tempList
            .map((membership) => MembershipModelDeprecated.fromJson(membership))
            .toList();
        return newMemberships;
      }
      throw Exception(_response.data);
    } catch (_) {
      rethrow;
    }
  }
}
