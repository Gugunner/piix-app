import 'package:firebase_auth/firebase_auth.dart';
import 'package:piix_mobile/auth_feature/user_app_model_barrel_file.dart';

abstract interface class IAuthRepository {
  ///Returns the [dynamic] type when signing in
  ///to the app.
  Future<dynamic> signInWithCustomToken(String token);

  ///Calls sign out and clears any information obtained in
  ///[signInWithCustomToken].
  Future<void> signOut();

  ///Checks if the user sent credentials are valid or not
  ///depending if the user is signing in or is signing up.
  Future<void> checkUserCredentials(AuthUserModel authModel);

  ///Retrieves the token needed for the user to sign in to its [FirebaseAuth]
  ///account.
  ///
  ///Do not provide a way for the user to call manually this service.
  Future<UserAppModel> getCustomTokenForUser(AuthUserModel authModel);

  ///Checks if the verification code sent by the user is valid and returns
  ///a different response depending whether the user is signing in,
  ///signing up or updating its credentials.
  Future<UserAppModel> checkUserVerificationCode(AuthUserModel authModel);
}
