import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/auth_feature/data/repository/iauth_repository.dart';
import 'package:piix_mobile/auth_feature/domain/model/auth_user_model.dart';
import 'package:piix_mobile/auth_feature/domain/model/user_app_model.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/utils/api/repository_auxiliaries.dart';

///Contains all the service calls that handle the authentication
///and authorization of the server.
final class AuthRepository
    with RepositoryAuxiliaries
    implements IAuthRepository {
  @override
  Future<UserCredential> signInWithCustomToken(String token) async =>
      FirebaseAuth.instance.signInWithCustomToken(token);

  @override
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      PiixLogger.instance.log(
        logMessage: 'Firebase User could not sign out',
        level: Level.error,
        error: e,
        stackTrace: e.stackTrace,
      );
    }
  }

  @override
  Future<void> checkUserCredentials(AuthUserModel authModel) {
    final path = '${appConfig.backendEndpoint}/users/checkCredentials';
    return dio.post(path, data: authModel.toJson());
  }

  @override
  Future<UserAppModel> getCustomTokenForUser(AuthUserModel authModel) async {
    final path = '${appConfig.backendEndpoint}/users/customToken';
    final response = await dio.post(path, data: authModel.toJson());
    return UserAppModel.fromJson(response.data);
  }

  @override
  Future<UserAppModel> checkUserVerificationCode(
      AuthUserModel authModel) async {
    final path = '${appConfig.backendEndpoint}/users/checkVerificationCode';
    final response = await dio.post(path, data: authModel.toJson());
    if (response.data == null) {
      throw Exception('There is no data in the response');
    }
    return UserAppModel.fromJson(response.data);
  }
}

//Declare a simple Riverpod Provider that can modify the repository
final authRepositoryPod = Provider<IAuthRepository>((ref) => AuthRepository());
