///This class contains all properties to create a ticket
class CreateTicket {
  CreateTicket({
    required this.userId,
    required this.membershipId,
    this.isSos = false,
    this.benefitPerSupplierId,
    this.cobenefitPerSupplierId,
    this.additionalBenefitPerSupplierId,
  });

  String userId;
  String membershipId;
  bool isSos;
  String? benefitPerSupplierId;
  String? cobenefitPerSupplierId;
  String? additionalBenefitPerSupplierId;

  factory CreateTicket.fromJson(Map<String, dynamic> json) => CreateTicket(
        userId: json['userId'],
        membershipId: json['membershipId'],
        isSos: json['isSOS'],
        benefitPerSupplierId: json['benefitPerSupplierId'] ?? null,
        cobenefitPerSupplierId: json['cobenefitPerSupplierId'] ?? null,
        additionalBenefitPerSupplierId:
            json['additionalBenefitPerSUpplierId'] ?? null,
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'membershipId': membershipId,
        'isSOS': isSos,
        'benefitPerSupplierId': benefitPerSupplierId ?? null,
        'cobenefitPerSupplierId': cobenefitPerSupplierId ?? null,
        'additionalBenefitPerSupplierId':
            additionalBenefitPerSupplierId ?? null,
      };
}
