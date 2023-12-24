import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_problem_model.freezed.dart';

part 'request_problem_model.g.dart';

///Use when requesting to report a problem
@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType'
)
class RequestProblemModel with _$RequestProblemModel {
  @JsonSerializable(explicitToJson: true)
  const RequestProblemModel._();

  factory RequestProblemModel({
    @JsonKey(required: true)
    required String ticketId,
    String? problemDescription,
  }) = _RequestProblemModel;

 
  factory RequestProblemModel.fromJson(Map<String, dynamic> json) =>
      _$RequestProblemModelFromJson(json);
}
