import { AccountCreationAndLoginRobot } from './account_creation_and_login_robot/account_creation_and_login.robot';


/**
 * This robot is a wrapper for the robots that are uses to test all the firebase functions.
 */
export class Robot {

    //The robot to create an account and login
    auth: AccountCreationAndLoginRobot;

    //The constructor initializes the robots
    constructor() {
        this.auth = new AccountCreationAndLoginRobot();
    }

}