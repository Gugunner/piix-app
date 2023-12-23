import 'package:piix_mobile/animator_bloc.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_service_provider_deprecated.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/domain/provider/auth_user_form_ui_provider.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/providers/claim_ticket_provider.dart';
import 'package:piix_mobile/email_feature/domain/bloc/email_system_bloc.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/animation_bloc_deprecated.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/app_bloc.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/catalog_bloc.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/connectivity_bloc.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/file_system_bloc.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/home_provider.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/notification_bloc.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/ui_bloc.dart';
import 'package:piix_mobile/general_app_feature/navigation_deprecated/navigation_provider_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/basic_form_bloc.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_alert_ui_provider.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/bloc/protected_provider.dart';
import 'package:piix_mobile/providers/animator_provider.dart';
import 'package:piix_mobile/providers/validator_provider.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/bloc_deprecated/purchase_invoice_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/additional_benefits_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/levels_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/package_combos_bloc.dart';
import 'package:piix_mobile/store_feature/domain/bloc/payments_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/plans_bloc_deprecated.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

//TODO: Delete all interfaces from the BLoCs and instead use GetIt
/// Returns a service implementations and BLoCs components for the all app.
List<SingleChildWidget> getProviderList() {
  return [
    ChangeNotifierProvider(create: (context) => getIt<AuthServiceProvider>()),
    ChangeNotifierProvider(
        create: (context) => getIt<AuthUserFormUiProvider>()),
    ChangeNotifierProvider(create: (context) => getIt<AppBLoC>()),
    ChangeNotifierProvider(create: (context) => getIt<CatalogBLoC>()),
    ChangeNotifierProvider(create: (context) => getIt<FileSystemBLoC>()),
    ChangeNotifierProvider(create: (context) => getIt<EmailSystemBLoC>()),
    ChangeNotifierProvider(create: (context) => getIt<UiBLoC>()),
    ChangeNotifierProvider(
        create: (context) => getIt<BenefitPerSupplierBLoCDeprecated>()),
    ChangeNotifierProvider(create: (context) => getIt<BasicFormBLoC>()),
    ChangeNotifierProvider(
        create: (context) => getIt<MembershipProviderDeprecated>()),
    ChangeNotifierProvider(create: (context) => getIt<UserBLoCDeprecated>()),
    ChangeNotifierProvider(create: (context) => getIt<ProtectedProvider>()),
    ChangeNotifierProvider(create: (context) => getIt<NotificationBLoC>()),
    ChangeNotifierProvider(create: (context) => getIt<ConnectivityBLoC>()),
    ChangeNotifierProvider(create: (context) => getIt<ValidatorProvider>()),
    ChangeNotifierProvider(create: (context) => AnimatorProvider()),
    ChangeNotifierProvider(create: (context) => AnimatorBLoC()),
    ChangeNotifierProvider(
        create: (_) => AdditionalBenefitsPerSupplierBLoCDeprecated()),
    ChangeNotifierProvider(create: (_) => PackageComboBLoC()),
    ChangeNotifierProvider(create: (_) => AnimationBLoCDeprecated()),
    ChangeNotifierProvider(create: (_) => PlansBLoCDeprecated()),
    ChangeNotifierProvider(create: (_) => LevelsBLoCDeprecated()),
    ChangeNotifierProvider(create: (_) => PaymentsBLoCDeprecated()),
    ChangeNotifierProvider(create: (_) => PurchaseInvoiceBLoCDeprecated()),
    ChangeNotifierProvider(
        create: (_) => getIt<NavigationProviderDeprecated>()),
    ChangeNotifierProvider(create: (_) => HomeProvider()),
    ChangeNotifierProvider(create: (_) => MembershipAlertUiProvider()),
    ChangeNotifierProvider(create: (_) => ClaimTicketProvider()),
  ];
}
