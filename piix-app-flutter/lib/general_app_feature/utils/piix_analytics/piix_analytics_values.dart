class PiixAnalyticsValues {
  //Forms
  static const personalInformationForm = 'PERSONAL_INFORMATION_FORM';
  static const documentationForm = 'DOCUMENTATION_FORM';
  static const protectedRegisterForm = 'PROTECTED_REGISTER_FORM';
  //Boolean affirmations
  static const yes = 'YES';
  static const no = 'NO';
  static String yesOrNo(bool value) =>
      value ? PiixAnalyticsValues.yes : PiixAnalyticsValues.no;
  //Screen triggers
  static const waitingVerification = 'WAITING_VERIFICATION';
  static const onboarding = 'ONBOARDING';
  //Auth sign out triggers
  static const failedToObtainUser = 'USER_BY_USERNAME_CREDENTIAL';
  static const invalidFirebaseToken = 'INVALID_FIREBASE_TOKEN';
  static const invalidLoggedUser = 'INVALID_LOGGED_USER';
  static const failedToObtainCustomAccessToken =
      'FAILED_TO_OBTAIN_CUSTOM_ACCESS_TOKEN';
  static const failedFirebaseCustomSignIn = 'FAILED_FIREBASE_CUSTOM_SIGN_IN';
  static const userSignOut = 'USER_SIGN_OUT';
  //Claim tickets
  static const createTicket = 'CREATE_TICKET';
  static const cancelTicket = 'CANCEL_TICKET';
  static const closeTicket = 'CLOSE_TICKET';
  static const followUpTicket = 'FOLLOW_UP_TICKET';
  static const sos = 'SOS';
  static const benefitPerSupplier = 'BENEFIT_PER_SUPPLIER';
  static const cobenefitPerSupplier = 'COBENEFIT_PER_SUPPLIER';
  static const additionalBenefitPerSupplier = 'ADDITIONAL_BENEFIT_PER_SUPPLIER';
  static const none = 'NONE';
    //Help Channels
  static const whatsapp = 'WHATSAPP';
  static const phone = 'PHONE';
}
