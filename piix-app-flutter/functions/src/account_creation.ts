
import * as express from 'express';
import { logger } from 'firebase-functions/v2';
import { AppException } from './exception/app_exception';
import { Request } from 'firebase-functions/v2/https';
import * as admin from 'firebase-admin';
import * as check from './util/request_body_checks';
import { UserRecord } from 'firebase-admin/auth';

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
    check.checkEmptyBody(request.body);
    //Check if the email is included
    check.checkBodyFields(request.body, ['email']);
    const { email } = request.body;
    //Create the user in Firebase and store it
    const user = await createUserInFirebase(email);
    const uid = user.uid;
    //Store the user in the collection 'users'
    await storeUser(email, uid);
    logger.log(`User created and stored -> ${uid}`);
    const claims = {
        userAccount: true,
    };
    //Create a custom token with the user's uid and the custom claim userAccount: true
    const customToken = await createCustomToken(uid, claims);
    logger.log('User custom token was created');
    //Return the custom token in the response body
    response.status(200).send({ customToken: customToken, code: 0 });
}

/**
 * Creates a custom token with the user's uid and the custom claims
 * 
 * @param uid The uid of the user
 * @param claims An optional object with the custom claims defined for the user
 * @returns {string} A custom token with the user's uid and the custom claims, the token is used to sign in the user
 * @throws {AppException} If the custom token could not be created
 */
async function createCustomToken(uid: string, claims?: object | undefined): Promise<string> {
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
 * Create a new user in Firebase with the email provided and sets by default the emailVerified to true
 * 
 * @param email The email of the user
 * @returns {UserRecord} The user created in Firebase
 * @throws {AppException} If the user could not be created
 */
async function createUserInFirebase(email: string): Promise<UserRecord> {
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
        await admin.auth().deleteUser(uid);
        throw new AppException({
            code: 'aborted',
            errorCode: 'document-not-added',
            message: 'Could not store the user.',
            prefix: 'store',
        });// O
    }
}

