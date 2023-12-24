import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/form_feature/form_model_barrel_file.dart';

part 'response_form_model.freezed.dart';
part 'response_form_model.g.dart';

@Freezed(
  copyWith: true,
  fromJson: false,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType',
)
class ResponseFormModel with _$ResponseFormModel {
  @JsonSerializable(explicitToJson: true)
  const ResponseFormModel._();

  factory ResponseFormModel({
    required String mainUserInfoFormId,
    required String userId,
    required List<AnswerModel> answers,
    required FormType formType,
    String? userMainFormId,
  }) = _ResponseFormModel;

  ///Add [userMainFormId] before converting it [toJson].
  Map<String, dynamic> toCustomJson() {
    final jsonResponseForm = copyWith(
      userMainFormId: '${userId}_${mainUserInfoFormId}_${formType.name}',
    ).toJson();
    final answerLength = answers.length;
    for (var i = 0; i < answerLength; i++) {
      jsonResponseForm['answers'][i].remove('modelType');
    }
    return jsonResponseForm;
  }
}

enum FormType {
  INDIVIDUAL_REGISTRY,
  ADDITIONAL_USER_ADULT,
  ADDITIONAL_USER_UNDERAGE,
}
