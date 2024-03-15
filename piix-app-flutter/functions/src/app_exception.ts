import { HttpsError, FunctionsErrorCode } from "firebase-functions/v2/https";

type ModulePrefix = 'auth' | 'store' | 'piix-auth' | 'piix-functions';

type FirebaseAdminAuthErrorCodes = 'unknown' | 'email-already-exists' | 'id-token-expired'
| 'id-token-revoked' | 'invalid-email' | 'invalid-id-token' | 'invalid-uid' | 'too-many-requests'
| 'uid-already-exists' | 'user-not-found';

type FirebaseAdminFirestoreErrorCodes = 'unknown' | 'document-not-added' | 'document-not-created'
| 'document-not-deleted' | 'document-not-set' | 'document-not-updated' | 'document-not-found';

type PiixAuthErrorCodes = 'unknown' | 'email-already-exists' | 'email-not-found' | 'incorrect-verification-code'
| 'custom-token-failed' | 'email-not-sent';

type PiixFunctionsErrorCodes = 'invalid-body' | 'invalid-body-fields';

type ErrorCode = FirebaseAdminAuthErrorCodes | FirebaseAdminFirestoreErrorCodes 
| PiixAuthErrorCodes | PiixFunctionsErrorCodes;

interface SubModule {
  name: string;
  codeNumber: string;
  prefix: ModulePrefix;
  errorCode: ErrorCode;
}

type Module = {[key: string]: SubModule};

const FirebaseAdminAuth: Module = {
	'unknown': {
		name: 'UNKNOWN',
		codeNumber: '0000',
		prefix: 'auth',
		errorCode: 'unknown',
	},
	'email-already-exists': {
		name: 'EMAIL_ALREADY_EXISTS',
		codeNumber: '0001',
		prefix: 'auth',
		errorCode: 'email-already-exists'
	},
	'id-token-expired': {
		name: 'EXPIRED',
		codeNumber: '0002',
		prefix: 'auth',
		errorCode: 'id-token-expired'
	},
	'id-token-revoked': {
		name: 'REVOKED',
		codeNumber: '0003',
		prefix: 'auth',
		errorCode: 'id-token-expired'
	},
	'invalid-email': {
		name: 'INVALID_EMAIL',
		codeNumber: '0004',
		prefix: 'auth',
		errorCode: 'invalid-email',
	},
	'invalid-id-token': {
		name: 'INVALID_TOKEN',
		codeNumber: '0005',
		prefix: 'auth',
		errorCode: 'invalid-id-token',
	},
	'invalid-uid': {
		name: 'INVALID_UID',
		codeNumber: '0004',
		prefix: 'auth',
		errorCode: 'invalid-uid',
	},
	'too-many-requests': {
		name: 'TOO_MANY_REQUESTS',
		codeNumber: '0007',
		prefix: 'auth',
		errorCode: 'too-many-requests',
	},
	'uid-already-exists': {
		name: 'UID_ALREADY_EXISTS',
		codeNumber: '0008',
		prefix: 'auth',
		errorCode: 'uid-already-exists',
	},
	'user-not-found': {
		name: 'NO_USER',
		codeNumber: '0009',
		prefix: 'auth',
		errorCode: 'user-not-found',
	},
}

const FirebaseAdminFirestore: Module = {
	'unknown': {
		name: 'UNKNOWN',
		codeNumber: '0100',
		prefix: 'store',
		errorCode: 'unknown',
	},
	'document-not-added': {
		name: 'DOCUMENT_NOT_ADDED',
		codeNumber: '0101',
		prefix: 'store',
		errorCode: 'document-not-added',
	},
	'document-not-created': {
		name: 'DOCUMENT_NOT_CREATED',
		codeNumber: '0102',
		prefix: 'store',
		errorCode: 'document-not-created',
	},
	'document-not-deleted': {
		name: 'DOCUMENT_NOT_DELETED',
		codeNumber: '0103',
		prefix: 'store',
		errorCode: 'document-not-deleted',
	},
	'document-not-set': {
		name: 'DOCUMENT_NOT_SET',
		codeNumber: '0104',
		prefix: 'store',
		errorCode: 'document-not-set',
	},
	'document-not-updated': {
		name: 'DOCUMENT_NOT_UPDATED',
		codeNumber: '0105',
		prefix: 'store',
		errorCode: 'document-not-updated',
	},
	'document-not-found': {
		name: 'DOCUMENT_NOT_FOUND',
		codeNumber: '0106',
		prefix: 'store',
		errorCode: 'document-not-found',
	},
}

const PiixAuth: Module = {
	'unknown': {
		name: 'UNKNOWN',
		codeNumber: '2000',
		prefix: 'piix-auth',
		errorCode: 'unknown',
	},
	'email-already-exists': {
		name: 'EMAIL_ALREADY_EXISTS',
		codeNumber: '2001',
		prefix: 'piix-auth',
		errorCode: 'email-already-exists',
	},
	'email-not-found': {
		name: 'EMAIL_NOT_FOUND',
		codeNumber: '2002',
		prefix: 'piix-auth',
		errorCode: 'email-not-found',
	},
	'incorrect-verification-code': {
		name: 'INCORRECT_VERIFICATION_CODE',
		codeNumber: '2003',
		prefix: 'piix-auth',
		errorCode: 'incorrect-verification-code',
	},
	'custom-token-failed': {
		name: 'CUSTOM_TOKEN_FAILED',
		codeNumber: '2004',
		prefix: 'piix-auth',
		errorCode: 'custom-token-failed',
	},
	'email-not-sent': {
		name: 'UNKNOWN',
		codeNumber: '2005',
		prefix: 'piix-auth',
		errorCode: 'email-not-sent',
	},
}


const PiixFunctions: Module = {
	'unknown': {
		name: 'UNKNOWN',
		codeNumber: '3000',
		prefix: 'piix-functions',
		errorCode: 'unknown',
	},
	'invalid-body': {
		name: 'INVALID_BODY',
		codeNumber: '3001',
		prefix: 'piix-functions',
		errorCode: 'invalid-body',
	},
	'invalid-body-fields': {
		name: 'INVALID_BODY_FIELDS',
		codeNumber: '3002',
		prefix: 'piix-auth',
		errorCode: 'invalid-body-fields',
	},
}

export class AppException extends HttpsError {
  
  constructor({
    code,
    errorCode,
    message,
    prefix,
  }: {
    code: FunctionsErrorCode;
    errorCode: ErrorCode,
    message: string;
    prefix: ModulePrefix,
  }) {

    var submodule = undefined;
    if (errorCode !== null && (typeof errorCode) === 'string') {
        const module = AppException._getModule(prefix);
        submodule = module[errorCode];
    }
    super(code, message, submodule);
  }

  private static _getModule(modulePrefix: ModulePrefix): Module {
    switch (modulePrefix) {
      case 'auth': return FirebaseAdminAuth;
	  case 'store': return FirebaseAdminFirestore;
	  case 'piix-auth': return PiixAuth;
      default: return PiixFunctions;
    }
  }
}