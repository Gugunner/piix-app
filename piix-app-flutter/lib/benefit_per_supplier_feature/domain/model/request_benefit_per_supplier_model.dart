import 'package:json_annotation/json_annotation.dart';

part 'request_benefit_per_supplier_model.g.dart';

@JsonSerializable(
  createFactory: false,
)
class RequestBenefitPerSupplierModel {
  RequestBenefitPerSupplierModel({
    required this.benefitPerSupplierId,
    required this.userId,
    required this.membershipId,
  });

  final String benefitPerSupplierId;
  final String userId;
  final String membershipId;

  Map<String, dynamic> toJson() => _$RequestBenefitPerSupplierModelToJson(this);
}
