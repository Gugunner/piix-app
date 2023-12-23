import 'package:piix_mobile/app_config.dart';

///This class contains all the end points of the application as well as a list
///of them.
class EndPoints {
  static AppConfig get appConfig => AppConfig.instance;
  //=============================== Send Verification Code =============================//
  static final String termsAndConditionEndpoint =
      '${appConfig.backendEndpoint}/legal/termsAndConditions';
  //=============================== Register Form ===============================//
  static final String getPersonalInformationFormEndpoint =
      '${appConfig.catalogEndpoint}/mainUserForms?mainUserInfoFormId=basicInsuredForm';

  static final String getDocumentationFormEndpoint =
      '${appConfig.catalogEndpoint}/mainUserForms?mainUserInfoFormId=userDocumentationForm';

  static final String sendBasicInformationFormEndpoint =
      '${appConfig.backendEndpoint}/user/mainForms/basicInformation';

  //=============================== Confirm User Main Forms ===============================//
  static final String confirmUserMainForms =
      '${appConfig.backendEndpoint}/user/mainForms/confirm';
  //=============================== Membership Feature =========================//
  static final String getLinkupCodeTypeEndpoint =
      '${appConfig.backendEndpoint}/users/memberships/linkupCodeInfo';

  static final String linkupMembershipByCodeEndpoint =
      '${appConfig.backendEndpoint}/users/memberships/linkupByCode';

  static final String linkUserToSlotEndpoint =
      '${appConfig.backendEndpoint}/userGroups/linkUser';

  static final String getUserMembershipsEndpoint =
      '${appConfig.backendEndpoint}/users/membership';

  static final String getMembershipBenefitsEndpoint =
      '${appConfig.backendEndpoint}/users/memberships/benefits';

  static final String getMembershipNotificationsEndpoint =
      '${appConfig.backendEndpoint}/users/memberships/notifications';

  //================================ File Feature ==============================//

  static final String getFileEndpoint =
      '${appConfig.backendEndpoint}/files/get/fromPath';

  static final String sendFileEndpoint =
      '${appConfig.catalogEndpoint}/upload/file';

  //=============================== STORES ROUTE =============================//
  //=========> ADDITIONAL BENEFITS PER SUPPLIER <=========//
  static final String additionalBenefitsPerSupplierByMembership =
      '${appConfig.backendEndpoint}/additional-benefits-per-supplier/user/byMembership?';
  static final String addittionalBenefitsPerSupplierQuotation =
      '${appConfig.backendEndpoint}/additional-benefits-per-supplier/user/membership/'
      'detailsAndPrices?';
  //=========> PACKAGE COMBOS <=========//
  static final String packageCombosByMembership =
      '${appConfig.backendEndpoint}/package-combos/user/byMembership?';
  static final String packageComboQuotationByMembership =
      '${appConfig.backendEndpoint}/package-combos/user/membership/detailsAndPrices?';
  //=========> PLANS <=========//
  static final String plansByMembership =
      '${appConfig.backendEndpoint}/plans/user/all?';
  static final String plansQuotationByMembership =
      '${appConfig.backendEndpoint}/plans/user/membership/quotation?';
  //=========> LEVELS <=========//
  static final String levelsByMembership =
      '${appConfig.backendEndpoint}/levels/user/all?';
  static final String levelsQuotationByMembership =
      '${appConfig.backendEndpoint}/levels/user/membership/quotation?';
  static final getLevelsAndPlansEndpoint =
      '${appConfig.backendEndpoint}/users/getPlanAndLevelForMemberships?';
  //=========> PAYMENTS <=========//
  static final String paymentsMethods =
      '${appConfig.paymentEndpoint}/payment/methods';
  static final String makeUserPayment =
      '${appConfig.paymentEndpoint}/payment/user';
  static final String cancelUserPayment =
      '${appConfig.paymentEndpoint}/payment/user/cancel';
  //==========> PURCHASE INVOICES <===========//
  static final String getPurchaseInvoicesByMembership =
      '${appConfig.backendEndpoint}/purchaseInvoices/users/membership?';
  static final String getAdditionalBenefitPurchaseInvoiceById =
      '${appConfig.backendEndpoint}/purchaseInvoices/users/membership/additionalBenefitPerSupplier?';
  static final String getPackageComboPurchaseInvoiceById =
      '${appConfig.backendEndpoint}/purchaseInvoices/users/membership/combo?';
  static final String getLevelPurchaseInvoiceById =
      '${appConfig.backendEndpoint}/purchaseInvoices/users/membership/level?';
  static final String getPlanPurchaseInvoiceById =
      '${appConfig.backendEndpoint}/purchaseInvoices/users/membership/plans?';
  //==========> CLAIM TICKETS <==========//
  static final String cancelClaimTicket =
      '${appConfig.backendEndpoint}/user/membership/ticket/cancel';
  static final String closeClaimTicket =
      '${appConfig.backendEndpoint}/user/membership/ticket/close';
  static final String reportClaimTicketProblem =
      '${appConfig.backendEndpoint}/user/membership/ticket/problem';
  static final String createClaimTicket =
      '${appConfig.backendEndpoint}/user/membership/ticket';
  static final String getTicketHistory =
      '${appConfig.backendEndpoint}/user/membership/ticket/history?';
  //==========================================================================//
  static final List<String> needUserId = [
    //keep
    getPersonalInformationFormEndpoint,
    //keep
    getDocumentationFormEndpoint,
    //keep
    getUserMembershipsEndpoint,
    //keep
    getMembershipBenefitsEndpoint,
    additionalBenefitsPerSupplierByMembership,
    addittionalBenefitsPerSupplierQuotation,
    packageCombosByMembership,
    packageComboQuotationByMembership,
    plansByMembership,
    plansQuotationByMembership,
    levelsByMembership,
    levelsQuotationByMembership,
    getPurchaseInvoicesByMembership,
    getAdditionalBenefitPurchaseInvoiceById,
    getPackageComboPurchaseInvoiceById,
    getLevelPurchaseInvoiceById,
    getPlanPurchaseInvoiceById,
  ];
}
