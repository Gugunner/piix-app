import 'package:flutter/material.dart';
import 'package:piix_mobile/auth_feature/auth_ui_screen_barrel_file.dart';
import 'package:piix_mobile/auth_feature/ui/screens/sign_up_sign_in_verification_code_screen_deprecated.dart';
import 'package:piix_mobile/auth_feature/ui/screens/user_loading_screen.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/benefit_per_supplier_screen_barrel_file.dart';
import 'package:piix_mobile/home_loading_screen.dart';
import 'package:piix_mobile/membership_feature/membership_screen_barrel_file.dart';
import 'package:piix_mobile/test_screens/app_bar_screens/app_bar_screens_barrel_file.dart';
import 'package:piix_mobile/test_screens/test_screens_barrel_file.dart';
import 'package:piix_mobile/welcome_screen.dart';
import 'package:piix_mobile/membership_verification_feature/ui/waiting_membership_verification_screen_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/ui/benefit_form_screen_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/ui/benefit_per_supplier_detail/benefit_per_supplier_detail_screen_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/ui/history/claim_ticket_history_screen_builder_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/ui/tracking_and_rating_deprecated/ratings_screen_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/membership_type_builder_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/model/ticket_model.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/memberships_screen_deprecated.dart';
import 'package:piix_mobile/membership_verification_feature/ui/membership_verification_screen_deprecated.dart';
import 'package:piix_mobile/onboarding_feature/ui/onboarding_pages_screen.dart';
import 'package:piix_mobile/store_feature/ui/payments/payment_receipt_home_screen_deprecated.dart';
import 'package:piix_mobile/onboarding_feature/ui/onboarding_screen.dart';
import 'package:piix_mobile/protected_feature_deprecated/ui/protected_detail_deprecated.dart';
import 'package:piix_mobile/protected_feature_deprecated/ui/protected_membership_view_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/invoice_ticket_screen_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/payment_line_from_invoice_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/purchase_invoice_history_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/additional_benefit_list_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/additional_benefits_per_supplier_home_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/details/additional_benefit_per_supplier_detail_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/details/package_combo_detail_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/levels/levels_home_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/package_combos/package_combo_home_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/payments/payment_methods_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/plans/plans_home_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/additional_benefit_quotation_home_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/level/level_quotation_home_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/package_combo_quotation_home_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/plans_quotation_home_screen_deprecated.dart';
import 'package:piix_mobile/ui/notifications/notification_screen_deprecated.dart';
import 'package:piix_mobile/ui/pdf/pdf_screen.dart';
import 'package:piix_mobile/ui/tickets_deprecated/guide/ticket_guide_deprecated.dart';
import 'package:piix_mobile/ui/tickets_deprecated/tracking_and_rating_deprecated/tracking_screen_deprecated.dart';
import 'package:piix_mobile/user_form_feature/ui/user_documentation_form_screen_deprecated.dart';
import 'package:piix_mobile/user_form_feature/ui/user_personal_information_verification_code_screen.dart';
import 'package:piix_mobile/user_form_feature/ui/user_personal_information_form_screen_deprecated.dart';
import 'package:piix_mobile/verification_code_feature/ui/verification_code_screen_builder_deprecated.dart';

///Handles all app routes that are registered inside the property [routes]
///of the root [MaterialApp] component.
final class RegisteredRouteUtils {
//TODO: Split routes in modules
  /// Returns all declared app routes with the name.
  static Map<String, WidgetBuilder> getAppRoutes() {
    return <String, WidgetBuilder>{
      //TODO: organize screens per module
      //Home Screen
      WelcomeScreen.routeName: (context) => const WelcomeScreen(),
      HomeLoadingScreen.routeName: (context) => const HomeLoadingScreen(),
      //Sign In Screens
      SignInScreen.routeName: (context) => const SignInScreen(),
      //Sign Up Screens
      CreateAccountScreen.routeName: (context) => const CreateAccountScreen(),
      PersonalInformationFormScreen.routeName: (context) =>
          const PersonalInformationFormScreen(),
      DocumentationFormScreen.routeName: (context) =>
          const DocumentationFormScreen(),
      SuccessfulMembershipVerificationSubmissionScreen.routeName: (context) =>
          SuccessfulMembershipVerificationSubmissionScreen(),
      WaitingMembershipReviewScreen.routeName: (context) =>
          const WaitingMembershipReviewScreen(),
      OnboardingScreen.routeName: (context) => const OnboardingScreen(),
      OnboardingPagesScreen.routeName: (context) =>
          const OnboardingPagesScreen(),
      //Sign In Screens
      UserLoadingScreen.routeName: (context) => UserLoadingScreen(context),
      //Membership Screens
      MembershipLoadingScreen.routeName: (context) =>
          MembershipLoadingScreen(context),
      MembershipHomeScreen.routeName: (context) => const MembershipHomeScreen(),
      BlankMembershipHomeScreen.routeName: (context) =>
          const BlankMembershipHomeScreen(),
      LinkupMembershipScreen.routeName: (context) =>
          const LinkupMembershipScreen(),
      MyAssistancesScreen.routeName: (context) => const MyAssistancesScreen(),
      //My Group Screens
      //Store Screens
      //Profile Screens
      //Legal Screens
      TermsAndConditionsScreen.routeName: (context) =>
          const TermsAndConditionsScreen(),

      ///Old screens
      PDFDetailScreen.routeName: (context) => const PDFDetailScreen(),
      UserPersonalInformationVerificationCodeScreen.routeName: (context) =>
          const UserPersonalInformationVerificationCodeScreen(),
      //STORE ROUTES

      //Deprecated Screens
      SignUpSignInVerificationCodeScreenDeprecated.routeName: (context) =>
          const SignUpSignInVerificationCodeScreenDeprecated(),
      VerificationCodeScreenBuilderDeprecated.routeName: (context) =>
          const VerificationCodeScreenBuilderDeprecated(),
      MembershipVerificationScreenDeprecated.routeName: (context) =>
          const MembershipVerificationScreenDeprecated(),
      UserPersonalInformationFormScreenDeprecated.routeName: (context) =>
          const UserPersonalInformationFormScreenDeprecated(),
      UserDocumentationFormScreenDeprecated.routeName: (context) =>
          UserDocumentationFormScreenDeprecated(),
      WaitingMembershipVerificationScreenDeprecated.routeName: (context) =>
          const WaitingMembershipVerificationScreenDeprecated(),
      MembershipLastGradeBenefitsScreenDeprecated.routeName: (context) =>
          const MembershipLastGradeBenefitsScreenDeprecated(),
      MembershipTypeBuilderDeprecated.routeName: (context) =>
          const MembershipTypeBuilderDeprecated(),
      BenefitPerSupplierDetailScreenDeprecated.routeName: (context) =>
          const BenefitPerSupplierDetailScreenDeprecated(),
      NotificationsScreenDeprecated.routeName: (context) =>
          const NotificationsScreenDeprecated(),
      BenefitFormScreenDeprecated.routeName: (context) =>
          const BenefitFormScreenDeprecated(),
      MembershipsScreenDeprecated.routeName: (context) =>
          const MembershipsScreenDeprecated(),
      ProtectedDetailDeprecated.routeName: (context) =>
          const ProtectedDetailDeprecated(),
      ClaimTicketHistoryScreenBuilderDeprecated.routeName: (context) =>
          const ClaimTicketHistoryScreenBuilderDeprecated(),
      RatingsScreenDeprecated.routeName: (context) =>
          const RatingsScreenDeprecated(),
      TrackingScreenDeprecated.routeName: (context) => TrackingScreenDeprecated(
            ticket: TicketModel(
              ticketId: '',
              status: TicketStatus.unknown,
              registerDate: DateTime.now(),
            ),
          ),
      TicketGuideDeprecated.routeName: (context) => const TicketGuideDeprecated(
            isBenefit: false,
          ),
      ProtectedMembershipViewDeprecated.routeName: (context) =>
          const ProtectedMembershipViewDeprecated(),
      AdditionalBenefitsPerSupplierHomeScreenDeprecated.routeName: (context) =>
          const AdditionalBenefitsPerSupplierHomeScreenDeprecated(),
      AdditionalBenefitListScreenDeprecated.routeName: (context) =>
          const AdditionalBenefitListScreenDeprecated(),
      AdditionalBenefitPerSupplierDetailScreenDeprecated.routeName: (context) =>
          const AdditionalBenefitPerSupplierDetailScreenDeprecated(),
      PackageComboHomeScreenDeprecated.routeName: (context) =>
          const PackageComboHomeScreenDeprecated(),
      PackageComboDetailScreenDeprecated.routeName: (context) =>
          const PackageComboDetailScreenDeprecated(),
      AdditionalBenefitQuotationHomeScreenDeprecated.routeName: (context) =>
          const AdditionalBenefitQuotationHomeScreenDeprecated(),
      PackageComboQuotationHomeScreenDeprecated.routeName: (context) =>
          const PackageComboQuotationHomeScreenDeprecated(),
      PaymentMethodsScreenDeprecated.routeName: (context) =>
          const PaymentMethodsScreenDeprecated(),
      PlansHomeScreenDeprecated.routeName: (context) =>
          const PlansHomeScreenDeprecated(),
      PlanQuotationHomeScreenDeprecated.routeName: (context) =>
          const PlanQuotationHomeScreenDeprecated(),
      LevelsHomeScreenDeprecated.routeName: (context) =>
          const LevelsHomeScreenDeprecated(),
      LevelQuotationHomeScreenDeprecated.routeName: (context) =>
          const LevelQuotationHomeScreenDeprecated(),
      PaymentReceiptHomeScreenDeprecated.routeName: (context) =>
          const PaymentReceiptHomeScreenDeprecated(),
      PurchaseInvoiceHistoryScreenDeprecated.routeName: (context) =>
          const PurchaseInvoiceHistoryScreenDeprecated(),
      InvoiceTicketScreenDeprecated.routeName: (context) =>
          const InvoiceTicketScreenDeprecated(),
      PaymentLineFromInvoiceDeprecated.routeName: (context) =>
          const PaymentLineFromInvoiceDeprecated(),
    };
  }

  static Map<String, WidgetBuilder> getTestRoutes() {
    return <String, WidgetBuilder>{
      TestScreen.routeName: (context) => const TestScreen(),
      AppButtonScreen.routeName: (context) => const AppButtonScreen(),
      AppBannerScreen.routeName: (context) => const AppBannerScreen(),
      AppTagScreen.routeName: (context) => const AppTagScreen(),
      BranchAppIconTagScreen.routeName: (context) =>
          const BranchAppIconTagScreen(),
      AppBarScreen.routeName: (context) => const AppBarScreen(),
      TooltipAppBarScreen.routeName: (context) => const TooltipAppBarScreen(),
      LogoAppBarScreen.routeName: (context) => const LogoAppBarScreen(),
      NotificationsAppBarScreen.routeName: (context) =>
          const NotificationsAppBarScreen(),
      SimpleAppBarScreen.routeName: (context) => const SimpleAppBarScreen(),
      AppCardScreen.routeName: (context) => const AppCardScreen(),
      AppModalScreen.routeName: (context) => const AppModalScreen(),
      AppTextFieldScreen.routeName: (context) => const AppTextFieldScreen(),
    };
  }

  static void appBarNav({required BuildContext context}) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        MembershipsScreenDeprecated.routeName, (route) => false);
  }
}
