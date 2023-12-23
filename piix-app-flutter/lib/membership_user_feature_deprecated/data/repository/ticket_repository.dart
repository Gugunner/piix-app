import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/ticket_repository_impl.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/ticket_repository_use_case_test.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/service/ticket_api.dart';
import 'package:piix_mobile/general_app_feature/utils/app_use_case_test.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/ticket_model/request_ticket_history_model.dart';

enum TicketState {
  idle,
  retrieving,
  retrieved,
  sending,
  sent,
  cancelling,
  cancelled,
  closing,
  closed,
  creating,
  created,
  retrieveError,
  sendError,
  empty,
  error,
}

///Handles calling fake or real implementations for all services related to support tickets
class TicketRepository {
  TicketRepository(this.ticketApi);

  final TicketApi ticketApi;
  final _appTest = getIt<AppUseCaseTestFlag>().test;

  Future<dynamic> getTicketHistoryRequested(
      RequestTicketHistoryModel historyModel) async {
    if (_appTest) {
      return getTicketHistoryRequestedTest(historyModel);
    }
    return getTicketHistoryRequestedImpl(historyModel);
  }
}
