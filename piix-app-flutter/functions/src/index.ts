<<<<<<< HEAD
/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

import {onRequest} from "firebase-functions/v2/https";
import { initializeApp } from "firebase-admin/app";
import { sendVerificationCode } from "./code_verification";

initializeApp();

exports.sendVerificationCode = onRequest(
    //TODO: Include CORS rules to protect request
    // { cors: []}
    sendVerificationCode); 





=======
import {onRequest} from "firebase-functions/v2/https";
import * as admin from "firebase-admin";
import { sendVerificationCode } from "./verification_code_email";
import { createAccountAndCustomTokenWithEmail, getCustomTokenForCustomSignIn, revokeRefreshTokens } from "./account_auth";
import { logger } from "firebase-functions/v2";
import { AppException } from "./exception/app_exception";

admin.initializeApp();

/**
 * Endpoint {BASE_URL}/sendVerificationCode
 */
export const sendVerificationCodeRequest = onRequest(
    //TODO: Include CORS rules to protect request
    // { cors: []}
    async (request, response) => {
        try {
            await sendVerificationCode(request, response);
        } catch (error) {
            if (error instanceof AppException) {
                response.status((error as AppException).statusCode).send(error);
                return;
            }
            logger.error(`Unhandled error -> ${error}`);
            throw error;   
        }
    }); 

/**
 * Endpoint {BASE_URL}/createAccountAndCustomTokenWithEmailRequest
 */
export const createAccountAndCustomTokenWithEmailRequest = onRequest(
    //TODO: Include CORS rules to protect request
    // { cors: []}
    async (request, response) => {
        try {
            await createAccountAndCustomTokenWithEmail(request, response);
        } catch (error) {
            if (error instanceof AppException) {
                response.status((error as AppException).statusCode).send(error);
                return;
            }
            logger.error(`Unhandled error -> ${error}`);
            throw error;   
        }
    }
);

export const getCustomTokenForCustomSignInRequest = onRequest(
    //TODO: Include CORS rules to protect request
    // { cors: []}
    async (request, response) => {
        try {
            await getCustomTokenForCustomSignIn(request, response);
        } catch (error) {
            if (error instanceof AppException) {
                response.status((error as AppException).statusCode).send(error);
                return;
            }
            logger.error(`Unhandled error -> ${error}`);
            throw error;   
        }
    }
);

export const revokeRefreshTokensRequest = onRequest(
     //TODO: Include CORS rules to protect request
    // { cors: []}
    async (request, response ) => {
        try {
            await revokeRefreshTokens(request, response);
        } catch (error) {
            if (error instanceof AppException) {
                response.status((error as AppException).statusCode).send(error);
                return;
            }
            logger.error(`Unhandled error -> ${error}`);
            throw error; 
        }
    }
);
>>>>>>> develop
