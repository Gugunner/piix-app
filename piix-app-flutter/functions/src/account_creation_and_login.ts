
import * as express from 'express';
import { logger } from 'firebase-functions/v2';
import { AppException } from './exception/app_exception';
import { Request } from 'firebase-functions/v2/https';
import * as admin from 'firebase-admin';
import { checkBodyFields, checkEmptyBody } from "./util/request_body_checks";
import { UserRecord } from 'firebase-admin/auth';
import { DocumentData } from 'firebase-admin/firestore';

/**
 * Create a new user in Firebase and create a custom token with the user's uid and the custom claim userAccount: true
 * The user is stored in the collection 'users' with the uid as the document id
 * A custom token is created and returned in the response body
 * 
 * @param {Request} request 
 * @param {express.Response} response 
 * @throws {AppException} If the body is undefined, or the email is not included or the user could not be created or the user could not be stored or the custom token could not be created
 */
export async function createAccountAndCustomTokenWithEmail(request: Request, response: express.Response): Promise<void> {    
    //Check if the body is undefined
    checkEmptyBody(request.body);
    //Check if the email is included
    checkBodyFields(request.body, ['email', 'code']);
    const { email, code } = request.body;
    //Verify the code with the email provided
    await verifyCodeWithEmail(email, code);
    //Create the user in Firebase and store it
    const user = await createUserInFirebaseWithEmail(email);
    const uid = user.uid;
    //Store the user in the collection 'users'
    await storeUser(email, uid);
    const claims = {
        userAccount: true,
    };
    //Create a custom token with the user's uid and the custom claim userAccount: true
    const customToken = await createCustomToken(uid, claims);
    //Return the custom token in the response body
    response.status(200).send({ customToken: customToken, code: 0 });

    /**
     * Create a new user in Firebase with the email provided and sets by default the emailVerified to true
     * 
     * @param email The email of the user
     * @returns {UserRecord} The user created in Firebase
     * @throws {AppException} If the user could not be created
     */
    async function createUserInFirebaseWithEmail(email: string): Promise<UserRecord> {
        try {
            //Create a new user in Firebase with the email provided and sets by default the emailVerified to true
            //Note: The value is awaited to avoid throwing an error when testing with jest.expect().rejects
            const user = await admin.auth().createUser({
                email: email,
                emailVerified: true,
            });
            return user;
        } catch (error) {
            //If the user could not be created, throw an AppException
            throw new AppException({
                code: 'aborted',
                errorCode: 'user-not-created',
                message: 'Firebase user was not created.',
                prefix: 'auth',
            });
        }
    }

    /**
     * Store the user in the collection 'users' with the uid as the document id
     * 
     * @param email The email of the user
     * @param uid The uid of the user in Firebase
     * @throws {AppException} If the user could not be stored
     */
    async function storeUser(email: string, uid: string): Promise<void> {
        try {
            //Store the user in the collection 'users' with the uid as the document id
            const docRef = admin.firestore().collection('users').doc(uid);
            await docRef.set({
                email: email,
                uid: uid,
                emailVerified: true,
            });
        } catch (error) {
            //If the user could not be stored, delete the user and throw an AppException
            logger.error(`The user cannot be stored in users/${uid}, deleting Firebase user`);
            await admin.auth().deleteUser(uid);
            throw new AppException({
                code: 'aborted',
                errorCode: 'document-not-added',
                message: 'Could not store the user.',
                prefix: 'store',
            });// O
        }
    }

}

/**
 * Verifies the code with the email provided and retrieves the user using the email.
 * Creates a custom token with the user's uid and returns it in the response body
 * 
 * @param {Request} request 
 * @param {express.Response} response
 * @throws {AppException} If the body is undefined, or the email is not included or the user could not be created or the verification code cannot be verified or the custom token could not be created   
 */
export async function getCustomTokenForCustomSignIn(request: Request, response: express.Response): Promise<void> {
    //Check if the body is undefined
    checkEmptyBody(request.body);
    //Check if the email and the code are included
    checkBodyFields(request.body, ['email', 'code']);
    const { email, code } = request.body;
    //Verify the code with the email provided
    await verifyCodeWithEmail(email, code);
    //Retrieve the user using the email provided
    const user = await getUserByEmail(email);
    //Create a custom token with the user's uid
    const customToken = await createCustomToken(user.uid);
    //Return the custom token in the response body
    response.status(200).send({ customToken: customToken, code: 0 });

    /**
     * Queries the collection 'users' to retrieve the first result of the user with the email provided
     * 
     * @param {string} email the email of the user 
     * @returns @type {DocumentData} Firebase user 
     * @throws {AppException} If the query is empty, or the document does not exist, or the document has no data
     */
    async function getUserByEmail(email: string): Promise<DocumentData> {
        //Queries the collection 'users' to retrieve the first result of the user with the email provided
        const docQuery = await admin.firestore().collection('users').where('email', "==", email).get();
        //If the query is empty, throw an AppException
        if (docQuery.empty) {
            logger.error(`The document query to get user by email ${email} for login has no results.`);
            throw new AppException({
                code: 'failed-precondition',
                errorCode: 'query-is-empty',
                message: 'The query to get users returned no results',
                prefix: 'store',
            });
        }
        //Retrieve the first result of the query
        const doc =  docQuery.docs.map((doc) => doc)[0];
        //If the document does not exist, throw an AppException
        if (!doc.exists) {
            logger.error(`The document found in users with email ${email} to retrieve for login does not exist`);
            throw new AppException({
                code: 'not-found',
                errorCode: 'document-not-found',
                message: 'The user could not be retrieved.',
                prefix: 'store',
            });
        }
        //Retrieve the data of the document
        const data = doc.data();
        //If the document has no data, throw an AppException
        if (data === undefined) {
            logger.error(`The document found in users/${doc.id} to retrieve for login has no data`);
            throw new AppException({
                code: 'failed-precondition',
                errorCode: 'unknown',
                message: 'There was no data found in the document',
                prefix: 'store',
            });
        }
        //Return the user data
       return data;
    }

}

/**
 * Creates a custom token with the user's uid and the custom claims
 * 
 * @param uid The uid of the user
 * @param claims An optional object with the custom claims defined for the user
 * @returns {string} A custom token with the user's uid and the custom claims, the token is used to sign in the user
 * @throws {AppException} If the custom token could not be created
 */
export async function createCustomToken(uid: string, claims?: object | undefined): Promise<string> {
    try {
        //Create a custom token with the user's uid and the custom claims
        //Note: The value is awaited to avoid throwing an error when testing with jest.expect().rejects
        const customToken = await  admin.auth().createCustomToken(uid, claims);
        return customToken;
    } catch (error) {
        //If the custom token could not be created, throw an AppException
        throw new AppException({
            code: 'failed-precondition',
            errorCode: 'custom-token-failed',
            message: 'The custom token could not be created.',
            prefix: 'piix-auth',
        });
    }
}

/**
 * Verifies the code with the email provided by retrieving the code from the collection 'codes' using the email
 * as the document id. Once the code is retrieved, it is compared with the code provided in the request body.
 * If the codes match the code received in the request body, the code is deleted from the collection 'codes'
 * to avoid reusing the code.
 * 
 * @param email The email of the user
 * @param code The code to verify
 * @throws {AppException} If the code could not be retrieved, or the code do not match the code found in the system
 */
export async function verifyCodeWithEmail(email: string, code: string): Promise<void> {
    //Retrieve the code from the collection 'codes' using the email as the document id
    const docRef = admin.firestore().collection('codes').doc(email);
    //Retrieve the code from the document
    const doc = await docRef.get();
    //If the code could not be retrieved, throw an AppException
    if (!doc.exists) {
        throw new AppException({
            code: 'not-found',
            errorCode: 'document-not-found',
            message: 'The code could not be retrieved.',
            prefix: 'store',
        });
    }
    //Retrieve the data of the document
    const data = doc.data();
    //If the document has no data, throw an AppException
    if (data === undefined) {
        logger.error(`The document found in ${docRef.path} with the code to verify has no data`);
        throw new AppException({
            code: 'failed-precondition',
            errorCode: 'unknown',
            message: 'There was no data found in the document.',
            prefix: 'store',
        });
    }
    //Retrieve the code from the data
    const storedCode = data.code;
    //If the code do not match the code found in the system, throw an AppException
    if (storedCode != code) {
        throw new AppException({
            code: 'aborted',
            errorCode: 'incorrect-verification-code',
            message: 'The verification code do not match the code found in the system',
            prefix: 'piix-auth',
        });
    }
    //Delete the code from the collection 'codes' to avoid reusing the code
    await clearCode(docRef);


    /**
     * Deletes the code from the collection 'codes' using the document reference provided.
     * If the code could not be deleted, the code is cleared by setting the code to an empty string.
     * 
     * @param docRef The document reference to delete the code
     */
    async function clearCode(docRef: admin.firestore.DocumentReference): Promise<void> {
        try {
            //Delete the code from the collection 'codes' using the document reference provided
            await docRef.delete();
        } catch (error) {
            //If the code could not be deleted, clear the code by setting the code to an empty string
           logger.error(`The document found in ${docRef.id} could not be deleted, attempting to clear code... $${error}`);
           await docRef.set({
            code: '',
           }, { merge: true });
        }
    }
}

