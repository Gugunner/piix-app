import 'package:piix_mobile/claim_ticket_feature/data/repository/claim_ticket_imp.dart';
import 'package:piix_mobile/claim_ticket_feature/data/repository/claim_ticket_use_case_test.dart';
import 'package:piix_mobile/claim_ticket_feature/data/service/claim_ticket_api.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/model/claim_ticket_request.dart';

@Deprecated('Will be removed in 4.0')
enum ClaimTicketStateDeprecated {
  idle,
  notFound,
  retrieving,
  conflict,
  empty,
  error,
  unexpectedError,
  retrieveError,
  retrieved,
  cancelled,
  reported,
  closed,
  created,
}

enum ClaimTicketsResponseTypes { success, error, conflict, unexpectedError }

//TODO ADD DOCUMENTATION IN NEXT PR
class ClaimTicketRepository {
  ClaimTicketRepository(
    this.claimTicketApi,
  );
  final ClaimTicketApi claimTicketApi;

  Future<dynamic> getTicketHistoryByMembershipRequested({
    required String membershipId,
    bool test = false,
    bool useLoggers = true,
  }) async {
    if (test) {
      return getTicketHistoryRequestedTest(
        type: ClaimTicketsResponseTypes.success,
      );
    }
    return getTicketHistoryByMembershipRequestedImpl(
      membershipId,
      useLoggers,
    );
  }

  Future<dynamic> cancelClaimTicketRequested({
    required ClaimTicketRequest cancelRequest,
    bool test = false,
    bool useLoggers = true,
  }) async {
    if (test) {
      return cancelClaimTicketRequestedTest(
        type: ClaimTicketsResponseTypes.success,
      );
    }
    return cancelClaimTicketRequestedImpl(
      cancelRequest,
      useLoggers,
    );
  }

  Future<dynamic> closeClaimTicketRequested({
    required ClaimTicketRequest closeRequest,
    bool test = false,
    bool useLoggers = true,
  }) async {
    if (test) {
      return closeClaimTicketRequestedTest(
        type: ClaimTicketsResponseTypes.success,
      );
    }
    return closeClaimTicketRequestedImpl(
      closeRequest,
      useLoggers,
    );
  }

  Future<dynamic> reportClaimTicketProblemRequested({
    required ClaimTicketRequest reportRequest,
    bool test = false,
    bool useLoggers = true,
  }) async {
    if (test) {
      return reportClaimTicketProblemRequestedTest(
        type: ClaimTicketsResponseTypes.success,
      );
    }
    return reportClaimTicketProblemRequestedImpl(
      reportRequest,
      useLoggers,
    );
  }

  Future<dynamic> createClaimTicketRequested({
    required ClaimTicketRequest createRequest,
    bool test = false,
    bool useLoggers = true,
  }) async {
    if (test) {
      return createClaimTicketRequestedTest(
        type: ClaimTicketsResponseTypes.success,
      );
    }
    return createClaimTicketRequestedImpl(
      createRequest,
      useLoggers,
    );
  }
}
