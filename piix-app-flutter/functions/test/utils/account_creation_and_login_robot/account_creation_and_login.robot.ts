
import { CreateAccountWithEmailRobot as CreateAccountAndCustomTokenWithEmailRobot } from './create_account_with_email.robot';
import { GetCustomTokenForCustomSignInRobot } from './get_custom_token_for_custom_sign_in.robot';
import { SendVerificationCodeRobot } from './send_verification_code.robot'

/**
 * This robot is a wrapper for the robots that are used to create an account and login
 * when testing the firebase functions.
 */
export class AccountCreationAndLoginRobot {

    //The robot to create an account with email and custom token
    createWithEmail: CreateAccountAndCustomTokenWithEmailRobot;
    //The robot to get a custom token for custom sign in
    customSignIn: GetCustomTokenForCustomSignInRobot;
    //The robot to send a verification code
    sendVerificationCode: SendVerificationCodeRobot;

    //The constructor initializes the robots
    constructor() {
            const code = '123456';
            const  email = 'email@gmail.com';
            const  uid = '0987654321';
            const  customToken = '1234567890';
        this.createWithEmail = new CreateAccountAndCustomTokenWithEmailRobot({
            email: email,
            code: code,
            uid: uid,
            customToken: customToken,
        });
        this.customSignIn = new GetCustomTokenForCustomSignInRobot({
            email: email,
            code: code,            
            uid: uid,
            customToken: customToken,
        });
        this.sendVerificationCode = new SendVerificationCodeRobot({
            email: email,
            code: code,
        });
    }
    
}