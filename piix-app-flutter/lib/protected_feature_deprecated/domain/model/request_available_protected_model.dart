
import 'package:json_annotation/json_annotation.dart';

part 'request_available_protected_model.g.dart';

@JsonSerializable(createFactory: false)
class RequestAvailableProtectedModel {
  const RequestAvailableProtectedModel({
    required this.membershipId,
  });

  final String membershipId;

  Map<String, dynamic> toJson() => _$RequestAvailableProtectedModelToJson(this);
}
