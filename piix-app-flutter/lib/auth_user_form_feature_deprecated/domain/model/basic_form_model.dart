import 'package:json_annotation/json_annotation.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/answer_request_item_model.dart';

part 'basic_form_model.g.dart';

@Deprecated('No longer in user substituted with PersonalInformationForm')
@JsonSerializable()
class RequestBasicFormModel {
  RequestBasicFormModel({
    required this.userId,
    required this.mainUserInfoFormId,
  });

  final String userId;
  final String mainUserInfoFormId;

  factory RequestBasicFormModel.fromJson(Map<String, dynamic> json) =>
      _$RequestBasicFormModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestBasicFormModelToJson(this);

  RequestBasicFormModel copyWith({
    String? userId,
    String? packageId,
    String? mainUserInfoFormId,
  }) {
    return RequestBasicFormModel(
      userId: userId ?? this.userId,
      mainUserInfoFormId: mainUserInfoFormId ?? this.mainUserInfoFormId,
    );
  }
}

/// This model is for the body of the update basic form data request.
@JsonSerializable()
class BasicFormAnswerModel {
  const BasicFormAnswerModel({
    required this.userId,
    required this.mainUserInfoFormId,
    required this.answers,
    this.packageId,
  });

  final String userId;
  final String mainUserInfoFormId;
  @JsonKey(
    toJson: answersToJson,
  )
  final List<AnswerRequestItemModel> answers;
  final String? packageId;

  factory BasicFormAnswerModel.fromJson(Map<String, dynamic> json) =>
      _$BasicFormAnswerModelFromJson(json);

  static List<Map<String, dynamic>> answersToJson(
          List<AnswerRequestItemModel> answers) =>
      answers.map((answer) => answer.toJson()).toList();

  Map<String, dynamic> toJson() {
    final json = _$BasicFormAnswerModelToJson(this);
    json['userMainFormId'] = '${userId}_${mainUserInfoFormId}';
    return json;
  }

  BasicFormAnswerModel copyWith({
    String? userId,
    String? formId,
    String? mainUserInfoFormId,
    String? userMainFormId,
    List<AnswerRequestItemModel>? answers,
    String? packageId,
  }) {
    return BasicFormAnswerModel(
      userId: userId ?? this.userId,
      mainUserInfoFormId: mainUserInfoFormId ?? this.mainUserInfoFormId,
      answers: answers ?? this.answers,
      packageId: packageId ?? this.packageId,
    );
  }
}

@JsonSerializable()
class BasicFormProtectedAnswerModel {
  const BasicFormProtectedAnswerModel({
    required this.userId,
    required this.mainUserInfoFormId,
    required this.packageId,
    required this.answers,
  });

  final String userId;
  final String mainUserInfoFormId;
  final String packageId;

  @JsonKey(
    toJson: answersToJson,
  )
  final List<AnswerRequestItemModel> answers;

  factory BasicFormProtectedAnswerModel.fromJson(Map<String, dynamic> json) =>
      _$BasicFormProtectedAnswerModelFromJson(json);

  static List<Map<String, dynamic>> answersToJson(
          List<AnswerRequestItemModel> answers) =>
      answers.map((answer) => answer.toJson()).toList();

  Map<String, dynamic> toJson() {
    final json = _$BasicFormProtectedAnswerModelToJson(this);
    json['userMainFormId'] = '${userId}_${mainUserInfoFormId}';
    return json;
  }

  BasicFormProtectedAnswerModel copyWith({
    String? userId,
    String? formId,
    String? mainUserInfoFormId,
    String? userMainFormId,
    List<AnswerRequestItemModel>? answers,
    String? packageId,
  }) {
    return BasicFormProtectedAnswerModel(
      userId: userId ?? this.userId,
      mainUserInfoFormId: mainUserInfoFormId ?? this.mainUserInfoFormId,
      packageId: packageId ?? this.packageId,
      answers: answers ?? this.answers,
    );
  }
}
