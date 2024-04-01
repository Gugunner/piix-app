import * as myFunctions from '../../../src/index';
import * as verification from '../../../src/verification_code_email';
import * as admin from 'firebase-admin';
import * as express from 'express';
import { Request } from 'firebase-functions/v2/https';
import { WithFieldValue } from 'firebase-admin/firestore';
import { mockObjectProperty } from '../mock_objects';
import { AppException } from '../../../src/exception/app_exception';
import { SubModule } from '../../../src/exception/modules';
import { MockFirestore } from './mock_interfaces';

/**
 * This robot is used to test all the scenarios when sending a verification code via email.
 */
export class SendVerificationCodeRobot {

    //Spy which is used to check if the function was called
    private _spyRequest = jest.spyOn(myFunctions, 'sendVerificationCodeRequest')
    
    //The email to send the verification code to
    private _email: string;
    //The verification code to send
    private _code: string;
    //The language code to use for the email
    private _languageCode: string;

    //The constructor initializes the properties
    constructor({
        email,
        code,
        languageCode,
    }: {
        email: string;
        code: string;
        languageCode: string;
    }) {
        this._email = email;
        this._code = code;
        this._languageCode = languageCode;
        jest.spyOn(verification, 'createNewCode').mockReturnValue(code);
    }

    //A default template name for the email
    private get _templateName() { return `verification_code_${this._languageCode}`};

    //The expected email body to be sent
    private get _expectedEmailBody() {
        return {
            to: [this._email],
            template: {
                name: this._templateName,
                data: {
                    code: this._code,
                }
            }
        };
    }

    //The code document that will be sored in Firestore
    private _codeDocRef(rejectSetCode: boolean) {
        //The set function that will be called when storing the document
        const set =  jest.fn((document: WithFieldValue<admin.firestore.DocumentData>): any => {
            expect(document).toStrictEqual({ email: this._email, code: this._code })
        });
        //If the test should reject the set function
        if (rejectSetCode) {
            //Reject the set function
            set.mockRejectedValue(new Error('mock error'));
        }
        //Return the document reference
        return {
            doc: jest.fn((docId: string) => {
                expect(docId).toBe(this._email);
                return {
                    set: set,
                };
            }),
        }
    }

    //The email collection that will be stored in Firestore
    private _emailCollectionRef(rejectAddEmail: boolean) {
        //The add function that will be called when storing the email
        const add = jest.fn((emailBody: WithFieldValue<admin.firestore.DocumentData>): any => {
            expect(emailBody).toStrictEqual(this._expectedEmailBody);
            expect(emailBody['template']['data']['code']).toBe(this._code);
        });
        //If the test should reject the add function
        if (rejectAddEmail) {
            //Reject the add function
            add.mockRejectedValue(new Error('mock error'));
        }
        //Return the collection reference
        return {
            add: add,  
        };
    }

    //The mocked Firebase Firestore object
    private _mockFirebaseFirestore({rejectSetCode = false, rejectAddEmail = false}: MockFirestore) {
        //The firestore object
        const firestore = jest.fn(() => ({
            collection: jest.fn((collection: string) => {
                if (collection === 'codes')
                return this._codeDocRef(rejectSetCode);
                if (collection === 'emails') return this._emailCollectionRef(rejectAddEmail);
                return {};
            })
        }));
        //Add the firestore to the admin mocked object
        mockObjectProperty(admin, firestore, 'firestore');
    }

    //****************************Test Cases****************************************//

    public async expectToSucceed() {
        this._mockFirebaseFirestore({});
        const req = { body: { email: this._email, languageCode: this._languageCode } };
        const res = {
            status: (code: any) => {
               expect(code).toStrictEqual(200);
               //Return from inside to mock this
               return {
                send: (body: any) => {
                    expect(body).toStrictEqual({ code: 0 });
                }
               }
            },
        }
        //Await the call for Promises
        await myFunctions.sendVerificationCodeRequest(req as Request, (res as unknown) as express.Response);
        expect(this._spyRequest).toHaveBeenCalledTimes(1);
        expect(admin.firestore).toHaveBeenCalledTimes(2);
    }

    public async expectToFailWhenBodyIsUndefined() {
        this._mockFirebaseFirestore({});
        const req = {};
        const res = {
            status: (code: any) => {
               expect(code).toStrictEqual(400);
               //Return from inside to mock this
               return {
                send: (body: any) => {
                    expect(body).toBeInstanceOf(AppException);
                    const subModule = (body as AppException).details as SubModule;
                    expect(subModule.errorCode).toBe('invalid-body');
                }
               }
            },
        }
        //Await the call for Promises
        await myFunctions.sendVerificationCodeRequest(req as Request, (res as unknown) as express.Response);
        expect(this._spyRequest).toHaveBeenCalledTimes(1);
        expect(admin.firestore).toHaveBeenCalledTimes(0);
    }

    public async expectToFailWhenBodyIsEmpty() {
        this._mockFirebaseFirestore({});
        const req = { body: {} };
        const res = {
            status: (code: any) => {
               expect(code).toStrictEqual(400);
               //Return from inside to mock this
               return {
                send: (body: any) => {
                    expect(body).toBeInstanceOf(AppException);
                    const subModule = (body as AppException).details as SubModule;
                    expect(subModule.errorCode).toBe('invalid-body-fields');
                }
               }
            },
        }
        //Await the call for Promises
        await myFunctions.sendVerificationCodeRequest(req as Request, (res as unknown) as express.Response);
        expect(this._spyRequest).toHaveBeenCalledTimes(1);
        expect(admin.firestore).toHaveBeenCalledTimes(0);
    }

    public async expectToFailWhenBodyHasNoEmail() {
        this._mockFirebaseFirestore({});
        const req = { body: { languageCode: this._languageCode } };
        const res = {
            status: (code: any) => {
               expect(code).toStrictEqual(400);
               //Return from inside to mock this
               return {
                send: (body: any) => {
                    expect(body).toBeInstanceOf(AppException);
                    const subModule = (body as AppException).details as SubModule;
                    expect(subModule.errorCode).toBe('invalid-body-fields');
                }
               }
            },
        }
        //Await the call for Promises
        await myFunctions.sendVerificationCodeRequest(req as Request, (res as unknown) as express.Response);
        expect(this._spyRequest).toHaveBeenCalledTimes(1);
        expect(admin.firestore).toHaveBeenCalledTimes(0);
    }

    public async expectToFailWhenBodyHasNoLanguageCode() {
        this._mockFirebaseFirestore({});
        const req = { body: { email: this._email } };
        const res = {
            status: (code: any) => {
               expect(code).toStrictEqual(400);
               //Return from inside to mock this
               return {
                send: (body: any) => {
                    expect(body).toBeInstanceOf(AppException);
                    const subModule = (body as AppException).details as SubModule;
                    expect(subModule.errorCode).toBe('invalid-body-fields');
                }
               }
            },
        }
        //Await the call for Promises
        await myFunctions.sendVerificationCodeRequest(req as Request, (res as unknown) as express.Response);
        expect(this._spyRequest).toHaveBeenCalledTimes(1);
        expect(admin.firestore).toHaveBeenCalledTimes(0);
    }

    public async expectToFailWhenEmailDocumentCannotBeStored() {
        this._mockFirebaseFirestore({
            rejectAddEmail: true,
        });
        const req = { body: { email: this._email, languageCode: this._languageCode } };
        const res = {
            status: (code: any) => {
               expect(code).toStrictEqual(500);
               //Return from inside to mock this
               return {
                send: (body: any) => {
                    expect(body).toBeInstanceOf(AppException);
                    const subModule = (body as AppException).details as SubModule;
                    expect(subModule.errorCode).toBe('email-not-sent');
                }
               }
            },
        }
        //Await the call for Promises
        await myFunctions.sendVerificationCodeRequest(req as Request, (res as unknown) as express.Response);
        expect(this._spyRequest).toHaveBeenCalledTimes(1);
    }

    public async expectToFailWhenCodeDocumentCannotBeStored() {
        this._mockFirebaseFirestore({
            rejectSetCode: true,
        });
        const req = { body: { email: this._email, languageCode: this._languageCode } };
        const res = {
            status: (code: any) => {
               expect(code).toStrictEqual(500);
               //Return from inside to mock this
               return {
                send: (body: any) => {
                    expect(body).toBeInstanceOf(AppException);
                    const subModule = (body as AppException).details as SubModule;
                    expect(subModule.errorCode).toBe('document-not-added');
                }
               }
            },
        }
        //Await the call for Promises
        await myFunctions.sendVerificationCodeRequest(req as Request, (res as unknown) as express.Response);
        expect(this._spyRequest).toHaveBeenCalledTimes(1);
    }
}