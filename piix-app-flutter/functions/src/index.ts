import {onRequest} from "firebase-functions/v2/https";
import * as admin from "firebase-admin";
import { sendVerificationCode } from "./code_verification";

admin.initializeApp();

/**
 * Endpoint {BASE_URL}/sendVerificationCode
 */
export const sendVerificationCodeRequest = onRequest(
    //TODO: Include CORS rules to protect request
    // { cors: []}
    sendVerificationCode); 


