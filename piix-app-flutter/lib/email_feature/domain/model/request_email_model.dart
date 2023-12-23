import 'package:json_annotation/json_annotation.dart';
part 'request_email_model.g.dart';

@JsonSerializable()
class RequestEmailModel {
  const RequestEmailModel({
    required this.userId,
    required this.benefitName,
    required this.toEmails,
    required this.attachments,
  });

  final String userId;
  final String benefitName;
  final List<EmailRecipientsModel> toEmails;
  final List<EmailAttachmentsModel> attachments;

  factory RequestEmailModel.fromJson(Map<String, dynamic> json) =>
      _$RequestEmailModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestEmailModelToJson(this);
}

@JsonSerializable()
class EmailRecipientsModel {
  const EmailRecipientsModel({
    required this.displayName,
    required this.email,
  });

  final String displayName;
  final String email;

  factory EmailRecipientsModel.fromJson(Map<String, dynamic> json) =>
      _$EmailRecipientsModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmailRecipientsModelToJson(this);
}

@JsonSerializable()
class EmailAttachmentsModel {
  const EmailAttachmentsModel({
    required this.filename,
    required this.path,
  });

  final String filename;
  final String path;

  factory EmailAttachmentsModel.fromJson(Map<String, dynamic> json) =>
      _$EmailAttachmentsModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmailAttachmentsModelToJson(this);
}
