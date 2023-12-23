import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user_model.freezed.dart';
part 'auth_user_model.g.dart';

enum AppFlow {
  START_LOGIN,
  START_REGISTER,
  START_CHANGE_CREDENTIAL,
}

///A model use for sending the credential, verification code
///and automatic sign in.
@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType',
)
class AuthUserModel with _$AuthUserModel {
  @JsonSerializable(explicitToJson: true)
  const AuthUserModel._();

  factory AuthUserModel.phoneSignIn({
    @JsonKey(required: true) required String usernameCredential,
    @Default('START_LOGIN') String appFlow,
  }) = _AuthUserPhoneSignInModel;

  factory AuthUserModel.phoneSignUp({
    @JsonKey(required: true) required String usernameCredential,
    @Default('START_REGISTER') String appFlow,
  }) = _AuthUserPhoneSignUpModel;

  factory AuthUserModel.phoneUpdate({
    @JsonKey(required: true) required String userId,
    @JsonKey(required: true) required String usernameCredential,
    @JsonKey(required: true) required String verificationCode,
    @Default('START_CHANGE_CREDENTIAL') String appFlow,
  }) = _AuthUserPhoneUpdateModel;

  factory AuthUserModel.phoneVerify({
    @JsonKey(required: true) required String usernameCredential,
    @JsonKey(required: true) required String verificationCode,
    @JsonKey(required: true) required int hashableUnixTime,
    @Default('START_LOGIN') String appFlow,
  }) = _AuthUserPhoneVerifyModel;

  factory AuthUserModel.local({
    @JsonKey(required: true) required String userId,
    @JsonKey(required: true) required String usernameCredential,
    @JsonKey(required: true) required String customAccessToken,
    @JsonKey(required: true) required int hashableUnixTime,
    @Default(false) bool authorizedUser,
    @Default(false) bool phoneVerified,
    @Default(false) bool emailVerified,
  }) = _AuthUserLocalModel;

  factory AuthUserModel.customToken({
    @JsonKey(required: true) required String userId,
    @JsonKey(required: true) required String customAccessToken,
    @JsonKey(required: true) required int hashableUnixTime,
  }) = _AuthUserCustomTokenModel;

  factory AuthUserModel.autoSignIn({
    @JsonKey(required: true) required String userId,
    @JsonKey(required: true) required String customAccessToken,
    @JsonKey(required: true) required int hashableUnixTime,
  }) = _AuthUserAutoSignInModel;

  factory AuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$AuthUserModelFromJson(json);

  Map<String, dynamic> toMap() => toJson();

  String? get phoneNumber => mapOrNull(
        autoSignIn: (_) => null,
        local: (value) => value.usernameCredential,
      );

  String? get userId => mapOrNull(
        autoSignIn: (value) => value.userId,
      );

  String? get customAccessToken => mapOrNull(
        autoSignIn: (value) => value.customAccessToken,
      );

  String? get verificationCode => mapOrNull(
        autoSignIn: (value) => null,
      );

  int? get hashableUnixTime => mapOrNull(
        autoSignIn: (value) => value.hashableUnixTime,
      );

  bool get authorizedUser => maybeMap(
        orElse: () => false,
      );

  bool get verifiedPhone => maybeMap(
        orElse: () => false,
      );

  bool get verifiedEmail => maybeMap(
        orElse: () => false,
      );

  ///Converts an [AutUserModel] of [modelType] store
  ///to an AuthUserModel of [modelType] autoSignIn
  AuthUserModel get autoSign {
    final authUserJson = toJson();
    authUserJson['modelType'] = 'autoSignIn';
    return AuthUserModel.fromJson(authUserJson);
  }
}
