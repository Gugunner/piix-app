//Api Error Codes For Auth Inputs
const String apiInvalidCredential = 'INVALID_USER_CREDENTIAL';

const String apiInvalidAppFlow = 'INVALID_APP_FLOW_FOR_CREDENTIALS';

const String apiEmailAlreadyUsed = 'EMAIL_ALREADY_USED';

const String apiPhoneAlreadyUsed = 'PHONE_NUMBER_ALREADY_USED';

const String apiUserNotFoundWithCredential =
    'NOT_FOUND_USER_FOR_GIVEN_CREDENTIAL';

//Api Error Codes for Verification Code Input
const String apiWrongVerificationCode = 'INVALID_USER_CODE_VERIFICATION';

//Api Error Codes for linkup code to community
const String apiInvalidLinkupCode = 'INVALID_LINKUP_CODE';

const String apiUserIsAlreadyInTheCommunity = 'USER_ALREADY_HAS_PACKAGEID';

const String apiUserIsAlreadyInACommunity =
    'USER_HAS_MEMBERSHIP_LINKED_TO_A_COLLECTIVE_PACKAGE';

//Api Error Codes for invitation code to a family group
const String apiInvalidInvitationCode = 'INVALID_INVITATION_CODE';

const String apiUserCannotUseSlot = 'USER_CAN_NOT_USE_SLOT';

const String apiUserIsAlreadyInGroup = 'USER_IS_ALREADY_RELATED_TO_A_GROUP';

const String apiSlotIsNotOpen = 'SLOT_HAS_NOT_INVITED_STATUS';

//Api Error Codes for password input
const String apiInvalidPassword = 'PASSWORD_NOT_VALID';

//General Api Error
const String apiInvalidBodyRequest = 'INVALID_BODY_REQUEST_STRUCTURE';
