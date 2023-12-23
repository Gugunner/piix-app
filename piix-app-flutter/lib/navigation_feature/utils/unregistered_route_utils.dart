import 'package:flutter/material.dart';
import 'package:piix_mobile/auth_feature/auth_ui_screen_barrel_file.dart';
import 'package:piix_mobile/auth_feature/auth_utils_barrel_file.dart';
import 'package:piix_mobile/membership_feature/membership_model_barrel_file.dart';
import 'package:piix_mobile/membership_feature/membership_screen_barrel_file.dart';
import 'package:piix_mobile/navigation_feature/navigation_utils_barrel_file.dart';

///Handles all routes that are not registered inside the [routes]
///property of the root [MaterialApp] and that pass over some [arguments].
final class UnregisteredRouteUtils {
//ROUTES THAT RECEIVE ARGUMENTS AND ARE NOT DECLARED IN getAppRoutes()
  static Route<dynamic>? _navigateToSuccessLinkupMembershipScreen(
      RouteSettings settings) {
    final linkModel = settings.arguments as LinkupCodeTypeModel;
    return SimpleFadeInRoute(
        page: SuccessLinkupMembershipScreen(
      linkupModel: linkModel,
    ));
  }

  static Route<dynamic>? _navigateToVerifyVerificationCodeScreen(
      RouteSettings settings) {
    final (phoneNumber, verificationType) =
        settings.arguments as (String, VerificationType);
    return SimpleSlideToLeftRoute(
      page: VerifyVerificationCodeScreen(
        phoneNumber: phoneNumber,
        verificationType: verificationType,
      ),
    );
  }

  ///Handles all named routes that are not defined in [getAppRoutes]
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final name = settings.name;
    //TODO: Add non named route error screen
    if (name == null) return null;
    switch (name) {
      case SuccessLinkupMembershipScreen.routeName:
        return _navigateToSuccessLinkupMembershipScreen(settings);
      case VerifyVerificationCodeScreen.routeName:
        return _navigateToVerifyVerificationCodeScreen(settings);
      default:
        //TODO: Add non named route error screen
        return null;
    }
  }
}
