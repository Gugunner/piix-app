import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/auth_feature/data/repository/auth_repository.dart';
import 'package:piix_mobile/auth_feature/domain/provider/user_provider.dart';
import 'package:piix_mobile/general_app_feature/api/local/app_shared_preferences.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'custom_token_provider.g.dart';

@riverpod
final class CustomTokenPod extends _$CustomTokenPod {
  String get _className => 'CustomTokenPod';

  @override
  Future<void> build() => _signInWithCustomToken();

  Future<void> _signInWithCustomToken() async {
    try {
      //Retrieve local user to get values for custom access token
      final authUser =
          await AppSharedPreferences.recoverAuthUserForCustomToken();
      if (authUser == null) {
        throw Exception('No local user custom access token was found');
      }
      //Return updated user with new custom access token
      final user =
          await ref.read(authRepositoryPod).getCustomTokenForUser(authUser);
      //Save the new user
      ref.read(userPodProvider.notifier).set(user);
      //Store the new user values in local
      await AppSharedPreferences.storeUser(user: user);
      //Read the custom access token of the user.
      final customToken = user.customAccessToken ?? '';
      //Use the custom access token to sign in with Firebase
      //and to get the user credentials in Firebase.
      final userCredential =
          await ref.read(authRepositoryPod).signInWithCustomToken(customToken);
      //Using the user credentials obtain the id token of Firebase
      //needed for all authenticated and authorized api calls.
      final idToken =
          await (userCredential as UserCredential).user?.getIdToken() ?? '';
      //Store the retrieved token in local so it can easily be read
      //inside the Http interceptor when making requests.
      await AppSharedPreferences.saveAuthoken(idToken);
      PiixLogger.instance.log(
        logMessage: 'Current idToken - $idToken',
        level: Level.debug,
      );
    } catch (error) {
      AppApiExceptionHandler.handleError(_className, error);
      rethrow;
    }
  }
}
