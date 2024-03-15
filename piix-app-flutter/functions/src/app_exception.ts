import { HttpsError, FunctionsErrorCode } from "firebase-functions/v2/https";

type ModulePrefix = 'auth' | 'store' | 'piix-auth' | 'piix-functions';



interface SubModule {
  name: string;
  codeNumber: string;
  prefix: string;
  errorCode: string;
}

type Module = {[key: string]: SubModule};

const FirebaseAdminAuth: Module = {
	'unknown': {
		name: 'UNKNOWN',
		codeNumber: '0000',
		prefix: 'auth',
		errorCode: 'NA',
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


export class AppException extends HttpsError {
  
  constructor({
    code,
    errorCode,
    message,
    prefix,
  }: {
    code: FunctionsErrorCode;
    errorCode: string,
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
      default:
        return FirebaseAdminAuth;
    }
  }
}