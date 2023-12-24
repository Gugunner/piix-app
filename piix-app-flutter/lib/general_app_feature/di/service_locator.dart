import 'package:camera/camera.dart';
import 'package:get_it/get_it.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/data/repository/auth_service_repository.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/data/service/auth_service_api_deprecated.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_service_provider_deprecated.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/data/repository/auth_user_form_repository.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/data/service/auth_user_form_api.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/domain/provider/auth_user_form_ui_provider.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/data/repository/benefit_form_repository_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/data/repository/benefit_per_supplier_repository.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/data/service/benefit_form_api.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/data/service/benefit_per_supplier_api.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/data/repository/claim_ticket_repository_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/data/service/claim_ticket_api.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/providers/claim_ticket_provider.dart';
import 'package:piix_mobile/data/datasource/auth_repository_impl.dart';
import 'package:piix_mobile/data/datasource/benefit_per_supplier_repository_impl.dart';
import 'package:piix_mobile/data/datasource/protected_repository_impl.dart';
import 'package:piix_mobile/data/datasource/user_repository_impl_deprecated.dart';
import 'package:piix_mobile/email_feature/data/repository/email_system_repository.dart';
import 'package:piix_mobile/email_feature/data/service/email_system_api.dart';
import 'package:piix_mobile/email_feature/domain/bloc/email_system_bloc.dart';
import 'package:piix_mobile/general_app_feature/data/repository/catalog_repository.dart';
import 'package:piix_mobile/general_app_feature/data/repository/file_system_repository_deprecated.dart';
import 'package:piix_mobile/general_app_feature/data/service/catalog_api.dart';
import 'package:piix_mobile/general_app_feature/data/service/file_system_api_deprecated.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/app_bloc.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/catalog_bloc.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/connectivity_bloc.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/file_system_bloc.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/notification_bloc.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/ui_bloc.dart';
import 'package:piix_mobile/general_app_feature/navigation_deprecated/navigation_provider_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/data/repository/ip_repository_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/data/service_deprecated/ip_api_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/domain/bloc/camera_bloc.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/basic_form_repository.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/membership_info_repository_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/package_repository.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/ticket_repository.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/user_repository_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/service/basic_form_api.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/service/membership_info_api.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/service/package_api.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/service/ticket_api.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/service/user_api.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/basic_form_bloc.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:piix_mobile/protected_feature_deprecated/data/repository/protected_form_repository.dart';
import 'package:piix_mobile/protected_feature_deprecated/data/repository/protected_repository.dart';
import 'package:piix_mobile/protected_feature_deprecated/data/service/protected_api.dart';
import 'package:piix_mobile/protected_feature_deprecated/data/service/protected_form_api.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/bloc/protected_provider.dart';
import 'package:piix_mobile/providers/validator_provider.dart';
import 'package:piix_mobile/purchase_invoice_feature/data/repository/purchase_invoices_repository_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/data/service/purchase_invoice_api.dart';
import 'package:piix_mobile/store_feature/data/repository/additional_benefits_per_supplier/additional_benefits_per_supplier_repository_deprecated.dart';
import 'package:piix_mobile/store_feature/data/repository/levels_deprecated/levels_repository_deprecated.dart';
import 'package:piix_mobile/store_feature/data/repository/package_combos/package_combos_repository.dart';
import 'package:piix_mobile/store_feature/data/repository/payments/payments_repository_deprecated.dart';
import 'package:piix_mobile/store_feature/data/repository/plans/plans_repository.dart';
import 'package:piix_mobile/store_feature/data/service/additional_benefits_per_supplier_api.dart';
import 'package:piix_mobile/store_feature/data/service/combos_api.dart';
import 'package:piix_mobile/store_feature/data/service/levels_api.dart';
import 'package:piix_mobile/store_feature/data/service/payments_api.dart';
import 'package:piix_mobile/store_feature/data/service/plans_api.dart';
import 'package:piix_mobile/general_app_feature/utils/app_use_case_test.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerSingleton(
    AppUseCaseTestFlag(),
  );
  getIt.registerSingleton(AuthServiceProvider());
  getIt.registerSingleton(AuthUserFormUiProvider());
  getIt.registerSingleton(ValidatorProvider());
  getIt.registerSingleton(NavigationProviderDeprecated());
  getIt.registerSingleton(AppBLoC());
  getIt.registerSingleton(CatalogBLoC());
  getIt.registerSingleton(FileSystemBLoC());
  getIt.registerSingleton(EmailSystemBLoC());
  getIt.registerSingleton(UiBLoC());
  getIt.registerSingleton(ConnectivityBLoC());
  getIt.registerSingleton(
    BenefitPerSupplierBLoCDeprecated(
      interface: BenefitPerSupplierRepositoryImpl(),
    ),
  );
  getIt.registerSingleton(
    BasicFormBLoC(),
  );
  getIt.registerSingleton(UserBLoCDeprecated());
  getIt.registerSingleton(MembershipProviderDeprecated());
  getIt.registerSingleton(
    ProtectedProvider(
      interface: ProtectedRepositoryImpl(),
    ),
  );
  getIt.registerSingleton(NotificationBLoC());
  getIt.registerSingleton(ClaimTicketProvider());
  setupRepositories();
  setUpTemporalRepositories();
  await setUpPlatformTools();
}

Future<void> setupRepositories() async {
  getIt.registerSingleton(AuthServiceApiDeprecated());
  getIt.registerSingleton(
      AuthServiceRepository(getIt<AuthServiceApiDeprecated>()));
  getIt.registerSingleton(AuthUserFormApi());
  getIt.registerSingleton(AuthUserFormRepository(getIt<AuthUserFormApi>()));
  getIt.registerSingleton(IpApiDeprecated());
  getIt.registerSingleton(IpRepositoryDeprecated(getIt<IpApiDeprecated>()));
  getIt.registerSingleton(PackageApi());
  getIt.registerSingleton(PackageRepository(getIt<PackageApi>()));
  getIt.registerSingleton(UserApi());
  getIt.registerSingleton(UserRepositoryDeprecated(getIt<UserApi>()));
  getIt.registerSingleton(MembershipInfoApi());
  getIt.registerSingleton(
      MembershipInfoRepositoryDeprecated(getIt<MembershipInfoApi>()));
  getIt.registerSingleton(BenefitPerSupplierApi());
  getIt.registerSingleton(
      BenefitPerSupplierRepositoryDeprecated(getIt<BenefitPerSupplierApi>()));
  getIt.registerSingleton(FileSystemApiDeprecated());
  getIt.registerSingleton(
      FileSystemRepositoryDeprecated(getIt<FileSystemApiDeprecated>()));
  getIt.registerSingleton(EmailSystemApi());
  getIt.registerSingleton(EmailSystemRepository(getIt<EmailSystemApi>()));
  getIt.registerSingleton(CatalogApi());
  getIt.registerSingleton(CatalogRepository(getIt<CatalogApi>()));
  getIt.registerSingleton(BasicFormApi());
  getIt.registerSingleton(BasicFormRepository(getIt<BasicFormApi>()));
  getIt.registerSingleton(TicketApi());
  getIt.registerSingleton(TicketRepository(getIt<TicketApi>()));
  getIt.registerSingleton(BenefitFormApi());
  getIt.registerSingleton(
      BenefitFormRepositoryDeprecated(getIt<BenefitFormApi>()));
  getIt.registerSingleton(AdditionalBenefitsPerSupplierApi());
  getIt.registerSingleton(AdditionalBenefitsPerSupplierRepositoryDeprecated(
      getIt<AdditionalBenefitsPerSupplierApi>()));
  getIt.registerSingleton(PackageCombosApi());
  getIt.registerSingleton(PackageCombosRepository(getIt<PackageCombosApi>()));
  getIt.registerSingleton(PlansApi());
  getIt.registerSingleton(PlansRepositoryDeprecated(getIt<PlansApi>()));
  getIt.registerSingleton(LevelsApi());
  getIt.registerSingleton(LevelsRepositoryDeprecated(getIt<LevelsApi>()));
  getIt.registerSingleton(PaymentsApi());
  getIt.registerSingleton(PaymentsRepositoryDeprecated(getIt<PaymentsApi>()));
  getIt.registerSingleton(PurchaseInvoiceApi());
  getIt.registerSingleton(
      PurchaseInvoiceRepositoryDeprecated(getIt<PurchaseInvoiceApi>()));
  getIt.registerSingleton(ClaimTicketApi());
  getIt.registerSingleton(ClaimTicketRepository(getIt<ClaimTicketApi>()));
  getIt.registerSingleton(ProtectedApi());
  getIt.registerSingleton(
    ProtectedRepository(
      getIt<ProtectedApi>(),
    ),
  );
  getIt.registerSingleton(ProtectedFormApi());
  getIt.registerSingleton(
    ProtectedFormRepository(
      getIt<ProtectedFormApi>(),
    ),
  );
}

//Use as a temporary solution while the app changes all repository implementations to data and domain
Future<void> setUpTemporalRepositories() async {
  getIt.registerSingleton(AuthRepositoryImpl());
  getIt.registerSingleton(UserRepositoryImplDeprecated());
}

Future<void> setUpPlatformTools() async {
  try {
    final cameras = await availableCameras();
    getIt.registerSingleton(CameraBLoC(cameras));
    print('Success');
  } catch (e) {
    print('Could not initialize cameras');
  }
}
