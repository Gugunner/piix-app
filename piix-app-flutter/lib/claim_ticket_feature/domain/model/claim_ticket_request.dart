import 'package:json_annotation/json_annotation.dart';

part 'claim_ticket_request.g.dart';

@JsonSerializable()
//TODO ADD DOCUMENTATION IN NEXT PR
class ClaimTicketRequest {
  ClaimTicketRequest({
    this.userId,
    this.ticketId,
    this.cancellationReason,
    this.supplierRating,
    this.benefitPerSupplierRating,
    this.comments,
    this.membershipId,
    this.isSOS,
    this.benefitPerSupplierId,
    this.cobenefitPerSupplierId,
    this.additionalBenefitPerSupplierId,
    this.problemDescription,
  });
  String? userId;
  String? ticketId;
  String? cancellationReason;
  double? supplierRating;
  double? benefitPerSupplierRating;
  String? comments;
  String? membershipId;
  @JsonKey(includeIfNull: false)
  bool? isSOS;
  String? benefitPerSupplierId;
  String? cobenefitPerSupplierId;
  String? additionalBenefitPerSupplierId;
  String? problemDescription;

  ClaimTicketRequest.cancel({
    required this.ticketId,
    required this.cancellationReason,
  });

  ClaimTicketRequest.reportProblem({
    required this.ticketId,
    required this.problemDescription,
  });

  ClaimTicketRequest.close({
    required this.ticketId,
    required this.supplierRating,
    required this.benefitPerSupplierRating,
    required this.comments,
  });

  ClaimTicketRequest.create({
    required this.userId,
    required this.membershipId,
    required this.isSOS,
    required this.benefitPerSupplierId,
    required this.cobenefitPerSupplierId,
    required this.additionalBenefitPerSupplierId,
  });

  factory ClaimTicketRequest.fromJson(Map<String, dynamic> json) =>
      _$ClaimTicketRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimTicketRequestToJson(this);

  ClaimTicketRequest copyWith({
    String? userId,
    String? ticketId,
    String? cancellationReason,
    double? supplierRating,
    double? benefitPerSupplierRating,
    String? comments,
    String? membershipId,
    bool? isSOS,
    String? benefitPerSupplierId,
    String? cobenefitPerSupplierId,
    String? additionalBenefitPerSupplierId,
    String? problemDescription,
  }) =>
      ClaimTicketRequest(
        userId: userId ?? this.userId,
        ticketId: ticketId ?? this.ticketId,
        cancellationReason: cancellationReason ?? this.cancellationReason,
        supplierRating: supplierRating ?? this.supplierRating,
        benefitPerSupplierRating:
            benefitPerSupplierRating ?? this.benefitPerSupplierRating,
        comments: comments ?? this.comments,
        membershipId: membershipId ?? this.membershipId,
        isSOS: isSOS ?? this.isSOS,
        benefitPerSupplierId: benefitPerSupplierId ?? this.benefitPerSupplierId,
        cobenefitPerSupplierId:
            cobenefitPerSupplierId ?? this.cobenefitPerSupplierId,
        additionalBenefitPerSupplierId: additionalBenefitPerSupplierId ??
            this.additionalBenefitPerSupplierId,
        problemDescription: problemDescription ?? this.problemDescription,
      );
}
