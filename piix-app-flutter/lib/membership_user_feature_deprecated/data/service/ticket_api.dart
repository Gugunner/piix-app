import 'package:dio/dio.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/ticket_model/request_ticket_history_model.dart';

class TicketApi {
  final appConfig = AppConfig.instance;
  Future<Response> getTicketHistoryApi(
      RequestTicketHistoryModel historyModel) async {
    try {
      final path =
          '${appConfig.backendEndpoint}/user/membership/ticket/history?userId=${historyModel.userId}'
          '&membershipId=${historyModel.membershipId}';
      final response = await PiixApiDeprecated.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
