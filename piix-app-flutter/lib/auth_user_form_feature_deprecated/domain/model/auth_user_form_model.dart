import 'package:json_annotation/json_annotation.dart';
part 'auth_user_form_model.g.dart';

@JsonSerializable(createFactory: false)
class AuthUserFormModel {
  const AuthUserFormModel({
    required this.userId,
    required this.mainUserInfoFormId,
    this.membershipId,
  });

  final String userId;
  final String mainUserInfoFormId;
  final String? membershipId;

  Map<String, dynamic> toJson() => _$AuthUserFormModelToJson(this);
}
