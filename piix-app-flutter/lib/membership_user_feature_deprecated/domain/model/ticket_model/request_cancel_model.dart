import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_cancel_model.freezed.dart';

part 'request_cancel_model.g.dart';

///Use when requesting to cancel a ticket
@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType'
)
class RequestCancelModel with _$RequestCancelModel {
  @JsonSerializable(explicitToJson: true)
  const RequestCancelModel._();
  factory RequestCancelModel({
    @JsonKey(required: true)
    required String ticketId,
    String? cancellationReason,
  }) = _RequestCancelModel;

  factory RequestCancelModel.fromJson(Map<String, dynamic> json) =>
      _$RequestCancelModelFromJson(json);

}
