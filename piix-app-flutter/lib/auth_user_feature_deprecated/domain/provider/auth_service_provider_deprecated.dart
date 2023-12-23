import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/data/repository/auth_service_repository.dart';
import 'package:piix_mobile/auth_feature/domain/model/auth_user_model.dart';
import 'package:piix_mobile/auth_feature/domain/model/user_app_model.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/utils/auth_method_enum.dart';
import 'package:piix_mobile/general_app_feature/api/local/app_shared_preferences.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/app_bloc.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_values.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service_provider_deprecated.g.dart';

@Deprecated('Will be removed in 4.0')
@riverpod
class UserCredentialState extends _$UserCredentialState {
  @override
  CredentialState build() => CredentialState.idle;
  @Deprecated('Will be removed in 4.0')
  Future<void> send({
    required String usernameCredential,
    required AuthMethod authMethod,
  }) async {
    state = CredentialState.sending;
    final authModel = AuthUserModel.phoneSignIn(
      usernameCredential: usernameCredential,
      // authMethod: authMethod,
    );
    try {
      state = await getIt<AuthServiceRepository>()
          .sendCredentialRequested(authModel);
      return;
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in sendCredential',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      //If any kind of exception or error is thrown that
      //is not directly handled always set
      //the credentialState to an error state.
      state = CredentialState.error;
    }
  }
}

@Deprecated('Will be removed in 4.0')
//Temporal provider while the state manager changes
final authServiceProvider = ChangeNotifierProvider<AuthServiceProvider>((ref) {
  return AuthServiceProvider();
});

@Deprecated('No longer in use')
class AuthServiceProvider extends ChangeNotifier {
  ///Controls if the api requests call the real api or instead read from a
  ///fake response.
  bool _appTest = false;
  bool get appTest => _appTest;
  void setAppTest(bool value) {
    _appTest = value;
  }

  ///Model used for the authentication flow of the app
  UserAppModel? _user;
  UserAppModel? get user => _user;
  void setUser(UserAppModel? value) {
    _user = value;
  }

  @Deprecated('Will be removed in 4.0')
  ///State that handles the status of calling [sendVerificationCode].
  VerificationCodeState _verificationCodeState = VerificationCodeState.idle;
  VerificationCodeState get verificationCodeState => _verificationCodeState;
  void setVerificationCodeState(VerificationCodeState state) {
    _verificationCodeState = state;
    notifyListeners();
  }

  @Deprecated('Will be removed in 4.0')
  ///State that alerts if a user can be allowed to sign in or
  ///should be signed out.
  AuthState _authState = AuthState.idle;
  AuthState get authState => _authState;
  void setAuthState(AuthState state) {
    _authState = state;
    notifyListeners();
  }

  AuthServiceRepository get _authServiceRepository =>
      getIt<AuthServiceRepository>();

  @Deprecated('Will be removed in 4.0')
  ///Saves a user in [AppSharedPreferences] but checks if any old user values
  ///exist.
  Future<void> storeAuthUser(
    //The current user that is to be stored
    UserAppModel user, {
    //Pass a credential only if the user is signing in or signing up
    String? credential,
    //Pass an authMethod only if the user is signing in or signing up
    AuthMethod? authMethod,
    //Pass a hashableUnixTime only if the user is signing in or signing up
    int? hashableUnixTime,
  }) async {
    //Always tries to get an old user
    final oldAuthUser = await AppSharedPreferences.recoverAuthUser();
    PiixLogger.instance.log(
        logMessage:
            'Old custom access token - ${oldAuthUser?.customAccessToken}',
        level: Level.debug);
    PiixLogger.instance.log(
        logMessage: 'New custom access token - ${user.customAccessToken}',
        level: Level.debug);
    //A new authUser is created that keeps old values when possible to avoid
    //any Firebase Error.
    final authUser = AuthUserModel.local(
      userId: oldAuthUser?.userId ?? user.userId,
      //Keep the old credential to always persist the value the user entered
      //when signing in or signing up
      usernameCredential: credential ?? oldAuthUser?.phoneNumber ?? '',
      //Keep old auth method to always maintain if the user signed in
      //or signed up with phone or email
      // authMethod: authMethod ?? oldAuthUser?.authMethod,
      //Keep old custom access token as the hashing key must be the same to
      //the one used in the signed in or signed up moment so the app can
      // always retrieve the custom firebase token used for the
      //custom sign in which in turn allows the retrieval of the firebase token
      //used for any request that needs authorization
      customAccessToken:
          oldAuthUser?.customAccessToken ?? user.customAccessToken ?? '',
      //Keep old unix time as the hashing key must be the same to
      //the one used in the signed in or signed up moment so the app can
      // always retrieve the custom firebase token used for the
      //custom sign in which in turn allows the retrieval of the firebase token
      //used for any request that needs authorization
      hashableUnixTime: oldAuthUser?.hashableUnixTime ?? hashableUnixTime ?? -1,
      //Always update the authorizedUser property with the new user passed
      authorizedUser: user.approved,
      //Always update the verifiedPhone property with the new user passed
      phoneVerified: user.phoneVerified,
      //Always update the verifiedEmail property with the new user passed
      emailVerified: user.emailVerified,
    );
    await AppSharedPreferences.saveAuthUser(authUser);
    PiixLogger.instance.log(
        logMessage:
            'Auth user custom access token - ${authUser.customAccessToken}',
        level: Level.debug);
    PiixLogger.instance.log(
        logMessage: 'Auth user hashable time - ${authUser.hashableUnixTime}',
        level: Level.debug);
  }

  @Deprecated('Will be removed in 4.0')
  Future<void> sendVerificationCode({
    required String credential,
    required AuthMethod authMethod,
    required String verificationCode,
    String userId = '',
    int hashableUnixTime = -1,
    bool updateCredential = false,
  }) async {
    try {
      //Set the state to a loading state to handle any loading effect on the
      //calling widget
      setVerificationCodeState(VerificationCodeState.verifying);
      //Create an AuthUserModel with the [verification] constructor
      var authModel;
      if (updateCredential) {
        authModel = AuthUserModel.phoneUpdate(
          userId: userId,
          usernameCredential: credential,
          verificationCode: verificationCode,
          // authMethod: authMethod,
        );
      } else {
        authModel = AuthUserModel.phoneVerify(
          usernameCredential: credential,
          // authMethod: authMethod,
          verificationCode: verificationCode,
          hashableUnixTime: hashableUnixTime,
        );
      }
      final data = await _authServiceRepository.sendVerificationCodeRequested(
        authModel,
        appTest,
      );
      //When the data is a VerificationCodeState it means
      //that a specific error was handled with a specific state
      //and the execution should stop.
      if (data is VerificationCodeState) {
        setVerificationCodeState(data);
        return;
      }
      final newState = data['state'];
      setVerificationCodeState(newState);
      //When the verification is for a protected no user is stored and
      //the method exits to avoid storing the protected user
      if (authMethod.isProtected) return;
      if (newState == VerificationCodeState.verified) {
        final newUser = UserAppModel.fromJson(data);
        setUser(newUser);
        //A succesful verification means storing the user values
        //Create an AuthUserModel with the [verification] constructor
        await storeAuthUser(
          newUser,
          credential: credential,
          authMethod: authMethod,
          hashableUnixTime: hashableUnixTime,
        );
      }
      //After storing the user set the [authState] to authorized
      //to allow a sign in or sign up.
      setAuthState(AuthState.authorized);
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in sendVerificationCode',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      //If any kind of exception or error is thrown that
      //is not directly handled always set
      //the verificationCodeState to an error state.
      setVerificationCodeState(VerificationCodeState.error);
    }
  }

  @Deprecated('Will be removed in 4.0')
  ///Sends values that are used for hashing a specific key which
  ///represents a valid user to retrieve.
  ///
  ///The method is used specifically when there is a user already stored in
  ///[AppSharedPreferences] and an automatic sign in is being called.
  Future<void> sendHashableAuthValues({
    required String userId,
    required String hashableCustomAuthToken,
    required int hashableUnixTime,
    //Use this flag when testing with unit tests or widget tests
    //to prevent calling real AuthFirebase
    bool useFirebase = true,
  }) async {
    try {
      //Set the state to a loading state to handle any loading effect on the
      //calling widget
      setAuthState(AuthState.authorizing);
      //Create an AuthUserModel with the [autoSignIn] constructor
      final authModel = AuthUserModel.autoSignIn(
        userId: userId,
        customAccessToken: hashableCustomAuthToken,
        hashableUnixTime: hashableUnixTime,
      );
      final data = await _authServiceRepository.sendHashableAuthValuesRequested(
        authModel,
        appTest,
      );
      //When the data is an AuthState it means
      //that a specific error was handled with a specific state
      //and the execution should stop.
      if (data is AuthState) {
        setAuthState(data);
        return;
      }
      final newUser = UserAppModel.fromJson(data);
      final newState = data['state'];
      //Only calls an execution of AuthFirebase signInWithCustomToke
      //if the app is not used in unit, widget or app tests.
      if (useFirebase && !appTest) {
        //If the call fails the handling of the error is done inside the method
        await signInWithCustomToken(newUser.customAccessToken ?? '');
      }
      setUser(newUser);
      //Store the new user values from the request
      await storeAuthUser(newUser);
      //Set the user id for the only instance of Firebase Analytics
      await FirebaseAnalytics.instance.setUserId(
        id: newUser.userId,
      );
      //Set the user id for the only instance of Firebase Crashlytics
      await FirebaseCrashlytics.instance.setUserIdentifier(
        newUser.userId,
      );
      setAuthState(newState);
    } catch (e) {
      //If any kind of exception or error is thrown that
      //is not directly handled always set
      //the authState to an unauthorized state.
      setAuthState(AuthState.unauthorized);
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in sendHashableValues',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      //Any unauthorized state immediatly signs out the user
      if (useFirebase) {
        getIt<AppBLoC>().signOut(
          trigger: PiixAnalyticsValues.failedToObtainCustomAccessToken,
        );
      }
    }
  } 

  @Deprecated('Will be removed in 4.0')
  Future<void> signInWithCustomToken(String customAccessToken) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithCustomToken(customAccessToken);
      final authToken = await userCredential.user?.getIdToken();
      //If there is no token from firebase the user is not
      //authorized and is immediately signed out.
      if (authToken == null) {
        setAuthState(AuthState.unauthorized);
        getIt<AppBLoC>().signOut(
          trigger: PiixAnalyticsValues.failedFirebaseCustomSignIn,
        );
        return;
      }
      final loggerInstance = PiixLogger.instance;
      loggerInstance.log(
        level: Level.debug,
        logMessage: 'New AuthToken - $authToken',
      );
      //Save the token in [AppSharedPreferences] so it can be used in any
      //request and be updated when needed.
      await AppSharedPreferences.saveAuthoken(authToken);
    } on FirebaseAuthException catch (e) {
      var message = '';
      switch (e.code) {
        case 'invalid-custom-token':
          message = 'The supplied token is not a Firebase custom auth token.';
          break;
        case 'custom-token-mismatch':
          message = 'The supplied token is for a different Firebase project.';
          break;
        default:
          message = 'Unkown error.';
      }
      //If any kind of firebase exception or error is thrown that
      //is not directly handled always set
      //the authState to an unauthorized state.
      setAuthState(AuthState.unauthorized);
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in signInWithCustomToken',
        message: message,
        isLoggable: true,
      );
      PiixLogger.instance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      //Any unauthorized state immediately signs out the user
      getIt<AppBLoC>().signOut(
        trigger: PiixAnalyticsValues.failedFirebaseCustomSignIn,
      );
    }
  }

  @Deprecated('Will be removed in 4.0')
  ///Cleans all the states handled by this provider.
  void clearProvider() {
    _user = null;
    _verificationCodeState = VerificationCodeState.idle;
    _authState = AuthState.idle;
    notifyListeners();
  }
}
