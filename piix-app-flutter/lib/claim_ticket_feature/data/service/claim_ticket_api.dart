import 'package:dio/dio.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/model/claim_ticket_request.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/utils/endpoints.dart';

//TODO ADD DOCUMENTATION IN NEXT PR
class ClaimTicketApi {
  ///This is a request to cancel ticket
  ///
  Future<Response> cancelClaimTicket({
    required ClaimTicketRequest cancelRequest,
  }) async {
    try {
      final path = EndPoints.cancelClaimTicket;
      final response = await PiixApiDeprecated.put(
        data: cancelRequest.toJson(),
        path: path,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  ///This is a request to close ticket
  ///
  Future<Response> closeClaimTicket({
    required ClaimTicketRequest closeRequest,
  }) async {
    try {
      final path = EndPoints.closeClaimTicket;
      final response = await PiixApiDeprecated.put(
        data: closeRequest.toJson(),
        path: path,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  ///This is a request to report problem
  ///
  Future<Response> reportClaimTicketProblem({
    required ClaimTicketRequest reportRequest,
  }) async {
    try {
      final path = EndPoints.reportClaimTicketProblem;
      final response = await PiixApiDeprecated.put(
        data: reportRequest.toJson(),
        path: path,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  ///This is a request to create ticket
  ///
  Future<Response> createClaimTicket({
    required ClaimTicketRequest createRequest,
  }) async {
    try {
      final path = EndPoints.createClaimTicket;
      final response = await PiixApiDeprecated.post(
        data: createRequest.toJson(),
        path: path,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getTicketHistoryByMembership(String membershipId) async {
    try {
      final path = '${EndPoints.getTicketHistory}membershipId='
          '${membershipId}';
      final response = await PiixApiDeprecated.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
