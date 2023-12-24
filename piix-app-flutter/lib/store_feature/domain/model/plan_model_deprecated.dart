import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_model_deprecated.freezed.dart';

part 'plan_model_deprecated.g.dart';

@Deprecated('Will be removed in 4.0')

///This stores all the information pertaining a specific plan
///
@Freezed(
    copyWith: true,
    fromJson: true,
    toJson: true,
    makeCollectionsUnmodifiable: false,
    unionKey: 'modelType')
class PlanModel with _$PlanModel {
  const PlanModel._();

  factory PlanModel({
    @JsonKey(required: true) required String planId,
    @JsonKey(required: true) required String folio,
    @JsonKey(required: true) required String name,
    @JsonKey(required: true) required String pseudonym,
    @JsonKey(required: true) required int maxUsersInPlan,
    @JsonKey(required: true) required String kinshipId,
    @JsonKey(required: true) required DateTime registerDate,
    @JsonKey(required: true) required int protectedAcquired,
  }) = _PlanModel;

  factory PlanModel.purchased({
    @JsonKey(required: true) required String planId,
    @JsonKey(required: true) required String folio,
    @JsonKey(required: true) required String name,
  }) = _PlanPurchasedModel;

  factory PlanModel.fromJson(Map<String, dynamic> json) =>
      _$PlanModelFromJson(json);

  String get pseudonym => maybeMap(
        (value) => value.pseudonym,
        orElse: () => '',
      );

  int get maxUsersInPlan => maybeMap(
        (value) => value.maxUsersInPlan,
        orElse: () => 0,
      );

  String get kinshipId => maybeMap(
        (value) => value.kinshipId,
        orElse: () => '',
      );

  DateTime get registerDate => maybeMap(
        (value) => value.registerDate,
        orElse: () => DateTime.now(),
      );

  int get protectedAcquired => maybeMap(
        (value) => value.protectedAcquired,
        orElse: () => 0,
      );
}
