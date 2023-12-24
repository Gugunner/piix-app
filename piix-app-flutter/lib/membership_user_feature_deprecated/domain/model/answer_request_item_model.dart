import 'package:json_annotation/json_annotation.dart';

part 'answer_request_item_model.g.dart';

/// This model is created for answer request item on the benefit form.
@JsonSerializable()
class AnswerRequestItemModel {
  const AnswerRequestItemModel({
    required this.formFieldId,
    required this.dataTypeId,
    required this.name,
    required this.answer,
    this.isOtherOption = false,
    this.csvAnswer,
  });

  @JsonKey(required: true)
  final String formFieldId;
  @JsonKey(required: true)
  final String dataTypeId;
  @JsonKey(required: true)
  final String name;
  @JsonKey(required: true)
  final dynamic answer;
  final bool isOtherOption;
  @JsonKey(includeFromJson: false)
  final dynamic csvAnswer;

  factory AnswerRequestItemModel.fromJson(Map<String, dynamic> json) =>
      _$AnswerRequestItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerRequestItemModelToJson(this);

  AnswerRequestItemModel copyWith({
    String? id,
    String? dataTypeId,
    String? name,
    answer,
  }) {
    return AnswerRequestItemModel(
      formFieldId: id ?? formFieldId,
      dataTypeId: dataTypeId ?? this.dataTypeId,
      name: name ?? this.name,
      answer: answer ?? this.answer,
    );
  }
}
