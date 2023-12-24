import 'package:json_annotation/json_annotation.dart';
part 'user_credential_model.g.dart';

///This model is used to check the user credential [emailSignUp] or [phoneNumber]
/// is valid
@JsonSerializable()
class UserCredentialModel {
  UserCredentialModel({
    required this.usernameCredential,
  });

  final String usernameCredential;

  factory UserCredentialModel.fromJson(Map<String, dynamic> json) =>
      _$UserCredentialModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserCredentialModelToJson(this);

  UserCredentialModel copyWith({
    String? userCredential,
  }) {
    return UserCredentialModel(
        usernameCredential: userCredential ?? usernameCredential);
  }
}
