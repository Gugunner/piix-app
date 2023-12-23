import 'package:json_annotation/json_annotation.dart';
part 'app_api_exception.g.dart';

@JsonSerializable(createToJson: false)
class AppApiException implements Exception {
   AppApiException({
    this.errorName,
    this.errorMessage,
    this.errorMessages,
    this.errorCodes,
    this.detailedErrorCodes,
  });

  final String? errorName;
  final String? errorMessage;
  final List<String>? errorMessages;
  final List<String>? errorCodes;
  final List<DetailErrorCode>? detailedErrorCodes;

  factory AppApiException.fromJson(Map<String, dynamic> json) =>
      _$AppApiExceptionFromJson(json);
}

@JsonSerializable(createToJson: false)
class DetailErrorCode {
  const DetailErrorCode({
    this.errorCode,
    this.key,
    this.value,
  });

  final String? errorCode;
  final String? key;
  final dynamic value;

  factory DetailErrorCode.fromJson(Map<String, dynamic> json) =>
      _$DetailErrorCodeFromJson(json);
}

