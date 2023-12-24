//All values are in snake capital case as snake case is used
//in firebase analytics and treating the values all in caps
//ensures easy distinction between automatic firebase events
//and custom app events.
class PiixAnalyticsEvents {
  //Verification code
  static const verifyPersonalInformation = 'VERIFY_PERSONAL_INFORMATION';
  static const updateCredential = 'UPDATE_CREDENTIAL';
  //Auth actions
  static const signIn = 'SIGN_IN';
  static const signUp = 'SIGN_UP';
  static const signOut = 'SIGN_OUT';
  static const protectedSignUp = 'PROTECTED_SIGN_UP';
  //User auth forms
  static const enterAuthForm = 'ENTER_AUTH_FORM';
  static const submitAuthForm = 'SUBMITTED_AUTH_FORM';
  static const submitMembershipVerification =
      'SUBMITTED_MEMBERSHIP_VERIFICATION';
  //Navigation
  static const memberships = 'MEMBERSHIPS';
  //Memberships information
  static const membership = 'MEMBERSHIP';
  //Claim tickets
  static const claimTicket = 'CLAIM_TICKET';
  //Auth forms
  static const getAuthFormHelp = 'GET_AUTH_FORM_HELP';
  static const authPersonalInformation = 'AUTH_PERSONAL_INFORMATION';
  static const authProtectedInformation = 'AUTH_PROTECTED_PERSONAL_INFORMATION';
}
