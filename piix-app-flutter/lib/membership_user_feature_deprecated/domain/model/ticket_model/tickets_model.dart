import 'package:json_annotation/json_annotation.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/model/ticket_model.dart';

part 'tickets_model.g.dart';

///Handles the encapsulation of all tickets logic by [TicketStatus]
@JsonSerializable()
class TicketsModel {
  TicketsModel({
    required this.tickets,
  });

  TicketsModel.notificationTicket({
    required List<TicketModel> tickets,
  }) : tickets = tickets.where((ticket) => ticket.showNotification).toList();

  TicketsModel.userGenerated({
    required List<TicketModel> tickets,
  }) : tickets = tickets
            .where((ticket) => ticket.status == TicketStatus.user_generated)
            .toList();

  TicketsModel.userClosed({
    required List<TicketModel> tickets,
  }) : tickets = tickets
            .where((ticket) => ticket.status == TicketStatus.user_closed)
            .toList();

  TicketsModel.userCanceled({
    required List<TicketModel> tickets,
  }) : tickets = tickets
            .where((ticket) => ticket.status == TicketStatus.user_canceled)
            .toList();

  TicketsModel.userSupported({
    required List<TicketModel> tickets,
  }) : tickets = tickets
            .where((ticket) => ticket.status == TicketStatus.user_support)
            .toList();

  @JsonKey(required: true)
  List<TicketModel> tickets;

  factory TicketsModel.fromJson(Map<String, dynamic> json) =>
      _$TicketsModelFromJson(json);

  TicketsModel copyWith({
    List<TicketModel>? tickets,
  }) =>
      TicketsModel(tickets: tickets ?? this.tickets);
}
