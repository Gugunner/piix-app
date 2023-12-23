import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_service_provider_deprecated.dart';
import 'package:piix_mobile/welcome_screen.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/domain/provider/auth_user_form_ui_provider.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/providers/claim_ticket_provider.dart';
import 'package:piix_mobile/general_app_feature/api/local/app_shared_preferences.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/catalog_bloc.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/file_system_bloc.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/ui_bloc.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/navigation_deprecated/navigation_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_events_constants.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_parameter_constants.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_values.dart';
import 'package:piix_mobile/general_app_feature/utils/theme/theme_enum.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/basic_form_repository.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/basic_form_bloc.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/bloc/protected_provider.dart';
import 'package:piix_mobile/providers/validator_provider.dart';

enum SignInState {
  signingIn,
  signedIn,
  signedOut,
  signError,
  revokedToken,
  expiredToken,
  error,
}

///Contains the states used by the app in a general context.
class AppBLoC with ChangeNotifier {
  AppThemeMode _mode = AppThemeMode.light;
  AppThemeMode get mode => _mode;
  set mode(AppThemeMode mode) {
    _mode = mode;
    notifyListeners();
  }

  SignInState _signInState = SignInState.signedOut;
  SignInState get signInState => _signInState;
  set signInState(SignInState state) {
    _signInState = state;
    notifyListeners();
  }

  ///This method cleans all states and all SharedPreferences values
  ///as well as signs out from Firebase.
  ///
  ///The parameters are for specific analytics, [trigger] is a
  ///camel case or snake case [String] value that determines what
  ///type of action triggered this method.
  ///If the user is the one initiating the sign out via a button or a specific
  ///voluntary action then pass [userTriggered] as true.
  Future<void> signOut({
    String? trigger,
    bool userTriggered = false,
  }) async {
    PiixAnalytics.instance.logEvent(
      eventName: PiixAnalyticsEvents.signOut,
      eventParameters: {
        PiixAnalyticsParameters.userTrigger:
            PiixAnalyticsValues.yesOrNo(userTriggered),
        PiixAnalyticsParameters.trigger: trigger,
      },
    );
    signInState = SignInState.signedOut;
    getIt<AuthServiceProvider>().clearProvider();
    getIt<AuthUserFormUiProvider>().clearProvider();
    await AppSharedPreferences.clear();
    getIt<FileSystemBLoC>().clearProvider();
    final userBLoC = getIt<UserBLoCDeprecated>();
    if (userBLoC.user != null) {
      getIt<CatalogBLoC>().clearProvider();
      getIt<UiBLoC>().clearProvider();
      getIt<BenefitPerSupplierBLoCDeprecated>().clearProvider();
      //TODO: Delete all use of Basic Form once a new way of filling information of protected is created
      getIt<BasicFormBLoC>().basicFormState = BasicFormState.idle;
      getIt<MembershipProviderDeprecated>().clearProvider();
      userBLoC.clearProvider();
      getIt<ProtectedProvider>().clearProvider();
      getIt<ValidatorProvider>().clearProvider();
      getIt<NavigationProviderDeprecated>().clearProvider();
      getIt<ClaimTicketProvider>().clearProvider();
    }
    NavigatorKeyState().getNavigator()?.pushNamedAndRemoveUntil(
          WelcomeScreen.routeName,
          ModalRoute.withName(WelcomeScreen.routeName),
        );
  }
}

extension FirebaseAppBloC on AppBLoC {
  Future<void> firebaseSignOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      debugPrint('Firebase User could not sign out - ${e.toString()}');
    }
  }
}
