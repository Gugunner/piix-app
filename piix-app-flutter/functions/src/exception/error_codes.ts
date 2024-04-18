/**
 * All codes defined for the 'auth' errorCodes that can be thrown
 */
<<<<<<< HEAD
type FirebaseAdminAuthErrorCodes = 'unknown' | 'email-already-exists' | 'id-token-expired'
| 'id-token-revoked' | 'invalid-email' | 'invalid-id-token' | 'invalid-uid' | 'too-many-requests'
| 'uid-already-exists' | 'user-not-found';
=======
type FirebaseAdminAuthErrorCodes = 'unknown' | 'id-token-expired'
| 'id-token-revoked' | 'invalid-email' | 'invalid-id-token' | 'invalid-uid' | 'too-many-requests'
| 'uid-already-exists' | 'user-not-found' | 'user-not-created';
>>>>>>> develop

/**
 * All codes defined for the 'store' errorCodes that can be thrown
 */
type FirebaseAdminFirestoreErrorCodes = 'unknown' | 'document-not-added' | 'document-not-created'
<<<<<<< HEAD
| 'document-not-deleted' | 'document-not-set' | 'document-not-updated' | 'document-not-found';
=======
| 'document-not-deleted' | 'document-not-set' | 'document-not-updated' | 'document-not-found' | 'query-is-empty';
>>>>>>> develop

/**
 * All codes defined for the piix-auth errorCodes that can be thrown
 */
type PiixAuthErrorCodes = 'unknown' | 'email-already-exists' | 'email-not-found' | 'incorrect-verification-code'
<<<<<<< HEAD
| 'custom-token-failed' | 'email-not-sent';
=======
| 'custom-token-failed' | 'no-id-token-present';
>>>>>>> develop

/** 
 * All codes defined for the piix-functions errorCodes that can be thrown 
*/
<<<<<<< HEAD
type PiixFunctionsErrorCodes = 'invalid-body' | 'invalid-body-fields';
=======
type PiixFunctionsErrorCodes = 'invalid-body' | 'invalid-body-fields' | 'email-not-sent';
>>>>>>> develop

export type ErrorCode = FirebaseAdminAuthErrorCodes | FirebaseAdminFirestoreErrorCodes 
| PiixAuthErrorCodes | PiixFunctionsErrorCodes;