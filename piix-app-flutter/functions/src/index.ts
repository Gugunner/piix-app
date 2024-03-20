import {onRequest} from "firebase-functions/v2/https";
import * as admin from "firebase-admin";
import { sendVerificationCode } from "./code_verification";
import { createAccountAndCustomTokenWithEmail } from "./account_creation";

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
