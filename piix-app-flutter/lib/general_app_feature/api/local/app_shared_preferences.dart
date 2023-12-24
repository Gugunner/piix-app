import 'dart:convert';

import 'package:piix_mobile/auth_feature/domain/model/auth_user_model.dart';
import 'package:piix_mobile/auth_feature/domain/model/user_app_model.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/utils/auth_method_enum.dart';
import 'package:piix_mobile/membership_feature/domain/model/linkup_code_type_model.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static const String userAuth = 'userAuth';
  static const String prefUserCredential = 'userCredential';
  static const String authMethod = 'authMethod';
  static const String prefAuthToken = 'authToken';
  static const String hashableUnixTime = 'hashableUnixTime';
  static const String hasSeenOnboarding = 'hasSeenOnboarding';
  static const String prefUserId = 'userId';
  static const String communityName = 'communityName';
  static const String communityType = 'communityType';
  static const String htmlTerms = 'htmlTerms';
  static const String linkupCodeType = 'linkupCodeType';

  static Future<void> saveUserCredential(String userCredential) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(prefUserCredential, userCredential);
  }

  static Future<String?> recoverUserCredential() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(prefUserCredential);
  }

  static Future<void> saveAuthMethod(String authMethodName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(authMethod, authMethodName);
  }

  static Future<AuthMethod?> recoverAuthMethod() async {
    final prefs = await SharedPreferences.getInstance();
    final authMethodName = prefs.getString(authMethod);
    if (authMethodName.isNotNullEmpty) {
      return AuthMethod.values
          .firstWhere((value) => value.name == authMethodName);
    }
    return null;
  }

  static Future<void> saveAuthoken(String idToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(prefAuthToken, idToken);
  }

  static Future<String?> recoverAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(prefAuthToken);
  }

  static Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(prefUserId, userId);
  }

  static Future<String?> recoverUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(prefUserId);
  }

  static Future<void> saveHashableUnixTime(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(hashableUnixTime, value);
  }

  static Future<int?> recoverHashableUnixTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(hashableUnixTime);
  }

  static Future<void> storeUser({
    required UserAppModel user,
    int? hashableUnixTime,
  }) async {
    final storedUser = await AppSharedPreferences.recoverAuthUser();
    final authUser = AuthUserModel.local(
      userId: user.userId,
      usernameCredential: user.phoneNumber ?? storedUser?.phoneNumber ?? '',
      customAccessToken:
          user.customAccessToken ?? storedUser?.customAccessToken ?? '',
      hashableUnixTime: hashableUnixTime ?? storedUser?.hashableUnixTime ?? -1,
      authorizedUser: user.approved,
      phoneVerified: user.phoneVerified,
      emailVerified: user.emailVerified,
    );
    await AppSharedPreferences.saveAuthUser(authUser);
  }

  static Future<void> saveAuthUser(AuthUserModel authUser) async {
    final prefs = await SharedPreferences.getInstance();
    final stringifyAuthModel = json.encode(authUser.toJson());
    await prefs.setString(userAuth, stringifyAuthModel);
  }

  static Future<AuthUserModel?> recoverAuthUser() async {
    final prefs = await SharedPreferences.getInstance();
    final stringifyAuthModel = prefs.getString(userAuth);
    if (stringifyAuthModel != null) {
      final jsonUserAuth = jsonDecode(stringifyAuthModel);
      jsonUserAuth['modelType'] = 'local';
      return AuthUserModel.fromJson(jsonUserAuth);
    }
    return null;
  }

  static Future<AuthUserModel?> recoverAuthUserForCustomToken() async {
    final prefs = await SharedPreferences.getInstance();
    final stringifyAuthModel = prefs.getString(userAuth);
    if (stringifyAuthModel != null) {
      final jsonUserAuth = jsonDecode(stringifyAuthModel);
      jsonUserAuth['modelType'] = 'customToken';
      return AuthUserModel.fromJson(jsonUserAuth);
    }
    return null;
  }

  static Future<void> saveHasSeenOnboarding(bool hasSeen) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(hasSeenOnboarding, hasSeen);
  }

  static Future<bool?> recoverHasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(hasSeenOnboarding);
  }

  static Future<void> saveUserCommunityName(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(communityName, value);
  }

  static Future<String?> recoverUserCommunityName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(communityName);
  }

  static Future<void> saveUserCommunityType(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(communityType, value);
  }

  static Future<String?> recoverUserCommunityType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(communityType);
  }

  static Future<void> saveHtmlTerms(String htmlTermsText) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(htmlTerms, htmlTermsText);
  }

  static Future<String?> recoverHtmlTerms() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(htmlTerms);
  }

  static Future<void> saveLinkupModel(LinkupCodeTypeModel linkupModel) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonLinkupType = linkupModel.toJson();
    final stringLinkupType = jsonEncode(jsonLinkupType);
    await prefs.setString(linkupCodeType, stringLinkupType);
  }

  static Future<LinkupCodeTypeModel?> recoverLinkupModel() async {
    final prefs = await SharedPreferences.getInstance();
    final stringLinkupType = prefs.getString(linkupCodeType);
    if (stringLinkupType == null) return null;
    final jsonLinkupType = jsonDecode(stringLinkupType);
    return LinkupCodeTypeModel.fromJson(jsonLinkupType);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
