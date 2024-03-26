import {onRequest} from "firebase-functions/v2/https";
import * as admin from "firebase-admin";
import { sendVerificationCode } from "./verification_code_email";
import { createAccountAndCustomTokenWithEmail, getCustomTokenForCustomSignIn } from "./account_creation_and_login";

admin.initializeApp();

/**
 * Endpoint {BASE_URL}/sendVerificationCode
 */
export const sendVerificationCodeRequest = onRequest(
    //TODO: Include CORS rules to protect request
    // { cors: []}
    sendVerificationCode); 

/**
 * Endpoint {BASE_URL}/createAccountAndCustomTokenWithEmailRequest
 */
export const createAccountAndCustomTokenWithEmailRequest = onRequest(
    //TODO: Include CORS rules to protect request
    // { cors: []}
    createAccountAndCustomTokenWithEmail,
);

export const getCustomTokenForCustomSignInRequest = onRequest(
    //TODO: Include CORS rules to protect request
    // { cors: []}
    getCustomTokenForCustomSignIn,
);