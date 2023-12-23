import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/ui/membership_type_builder_deprecated.dart';
import 'package:piix_mobile/navigation_feature/navigation_utils_barrel_file.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/bloc_deprecated/purchase_invoice_bloc_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/utils/product_type_enum_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/utils/invoice_navigation_utils.dart';
import 'package:piix_mobile/store_feature/ui/plans/managing_deprecated/plan_ui_state_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/animation/animated_navigation_util.dart';
import 'package:provider/provider.dart';

///The base class of [NavigatorKeyState] that
///contains all calculated and declared properties.
base class _NavigatorKeyBase {
  late GlobalKey<NavigatorState> _navigatorKey;
  late GlobalKey<NavigatorState> _originalNavigatorKey;
  GlobalKey<NavigatorState> get currentNavigatorKey => _navigatorKey;

  ///Returns the [NavigatorState] of the [_navigatorKey]
  ///currentState if not null if not it reads the [currentContext]
  ///of [BuildContextStateContext] and returns the [Navigator]
  ///as a safeguard measuer.
  NavigatorState? getNavigator([BuildContext? context]) {
    //Checks if the currentNavigatorKey has a state value
    //of NavigatorState
    if (currentNavigatorKey.currentState != null) {
      return currentNavigatorKey.currentState!;
    }
    //If no value is found it reads the passed context and returns
    //the NavigatorState of the context by reading the state of the
    //Navigator Stateful Widget.
    if (context != null) return Navigator.of(context);
    return null;
  }

  ///Stores a new key with [NavigatorState].
  void setNavigatorKey(GlobalKey<NavigatorState> key) {
    _navigatorKey = key;
  }

  ///Resets the value to the [_originalNavigatorKey].
  void reset() {
    _navigatorKey = _originalNavigatorKey;
  }
}

///A class that stores the [navigatorKey] used inside the root [MaterialApp]
///to manipulate route navigation.
final class NavigatorKeyState extends _NavigatorKeyBase {
  static final NavigatorKeyState _instance = NavigatorKeyState._singleton();

  factory NavigatorKeyState() => _instance;

  NavigatorKeyState._singleton() {
    final navigatorKey = GlobalKey<NavigatorState>();
    _originalNavigatorKey = navigatorKey;
    reset();
  }

  @Deprecated('Will be removed in 4.0')
  void confirmNavigateToSpecificModule(
      BuildContext context, PlanUiStateDeprecated? planUiState) {
    final purchaseInvoiceBLoC = context.read<PurchaseInvoiceBLoCDeprecated>();
    final currentInvoiceTicket = purchaseInvoiceBLoC.invoice;
    switch (currentInvoiceTicket?.userQuotation.productType) {
      case ProductTypeDeprecated.LEVEL:
        ticketToLevelQuotation(context);
        break;
      case ProductTypeDeprecated.PLAN:
        if (planUiState != null) ticketToPlanQuotation(context, planUiState);
        break;
      case ProductTypeDeprecated.ADDITIONAL:
        ticketToAdditionalBenefitQuotation(context);
        break;
      case ProductTypeDeprecated.COMBO:
        ticketToComboQuotation(context);
        break;
      default:
    }
  }

  @Deprecated('Will be removed in 4.0')
  void navigateToHomeRoute() {
    getNavigator()?.popUntil(
        ModalRoute.withName(MembershipTypeBuilderDeprecated.routeName));
  }

  //***********AnimatedNavigation***********************//

  ///Using a [page] based on a [Widget] and the
  ///it pushes the route using [PageRouteBuilder]
  ///to create a custom transition.

  ///Slide from left to right
  Future<T?> slideToRightRoute<T>({
    required Widget page,
    required String routeName,
    bool replaceAll = false,
    BuildContext? context,
    Duration? transitionDuration,
  }) async {
    final route = SimpleSlideToRightRoute<T>(
      page: page,
      transitionDuration: transitionDuration,
    );
    if (replaceAll && context != null) {
      return getNavigator(context)?.pushAndRemoveUntil(
        route,
        ModalRoute.withName(routeName),
      );
    }
    return getNavigator()?.push(route);
  }

  ///Slide from left to right
  Future<T?> slideToLeftRoute<T>({
    required Widget page,
    required String routeName,
    bool replaceAll = false,
    BuildContext? context,
    Duration? transitionDuration,
  }) async {
    final route = SimpleSlideToLeftRoute<T>(
      page: page,
      transitionDuration: transitionDuration,
    );
    if (replaceAll && context != null) {
      return getNavigator(context)?.pushAndRemoveUntil(
        route,
        ModalRoute.withName(routeName),
      );
    }
    return getNavigator()?.push(route);
  }

  ///Slide from bottom to top
  Future<T?> slideToTopRoute<T>({
    required Widget page,
    required String routeName,
    bool replaceAll = false,
    BuildContext? context,
    Duration? transitionDuration,
  }) async {
    final route = SimpleSlideToTopRoute<T>(
      page: page,
      transitionDuration: transitionDuration,
    );
    if (replaceAll && context != null) {
      return getNavigator(context)?.pushAndRemoveUntil(
        route,
        ModalRoute.withName(routeName),
      );
    }
    return getNavigator()?.push(route);
  }

  //Dissolve in
  Future<T?> fadeInRoute<T>({
    required Widget page,
    required String routeName,
    bool replaceAll = false,
    BuildContext? context,
    Duration? transitionDuration,
  }) async {
    final route = SimpleFadeInRoute<T>(
        page: page, transitionDuration: transitionDuration);
    if (replaceAll && context != null) {
      return getNavigator(context)?.pushAndRemoveUntil(
        route,
        ModalRoute.withName(routeName),
      );
    }
    return getNavigator()?.push(route);
  }

  ///Slide top route navigation method
  //TODO: Refactor Transition and add push and pushAndRemoveUntil in same method

  Future<T?>? slideTopNavigateTo<T>(Widget routeScreen) {
    return getNavigator()?.push<T>(SlideTopRoute<T>(page: routeScreen));
  }
}
