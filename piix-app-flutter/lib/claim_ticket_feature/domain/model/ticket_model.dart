import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/freezed_utils.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/ticket_model/rating_model.dart';

part 'ticket_model.freezed.dart';

part 'ticket_model.g.dart';


enum TicketStatus {
  user_support,
  system_support,
  user_generated,
  system_generated,
  user_alert_one,
  system_alert_one,
  user_closed,
  system_closed,
  user_canceled,
  system_canceled,
  unknown,
}

/// This class is used to define all tickets properties.
@Freezed(
    copyWith: true,
    fromJson: true,
    toJson: true,
    makeCollectionsUnmodifiable: false,
    unionKey: 'modelType')
class TicketModel with _$TicketModel implements Comparable<TicketModel> {
  const TicketModel._();

  factory TicketModel({
    @JsonKey(required: true) required String ticketId,
    @JsonKey(required: true, fromJson: fromTicketStringStatus)
        required TicketStatus status,
    @JsonKey(required: true) required DateTime registerDate,
    @Default(false) bool showNotification,
    @Default('') String userId,
    @Default('') String membershipId,
    DateTime? closedDate,
    @Default('') String benefitPerSupplierId,
    DateTime? updateDate,
    DateTime? cancelDate,
    RatingModel? rating,
    @Default('') String benefitName,
    @Default('') String cobenefitName,
    @Default('') String supplierName,
    @Default('') String supplierId,
    @Default('') String cobenefitPerSupplierId,
    @Default('') String additionalBenefitPerSupplierId,
    @JsonKey(ignore: true) @Default(0.0) double benefitRatingValue,
    @JsonKey(ignore: true) @Default(0.0) double supplierRatingValue,
    @Default('') String claimName,
    @Default('') String benefitClaimId,
  }) = _TicketModel;

  static String addTicketIdToRating(Map<String, dynamic> json) {
    return json['ticketId'];
  }

  static String? getClaimName(Map<String, dynamic> json) {
    return json['cobenefitName'] ?? json['benefitName'];
  }

  static String? getBenefitClaimId(Map<String, dynamic> json) {
    return json['additionalBenefitPerSupplierId'] ??
        json['cobenefitPerSupplierId'] ??
        json['benefitPerSupplierId'];
  }

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    if (json['rating'] != null) {
      json['rating']['ticketId'] = addTicketIdToRating(json);
    }
    json['claimName'] = getClaimName(json);
    json['benefitClaimId'] = getBenefitClaimId(json);
    return _$TicketModelFromJson(json);
  }

  bool get isSOS => benefitName.isEmpty && cobenefitName.isEmpty;

  String get currentBenefitName =>
      cobenefitName.isNotEmpty ? cobenefitName : benefitName;

  @override
  int compareTo(TicketModel other) {
    if (status.index == other.status.index &&
        registerDate.isAfter(other.registerDate)) {
      return -1;
    }
    if (status.index == other.status.index &&
        registerDate.isBefore(other.registerDate)) {
      return 1;
    }
    return status.index - other.status.index;
  }
}
