import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/auth_feature/domain/provider/user_provider.dart';
import 'package:piix_mobile/general_app_feature/api/local/app_shared_preferences.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'piix_firebase_auth_provider.g.dart';

///Declare a simple Riverpod Provider that wraps the [FirebaseAuth] 
///instance 
final firebasePod = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);


@Deprecated('Will be removed in 4.0')
///Always listens to any change in the sign in or sign out of the user
///returns a [User] if there is one.
@Riverpod(keepAlive: true)
Stream<User?> authStateChange(AuthStateChangeRef ref){
  //TODO: Read Stream and clear all states of the app
  return ref.watch(firebasePod).authStateChanges();
}
    

@Deprecated('Will be removed in 4.0')

///The App Firebase instance
@Riverpod(keepAlive: true)
class PiixFirebaseAuth extends _$PiixFirebaseAuth {
  @override
  FirebaseAuth build() => FirebaseAuth.instance;

  Future<void> signOut() async {
    try {
      await state.signOut();
    } on FirebaseAuthException catch (e) {
      PiixLogger.instance.log(
        logMessage: 'Firebase User could not sign out',
        level: Level.error,
        error: e,
        stackTrace: e.stackTrace,
      );
    }
  }
}



@Deprecated('Will be removed in 4.0')

///The provider to store the state of the UserCredential each
///time the user receives a new customAccessToken
@Riverpod(keepAlive: true)
class FirebaseUserCredential extends _$FirebaseUserCredential {
  @Deprecated('Will be removed in 4.0')
  Future<void> signInWithCustomToken() async {
    final customAccessToken = ref.read(userPodProvider)?.customAccessToken;
    final userCredential = await ref
        .read(piixFirebaseAuthProvider)
        .signInWithCustomToken(customAccessToken ?? '');
    await _setUserCredential(userCredential);
  }
  @Deprecated('Will be removed in 4.0')
  @override
  UserCredential? build() => null;
  @Deprecated('Will be removed in 4.0')
  Future<void> _setUserCredential(UserCredential? userCredential) async {
    state = userCredential;
    //Recovers the token from the firebase user credential
    final idToken = await userCredential?.user?.getIdToken() ?? '';
    //Stores the current idToken in local storage
    await AppSharedPreferences.saveAuthoken(idToken);
    PiixLogger.instance.log(
      logMessage: 'Current idToken - $idToken',
      level: Level.debug,
    );
  }
}
