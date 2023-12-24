import 'package:json_annotation/json_annotation.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/answer_request_item_model.dart';

part 'benefit_form_model.g.dart';

@JsonSerializable()
class RequestBenefitFormModel {
  RequestBenefitFormModel({
    required this.benefitFormId,
    this.cobenefitPerSupplierId,
    this.benefitPerSupplierId,
    this.additionalBenefitPerSupplierId,
  });

  final String benefitFormId;
  final String? cobenefitPerSupplierId;
  final String? benefitPerSupplierId;
  final String? additionalBenefitPerSupplierId;

  factory RequestBenefitFormModel.fromJson(Map<String, dynamic> json) =>
      _$RequestBenefitFormModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestBenefitFormModelToJson(this);

  RequestBenefitFormModel copyWith({
    String? benefitFormId,
  }) =>
      RequestBenefitFormModel(
          benefitFormId: benefitFormId ?? this.benefitFormId);
}

@JsonSerializable()
class BenefitFormAnswerModel {
  const BenefitFormAnswerModel({
    required this.userId,
    required this.benefitFormId,
    required this.packageId,
    required this.answers,
    this.benefitPerSupplierId,
    this.cobenefitPerSupplierId,
    this.additionalBenefitPerSupplierId,
  });

  final String userId;
  final String benefitFormId;
  final String packageId;
  final List<AnswerRequestItemModel> answers;
  final String? benefitPerSupplierId;
  final String? cobenefitPerSupplierId;
  final String? additionalBenefitPerSupplierId;

  factory BenefitFormAnswerModel.fromJson(Map<String, dynamic> json) =>
      _$BenefitFormAnswerModelFromJson(json);

  Map<String, dynamic> toJson() => _$BenefitFormAnswerModelToJson(this);
}
