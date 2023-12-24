import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/api_deprecated/piix_firebase_auth_provider.dart';
import 'package:piix_mobile/auth_feature/data/repository/auth_service_repository_deprecated.dart';
import 'package:piix_mobile/auth_feature/domain/provider/user_provider.dart';
import 'package:piix_mobile/auth_feature/domain/provider/verification_code_provider_deprecated.dart';

import 'package:piix_mobile/auth_feature/domain/model/auth_user_model.dart';
import 'package:piix_mobile/auth_feature/domain/model/user_app_model.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_input_provider.dart';
import 'package:piix_mobile/welcome_screen.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/utils/auth_input_state_enum.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/utils/auth_method_enum.dart';
import 'package:piix_mobile/general_app_feature/api/local/app_shared_preferences.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_events_constants.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_parameter_constants.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_values.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/utils/log_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service_provider_deprecated.g.dart';

@Deprecated('Will be removed in 4.0')

///All the possible states for a user to be authorized
///entry to the app logged section
enum AuthState {
  idle,
  authorized,
  unauthorized,
}

@Deprecated('Will be removed in 4.0')
@Riverpod(keepAlive: true)
class AuthStatePod extends _$AuthStatePod {
  @override
  AuthState build() => AuthState.idle;

  void setAuthState(AuthState value) {
    state = value;
  }
}

@Deprecated('Will be removed in 4.0')

///A provider that handles the [AuthState] of
///the app at all times and calls for
///the [UserAppModel] with the new [customAccessToken].
///
///Calls [getCustomToken] which makes a request
///to the server forthe user, use it when the user
///Signs In either manually or automatic and when the user
///Signs Up.
@riverpod
class CustomTokenService extends _$CustomTokenService
    with LogApiCall, LogAppCall, LogAnalytics {

  @Deprecated('Will be removed in 4.0')
  ///The user is denied access after a unsuccessful
  ///request and is signed out.
  void deny(Object? error) {
    final loggerInstance = PiixLogger.instance;
    final logMessage = loggerInstance.errorMessage(
      messageName: 'Error in AuthStateService',
      message: error.toString(),
      isLoggable: true,
    );
    loggerInstance.log(
      logMessage: logMessage.toString(),
      error: error,
      level: Level.error,
      sendToCrashlytics: true,
    );
    logEvent(
      eventName: PiixAnalyticsEvents.signOut,
      eventParameters: {
        PiixAnalyticsParameters.userTrigger: PiixAnalyticsValues.yesOrNo(false),
        PiixAnalyticsParameters.trigger:
            PiixAnalyticsValues.failedToObtainCustomAccessToken,
      },
    );
    signOut();
  }

  @Deprecated('Will be removed in 4.0')
  ///Signs out the user from the app, clearing
  ///any app state, [SharedPreferences] and [Firebase]
  void signOut() async {
    ref.read(userPodProvider.notifier).set(null);
    ref.read(authUserNotifierPodProvider.notifier).setAuthUser(null);
    await ref.read(piixFirebaseAuthProvider.notifier).signOut();
    //TODO: Clear all providers that have keepAlive: true
    ref.read(verificationCodeProvider.notifier).setVerificationCode([]);
    ref
        .read(verificationStatePodProvider.notifier)
        .setVerificationState(VerificationStateDeprecated.idle);
    ref
        .read(verificationModeProvider.notifier)
        .setVerificationModeState(VerificationModeStateDeprecated.idle);
    ref.read(usernameCredentialProvider.notifier).set(null);
    ref
        .read(authMethodStateProvider.notifier)
        .clearProvider(authMethod: AuthMethod.none);
    ref.read(authStatePodProvider.notifier).setAuthState(AuthState.idle);
    await AppSharedPreferences.clear();

    ///When signed out it returns to the starting app screen
    NavigatorKeyState().getNavigator()?.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const WelcomeScreen(),
          ),
          ModalRoute.withName(WelcomeScreen.routeName),
        );
  }

  @Deprecated('Will be removed in 4.0')
  ///A getter that calls the AuthUserModel currently stored.
  Future<AuthUserModel?> get _authModel async {
    final authModel =
        await ref.read(authUserNotifierPodProvider.notifier).recover();
    return authModel?.autoSign;
  }

  @Deprecated('Will be removed in 4.0')
  ///Makes a request to get a user and either authorize or
  ///deny access to the app.
  Future<void> getCustomToken() async {
    final authModel = await _authModel;
    if (authModel == null) return;
    final authStatePodNotifier = ref.read(authStatePodProvider.notifier);
    try {
      final user = await ref
          .read(authCustomTokenServiceRepositoryProvider.notifier)
          .getCustomTokenUser((authModel));
      ref.read(userPodProvider.notifier).set(user);
      authStatePodNotifier.setAuthState(AuthState.authorized);
      await ref
          .read(firebaseUserCredentialProvider.notifier)
          .signInWithCustomToken();
    } catch (error) {
      if (error is! DioError) {
        logError(error, className: 'AuthStateService');
      } else {
        logDioException(error, className: 'AuthStateService');
      }
      authStatePodNotifier.setAuthState(AuthState.unauthorized);
      deny(error);
    }
  }

  @override
  FutureOr<void> build() => getCustomToken();
}

@Deprecated('Will be removed in 4.0')
@riverpod
class SignUpSignInService extends _$SignUpSignInService
    with LogApiCall, LogAppCall {
  @override
  FutureOr<void> build() => _signUpSignIn();

  @Deprecated('Will be removed in 4.0')
  ///Returns an [AuthUserModel] of [modelType] credential
  AuthUserModel get _authModel {
    final usernameCredential = ref
        .read(usernameCredentialProvider.notifier)
        .completeUsernameCredential;
    return AuthUserModel.phoneSignIn(
      usernameCredential: usernameCredential,
    );
  }

  @Deprecated('Will be removed in 4.0')
  Future<void> _signUpSignIn() async {
    //Call the request to obtain a verification code either by email or phone
    final authCredentialService =
        ref.read(authCredentialServiceRepositoryProvider.notifier);
    // state = await AsyncValue.guard<void>(() async {
    try {
      await authCredentialService.sendCredential(_authModel);
      final authMethod = ref.read(authMethodStateProvider);
      var verificationModeState = VerificationModeStateDeprecated.idle;
      if (authMethod.isSignIn) {
        //Mode used to allow the user to continue on to the app
        //and not be treated as a new signed up user if the verification
        //of the code is successful.
        verificationModeState = VerificationModeStateDeprecated.authorizing;
      } else if (!authMethod.isSignIn) {
        //Mode used to treat the user as a new signed up user if the verification
        //of the code is successful.
        verificationModeState = VerificationModeStateDeprecated.authenticating;
      }
      ref
          .read(verificationModeProvider.notifier)
          .setVerificationModeState(verificationModeState);
    } catch (error) {
      if (error is! DioError) {
        logError(error, className: 'SignUpSignInService');
        rethrow;
      }
      logDioException(error, className: 'SignUpSignInService');
      final statusCode = error.response?.statusCode ?? 500;
      if (statusCode == HttpStatus.conflict ||
          statusCode == HttpStatus.notFound) {
        ref.read(authMethodStateProvider.notifier).checkForInputErrors();
        rethrow;
      }
      final authInputStateProviderNotifier =
          ref.read(authInputProvider.notifier);
      authInputStateProviderNotifier.setAuthInputState(AuthInputState.error);
      rethrow;
    }
  }
}
