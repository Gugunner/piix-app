import 'package:json_annotation/json_annotation.dart';
part 'update_credential_model.g.dart';

@JsonSerializable(createFactory: false)
class UpdateEmailRequestModel {
  const UpdateEmailRequestModel({
    required this.userId,
    required this.newEmail,
    this.currentEmail,
  });

  final String userId;
  final String newEmail;
  final String? currentEmail;

  Map<String, dynamic> toJson() => _$UpdateEmailRequestModelToJson(this);
}

@JsonSerializable(createFactory: false)
class UpdatePhoneNumberRequestModel {
  const UpdatePhoneNumberRequestModel({
    required this.userId,
    required this.currentPhoneNumber,
    required this.newPhoneNumber,
  });

  final String userId;
  final String currentPhoneNumber;
  final String newPhoneNumber;

  Map<String, dynamic> toJson() => _$UpdatePhoneNumberRequestModelToJson(this);
}
