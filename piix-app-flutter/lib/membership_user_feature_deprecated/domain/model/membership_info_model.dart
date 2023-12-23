import 'package:json_annotation/json_annotation.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/freezed_utils.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/social_entity_model.dart';

part 'membership_info_model.g.dart';

///This stores all the information pertaining a specific membership
@JsonSerializable()
class MembershipInfoModel {
  const MembershipInfoModel({
    required this.folio,
    required this.clientId,
    required this.name,
    required this.claimPhoneNumber,
    required this.claimChatNumber,
    required this.fromDate,
    required this.toDate,
    required this.maxProtectedPerMain,
    required this.maxAgeCompliance,
    required this.registerDate,
    required this.clientName,
    required this.benefitsPerSupplier,
    required this.kinshipId,
    required this.kinshipName,
    this.packageIsActive = false,
    this.activeStore = false,
    this.client,
    this.intermediaries,
  });

  @JsonKey(required: true)
  final String folio;
  @JsonKey(required: true)
  final String clientId;
  @JsonKey(required: true)
  final String name;
  @JsonKey(required: true)
  final String claimPhoneNumber;
  @JsonKey(required: true)
  final String claimChatNumber;
  @JsonKey(required: true)
  final DateTime fromDate;
  @JsonKey(required: true)
  final DateTime toDate;
  @JsonKey(required: true)
  final int maxProtectedPerMain;
  @JsonKey(required: true)
  final int maxAgeCompliance;
  @JsonKey(required: true)
  final DateTime registerDate;
  @JsonKey(required: true)
  final String clientName;
  @JsonKey(required: true, readValue: addDefaultType)
  final List<BenefitPerSupplierModel> benefitsPerSupplier;
  @JsonKey(required: true)
  final String kinshipId;
  @JsonKey(required: true)
  final String kinshipName;
  final bool packageIsActive;
  @JsonKey(name: 'activeEcommerce')
  final bool activeStore;
  //Fields use to create CSV files for data
  final ClientModel? client;
  final List<IntermediaryModel>? intermediaries;

  factory MembershipInfoModel.fromJson(Map<String, dynamic> json) {
    return _$MembershipInfoModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MembershipInfoModelToJson(this);

  ///Returns a new copy of this that can include [client] and/or a list of [intermediaries]
  MembershipInfoModel additionalInfo(Map<String, dynamic> json) {
    return copyWith(
      client: json['client'] == null
          ? null
          : ClientModel.fromJson(json['client'] as Map<String, dynamic>),
      intermediaries: (json['intermediaries'] as List<dynamic>?)
          ?.map((e) => IntermediaryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  MembershipInfoModel copyWith({
    String? folio,
    String? clientId,
    String? name,
    String? claimPhoneNumber,
    String? claimChatNumber,
    DateTime? fromDate,
    DateTime? toDate,
    int? maxProtectedPerMain,
    int? maxAgeCompliance,
    bool? packageIsActive,
    bool? activeStore,
    DateTime? registerDate,
    String? clientName,
    List<BenefitPerSupplierModel>? benefitsPerSupplier,
    String? kinshipId,
    String? kinshipName,
    //Fields use to create CSV
    ClientModel? client,
    List<IntermediaryModel>? intermediaries,
  }) {
    return MembershipInfoModel(
      folio: folio ?? this.folio,
      clientId: clientId ?? this.clientId,
      name: name ?? this.name,
      claimPhoneNumber: claimPhoneNumber ?? this.claimPhoneNumber,
      claimChatNumber: claimChatNumber ?? this.claimChatNumber,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      maxProtectedPerMain: maxProtectedPerMain ?? this.maxProtectedPerMain,
      maxAgeCompliance: maxAgeCompliance ?? this.maxAgeCompliance,
      packageIsActive: packageIsActive ?? this.packageIsActive,
      activeStore: activeStore ?? this.activeStore,
      registerDate: registerDate ?? this.registerDate,
      clientName: clientName ?? this.clientName,
      benefitsPerSupplier: benefitsPerSupplier ?? this.benefitsPerSupplier,
      kinshipId: kinshipId ?? this.kinshipId,
      kinshipName: kinshipName ?? this.kinshipName,
      client: client ?? this.client,
      intermediaries: intermediaries ?? this.intermediaries,
    );
  }
}

///Use this model when requesting data form the api to create an instance
///of [MembershipInfoModel].
@JsonSerializable()
class RequestMembershipInfoModel {
  const RequestMembershipInfoModel({
    this.membershipId = '',
    this.packageId,
  });

  final String membershipId;
  final String? packageId;

  factory RequestMembershipInfoModel.fromJson(Map<String, dynamic> json) =>
      _$RequestMembershipInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestMembershipInfoModelToJson(this);

  RequestMembershipInfoModel copyWith({
    String? membershipId,
    String? packageId,
  }) =>
      RequestMembershipInfoModel(
          membershipId: membershipId ?? this.membershipId,
          packageId: packageId ?? this.packageId);
}
