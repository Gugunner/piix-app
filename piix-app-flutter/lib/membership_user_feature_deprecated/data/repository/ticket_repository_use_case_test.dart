// ignore_for_file: prefer_single_quotes

import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/ticket_repository.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/ticket_model/request_ticket_history_model.dart';

///Handles fake api service implementation calls for support tickets
extension TicketRepositoryUseCaseTest on TicketRepository {
  Future<dynamic> getTicketHistoryRequestedTest(
      RequestTicketHistoryModel historyModel) async {
    return Future.delayed(const Duration(seconds: 2), () {
      //TODO: Add error case
      return {
        'tickets': fakeJsonTickets(),
        'state': TicketState.retrieved,
      };
    });
  }

  List<dynamic> fakeJsonTickets() => [
        {
          "ticketId": "piix_20220616_1542",
          "benefitPerSupplierId": "CNOC-2022-01-AOPS111000-000",
          "status": "user_closed",
          "closedDate": "2022-06-16T15:43:53.000Z",
          "registerDate": "2022-06-16T15:42:57.000Z",
          "updateDate": "2022-06-16T15:43:53.000Z",
          "rating": {
            "benefitPerSupplierRating": 3,
            "supplierRating": 3.5,
            "comments": "el tiempo de respuesta fue muy lento",
            "registerDate": "2022-06-16T15:43:53.000Z"
          },
          "benefitName": "Asistencia Legal Telefónica",
          "supplierName": "Seguros Argos S.A de C.V"
        },
        {
          "ticketId": "piix_20220616_1606",
          "benefitPerSupplierId": "CNOC-2022-01-AOPS111000-000",
          "status": "user_closed",
          "closedDate": "2022-06-16T16:08:50.000Z",
          "registerDate": "2022-06-16T16:06:52.000Z",
          "updateDate": "2022-06-16T16:08:50.000Z",
          "rating": {
            "benefitPerSupplierRating": 5,
            "supplierRating": 4.5,
            "comments": "Muy buena atención",
            "registerDate": "2022-06-16T16:08:50.000Z"
          },
          "benefitName": "Asistencia Legal Telefónica",
          "supplierName": "Seguros Argos S.A de C.V"
        },
        {
          "ticketId": "piix_20220616_1619",
          "benefitPerSupplierId": "CNOC-2022-01-AOPS111000-000",
          "status": "system_alert_one",
          "registerDate": "2022-06-16T16:19:20.000Z",
          "updateDate": "2022-06-16T17:55:25.000Z",
          "benefitName": "Asistencia Legal Telefónica",
          "supplierName": "Seguros Argos S.A de C.V"
        },
        {
          "ticketId": "piix_20220616_1718",
          "benefitPerSupplierId": "CNOC-2022-01-AOPS111000-000",
          "status": "user_closed",
          "closedDate": "2022-06-20T21:30:34.000Z",
          "registerDate": "2022-06-16T17:18:55.000Z",
          "updateDate": "2022-06-20T21:30:34.000Z",
          "benefitName": "Asistencia Legal Telefónica",
          "supplierName": "Seguros Argos S.A de C.V"
        },
        {
          "ticketId": "piix_20220616_1721",
          "status": "user_closed",
          "closedDate": "2022-06-20T19:23:11.000Z",
          "registerDate": "2022-06-16T17:21:16.000Z",
          "updateDate": "2022-06-20T19:23:11.000Z"
        },
        {
          "ticketId": "piix_20220621_1556",
          "benefitPerSupplierId": "CNOC-2022-01-AOPS211000-000",
          "cobenefitPerSupplierId": "CNOC-2022-01-AOPS211000-003",
          "status": "user_canceled",
          "registerDate": "2022-06-21T15:56:19.000Z",
          "updateDate": "2022-06-21T17:01:09.000Z",
          "rating": {
            "comments": "",
            "registerDate": "2022-06-21T17:01:09.000Z"
          },
          "benefitName": "Asistencia en el Hogar",
          "supplierName": "Seguros Argos S.A de C.V"
        },
        {
          "ticketId": "piix_20220621_2242",
          "benefitPerSupplierId": "CNOC-2022-01-AOPS211000-000",
          "cobenefitPerSupplierId": "CNOC-2022-01-AOPS211000-002",
          "status": "system_alert_one",
          "registerDate": "2022-06-21T22:42:47.000Z",
          "benefitName": "Asistencia en el Hogar",
          "supplierName": "Seguros Argos S.A de C.V"
        },
        {
          "ticketId": "piix_20220812_2250",
          "status": "user_generated",
          "registerDate": "2022-08-12T22:50:49.000Z"
        }
      ];
}
