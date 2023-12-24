import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_ticket_history_model.freezed.dart';

part 'request_ticket_history_model.g.dart';

///Use when requesting ticket history
@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType'
)
class RequestTicketHistoryModel with _$RequestTicketHistoryModel {
  @JsonSerializable(explicitToJson: true)
  const RequestTicketHistoryModel._();
  factory RequestTicketHistoryModel({
    @JsonKey(required: true) required String userId,
    @JsonKey(required: true) required String membershipId,
  }) = _RequestTicketHistoryModel;

  factory RequestTicketHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$RequestTicketHistoryModelFromJson(json);
}
