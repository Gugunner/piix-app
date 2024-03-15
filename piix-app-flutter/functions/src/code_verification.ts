import { logger } from "firebase-functions/v1";
import { AppException } from "./app_exception";
import { Request } from "firebase-functions/v2/https";
import { Response } from "firebase-functions/v1";;
import * as admin from "firebase-admin";

export async function sendVerificationCode(request: Request, response: Response): Promise<void> {
    if (request.body == undefined) {
        throw new AppException({
            code: 'invalid-argument',
            errorCode: 'invalid-body',
            message: 'The request has no body.',
            prefix: 'piix-functions',
        });
    }
    const languageCode = request.body.languageCode;
    const email = request.body.email;
    if (languageCode === undefined || email == undefined) {
        throw new AppException({
            code: 'invalid-argument',
            errorCode: 'invalid-body-fields',
            message: 'The email and language code must be included.',
            prefix: 'piix-functions',
        });
    }
    const code = createNewCode();
    const docRef = admin.firestore().collection('codes').doc(email);
    return sendCodeToEmail(email, languageCode)
    .then(() =>
        docRef.set({
            "email": email,
            "code": code,
        })
        .then(() => {
            logger.log(`Email and code were sent and stored`);
            response.status(200).send({code: 0});
        })
        .catch(() => {
            throw new AppException({
                code: 'aborted',
                errorCode: 'document-not-added',
                message: 'Could not store the verification code.',
                prefix: 'auth',
            });
        })
    );
}

//Creates a new 6 digit code
function createNewCode(): string {
    //Creates a base value that controls the length of the number (7)
    const max = Math.pow(10, 7); // 10^7
    //Creates the mininimum value equal to the real length of the number (6)
    const min = max/10; // 10^7/10 = 10^6
    //Creates a random value greater than 0 but less than 1 with 16 decimal places
    //Multiply the value by the difference between the max and the min to obtain a (7) digit value
    //Add one to prevent values to start at 0
    //Floor the value to remove additional decimals
    //Add the min value to sum 1000000 to the current result the most significant 1 will be discarded at the end
    const number = Math.floor(Math.random() * (max - min + 1)) + min; 
    //ex. 0.2442534423448654*(10^7-10^6+1) + 10^6 = 0.2442534423448654*(9000001) + 10^6 = 2198280.981 + 10^6 = 3198280
    //Return the value interpolated as a string startign from the pos 1 to only return 6 digits
    return `${number}`.substring(1); // 198280
}

async function sendCodeToEmail( email: string, languageCode: string): Promise<void> {
    logger.log(`Sending email ${email} with language ${languageCode}`);
    // return new Promise<void>( 
    //     () => 
    // ).catch(() => {
    //     throw new AppException({
    //         code: 'aborted',
    //         errorCode: 'email-not-sent',
    //         message: 'The verification code email could not be sent.',
    //         prefix: 'piix-auth',
    //     });
    // });
}

