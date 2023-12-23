import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/utils/date_util.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/freezed_utils.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/cobenefit_form_information_model.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/membership_model/membership_level_model.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/membership_model/membership_plan_model.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/package_model_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/social_entity_model.dart';

part 'membership_model_deprecated.freezed.dart';
part 'membership_model_deprecated.g.dart';

@Deprecated('Will be removed in 4.0')
/// A membership of a user.
@Freezed(
    copyWith: true,
    fromJson: true,
    toJson: true,
    makeCollectionsUnmodifiable: false,
    unionKey: 'modelType')
class MembershipModelDeprecated with _$MembershipModelDeprecated {
  @JsonSerializable(explicitToJson: true)
  const MembershipModelDeprecated._();
  factory MembershipModelDeprecated({
    @JsonKey(required: true)
        required String membershipId,
    @JsonKey(required: true)
        required int mainSerialNumber,
    @JsonKey(required: true)
        required int additionalSerialNumber,
    @JsonKey(required: true)
        required String status,
    required PackageModel package,
    @JsonKey(required: true)
        required MembershipLevelModel usersMembershipLevel,
    @JsonKey(required: true)
        required List<MembershipPlanModel> usersMembershipPlans,
    @Default(false)
        bool isActive,
    @Default(false)
        bool isMainUser,
    @JsonKey(
      required: true,
      name: 'registerDate',
      fromJson: toDateTime,
    )
        required DateTime registerDate,
  }) = _MembershipModel;

  factory MembershipModelDeprecated.information({
    @JsonKey(required: true)
        required String membershipId,
    @JsonKey(required: true)
        required int mainSerialNumber,
    @JsonKey(required: true)
        required int additionalSerialNumber,
    @JsonKey(required: true)
        required String status,
    required PackageModel package,
    @JsonKey(required: true)
        required MembershipLevelModel usersMembershipLevel,
    @JsonKey(required: true)
        required List<MembershipPlanModel> usersMembershipPlans,
    @Default(false)
        bool isActive,
    @Default(false)
        bool isMainUser,
    @JsonKey(
      required: true,
      name: 'registerDate',
      fromJson: toDateTime,
    )
        required DateTime registerDate,
    @JsonKey(required: true)
        required String folio,
    @JsonKey(required: true)
        required String clientId,
    @JsonKey(required: true)
        required String name,
    @JsonKey(required: true)
        required String claimPhoneNumber,
    @JsonKey(required: true)
        required String claimChatNumber,
    @JsonKey(required: true)
        required DateTime fromDate,
    @JsonKey(required: true)
        required DateTime toDate,
    @JsonKey(required: true)
        required int maxProtectedPerMain,
    @JsonKey(required: true)
        required int maxAgeCompliance,
    @JsonKey(required: true)
        required String clientName,
    @JsonKey(required: true, readValue: addDefaultType)
        required List<BenefitPerSupplierModel> benefitsPerSupplier,
    @JsonKey(required: true)
        required String kinshipId,
    @JsonKey(required: true)
        required String kinshipName,
    @Default(false)
        bool packageIsActive,
    @JsonKey(name: 'activeEcommerce')
    @Default(false)
        bool activeStore,
    ClientModel? client,
    List<IntermediaryModel>? intermediaries,
    @JsonKey(name: 'cobenefitsBenefitFormsInformation')
        List<CobenefitFormInformationModel>? cobenefitFormsInformation,
  }) = _MembershipInformationModel;

  factory MembershipModelDeprecated.fromJson(Map<String, dynamic> json) =>
      _$MembershipModelDeprecatedFromJson(json);

  MembershipModelDeprecated blendMembership(Map<String, dynamic> json) {
    final blendedJson = toJson();
    json.addEntries(blendedJson.entries);
    json['modelType'] = 'information';
    return MembershipModelDeprecated.fromJson(json);
  }

  String get folio => map(
        (value) => '',
        information: (value) => value.folio,
      );

  String get clientId => map(
        (value) => '',
        information: (value) => clientId,
      );

  String get name => map(
        (value) => '',
        information: (value) => value.name,
      );

  String get claimPhoneNumber => map(
        (value) => '',
        information: (value) => value.claimPhoneNumber,
      );

  String get claimChatNumber => map(
        (value) => '',
        information: (value) => value.claimChatNumber,
      );

  DateTime? get fromDate => mapOrNull(
        (value) => null,
        information: (value) => value.fromDate,
      );

  DateTime? get toDate => mapOrNull(
        (value) => null,
        information: (value) => value.toDate,
      );

  int get maxProtectedPerMain => map(
        (value) => 0,
        information: (value) => value.maxProtectedPerMain,
      );

  int get maxAgeCompliance => map(
        (value) => 0,
        information: (value) => value.maxAgeCompliance,
      );

  String get clientName => map(
        (value) => '',
        information: (value) => value.clientName,
      );

  List<BenefitPerSupplierModel> get benefitsPerSupplier => map(
        (value) => [],
        information: (value) => value.benefitsPerSupplier,
      );

  String get kinshipId => map(
        (value) => '',
        information: (value) => value.kinshipId,
      );

  String get kinshipName => map(
        (value) => '',
        information: (value) => value.kinshipName,
      );

  bool get packageIsActive => map(
        (value) => false,
        information: (value) => value.packageIsActive,
      );

  bool get activeStore => map(
        (value) => false,
        information: (value) => value.activeStore,
      );

  ClientModel? get client => mapOrNull(
        (value) => null,
        information: (value) => value.client,
      );

  List<IntermediaryModel>? get intermediaries => mapOrNull(
        (value) => null,
        information: (value) => value.intermediaries,
      );

  List<CobenefitFormInformationModel>? get cobenefitFormsInformation =>
      mapOrNull(
        (value) => null,
        information: (value) => value.cobenefitFormsInformation,
      );
}
