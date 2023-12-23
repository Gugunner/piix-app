import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/map_json_extension.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';

part 'pending_benefit_form_notification_model.freezed.dart';
part 'pending_benefit_form_notification_model.g.dart';

@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  unionKey: 'modelType',
)
class PendingBenefitFormNotificationModel
    with _$PendingBenefitFormNotificationModel {
       @JsonSerializable(explicitToJson: true)
  const PendingBenefitFormNotificationModel._();

  factory PendingBenefitFormNotificationModel({
    @JsonKey(required: true)
    required String benefitName,
    @JsonKey(required: true)
    required String benefitFormId,
  }) = _PendingBenefitFormNotificationModel;

  factory PendingBenefitFormNotificationModel.benefitPerSupplier({
    @JsonKey(required: true)
    required String benefitName,
    @JsonKey(required: true)
    required String benefitFormId,
    @JsonKey(required: true)
    required String benefitPerSupplierId,
  }) = __PendingBenefitPerSupplierFormNotificationModel;

  factory PendingBenefitFormNotificationModel.cobenefitPerSupplier({
    @JsonKey(required: true)
    required String benefitName,
    @JsonKey(required: true)
    required String benefitFormId,
    @JsonKey(required: true)
    required String cobenefitPerSupplierId,
    @JsonKey(required: true)
    required String relatedBenefitPerSupplierId,
  }) = _PendingCobenefitPerSupplierFormNotificationModel;

  factory PendingBenefitFormNotificationModel.additionalBenefitPerSupplier({
    @JsonKey(required: true)
    required String benefitName,
    @JsonKey(required: true)
    required String benefitFormId,
    @JsonKey(required: true)
    required String additionalBenefitPerSupplierId,
    //TODO: Change to required if the changes of parent are decided
    String? relatedComboBenefitPerSupplierId,
  }) = _PendingAdditionalBenefitPerSupplierFormNotificationModel;

  factory PendingBenefitFormNotificationModel.comboBenefitPerSupplier({
    @JsonKey(required: true)
    required String benefitName,
    @JsonKey(required: true)
    required String benefitFormId,
    @JsonKey(required: true)
    required String comboBenefitPerSupplierId,
  }) = _PendingComboBenefitPerSupplierFormNotificationModel;

  ///Checks each possible id and changes the [modelType] to the
  ///one that best reflect the type of benefit per supplier.
  ///
  ///If no match is found it keeps the original [modelType].
  ///
  ///This method modifies the [json].
  static void _assignModelType(Map<String, dynamic> json) {
    final benefitPerSupplierId = json['benefitPerSupplierId'];
    final cobenefitPerSupplierId = json['cobenefitPerSupplierId'];
    final comboBenefitPerSupplierId = json['comboBenefitPerSupplierId'];
    final additionalBenefitPerSupplierId =
        json['additionalBenefitPerSupplierId'];
    String? modelType;
    if (json.isNoEmptyValue<String?>(comboBenefitPerSupplierId)) {
      modelType = 'comboBenefitPerSupplier';
    } else if (json.isNoEmptyValue<String?>(benefitPerSupplierId)) {
      modelType = 'benefitPerSupplier';
    } else if (json.isNoEmptyValue<String?>(additionalBenefitPerSupplierId)) {
      modelType = 'additionalBenefitPerSupplier';
    } else if (json.isNoEmptyValue<String?>(cobenefitPerSupplierId)) {
      modelType = 'cobenefitPerSupplier';
    }
    if (modelType.isNotNullEmpty) json['modelType'] = modelType;
  }

  factory PendingBenefitFormNotificationModel.fromJson(
      Map<String, dynamic> json) {
    _assignModelType(json);
    return _$PendingBenefitFormNotificationModelFromJson(json);
  }

  String get benefitPerSupplierId => maybeMap(
        (value) => value.benefitPerSupplierId,
        benefitPerSupplier: (value) => value.benefitPerSupplierId,
        orElse: () => '',
      );

  String get cobenefitPerSupplierId => maybeMap(
        (value) => value.cobenefitPerSupplierId,
        cobenefitPerSupplier: (value) => value.cobenefitPerSupplierId,
        orElse: () => '',
      );

  String get comboBenefitPerSupplierId => maybeMap(
        (value) => value.comboBenefitPerSupplierId,
        comboBenefitPerSupplier: (value) => value.comboBenefitPerSupplierId,
        orElse: () => '',
      );

  String get additionalBenefitPerSupplierId => maybeMap(
        (value) => value.additionalBenefitPerSupplierId,
        additionalBenefitPerSupplier: (value) =>
            value.additionalBenefitPerSupplierId,
        orElse: () => '',
      );

  String get relatedBenefitPerSupplierId => maybeMap(
        (value) => value.relatedBenefitPerSupplierId,
        cobenefitPerSupplier: (value) => value.relatedBenefitPerSupplierId,
        orElse: () => '',
      );

  String? get relatedComboBenefitPerSupplierId => maybeMap(
        (value) => value.relatedComboBenefitPerSupplierId,
        additionalBenefitPerSupplier: (value) =>
            value.relatedComboBenefitPerSupplierId ?? '',
        orElse: () => '',
      );
}
