
import * as admin from 'firebase-admin';
import { CreateRequest } from 'firebase-admin/auth';
import { mockObjectProperty } from '../mock_objects';
import * as express from 'express';
import { Request } from 'firebase-functions/v2/https';
import * as myFunctions from '../../../src/index';
import { AppException } from '../../../src/exception/app_exception';
import { SubModule } from '../../../src/exception/modules';
import { MockFirestore, MockFirebaseAuth } from './mock_interfaces';

/**
 * This robot is used to test all the scenarios when creating an account with email and custom token
 */
export class CreateAccountWithEmailRobot {

    //Spy which will be used to check if the function was called
    private _spyRequest = jest.spyOn(myFunctions, 'createAccountAndCustomTokenWithEmailRequest');

    //The code that will be used to verify the email
    private _code: string;
    //The email that will be used to create the account
    private _email: string;
    //The uid that will be created by the Firebase Create User function
    private _uid: string; 
    //The custom token that will be created by the Firebase Create Custom Token function
    private _customToken: string;
    
    //The constructor initializes the properties
    constructor({
        code,
        email,
        uid,
        customToken,
    }: {
        code: string,
        email: string,
        uid: string,
        customToken: string,
    }) {
        this._code = code;
        this._email = email;
        this._uid = uid;
        this._customToken = customToken;
    }

    //The default code data that will be returned by the code document
    private get _codeData(): any {
        return  jest.fn(() => ({ code: this._code }));
    };

    //The code document that will be returned by the Firestore
    private _codeDoc(exists: boolean , data: jest.Mock): any {
        return {
            exists: exists,
            data: data,
        }
    }

    //The user data that will be returned by the Firebase Create User function
    private get _userData(): any {
        return { uid: this._uid };
    }
    
    //The code document reference that will be returned by the firestore
    private _codeDocRef(exists: boolean, data: jest.Mock, rejectDelete: boolean): any {
        //The delete code function
        const deleteCode = jest.fn();
        //If the delete code should be rejected
        if (rejectDelete) {
            //Reject the delete code function
            deleteCode.mockRejectedValue(new Error('mock error'));
        }
        //Return the code document reference
        return {
            doc: jest.fn((docId: string) => {
                expect(docId).toBe(this._email);
                return  {
                    get: jest.fn(async () => (this._codeDoc(exists, data))),
                    path: `codes/${this._email}`,
                    id: this._email,
                    delete: deleteCode,
                    set: jest.fn((data: any, options: any) => {
                        expect(data).toStrictEqual({ code: '' });
                        expect(options).toStrictEqual({ merge: true });
                    }),
                };
            })
        }
    }

    //The user document reference that will be returned by the firestore
    private _userDocRef(rejectSet: boolean): any {
        //The set function
        const set = jest.fn((document: any): any => {
            expect(document).toStrictEqual({ email: this._email, uid: this._uid, emailVerified: true });
        });
        //If the set function should be rejected
        if (rejectSet) {
            //Reject the set function
            set.mockRejectedValue(new Error('mock error'));
        }
        //Return the user document reference
        return {
            doc: jest.fn((docId: string) => {
                expect(docId).toBe(this._uid);
                return {
                    set: set,
                };
            })
        };
    }

    //The mocked Firebase Auth object
    private _mockFirebaseAuth({rejectCreateUser = false, rejectCreateCustomToken = false}: MockFirebaseAuth): void {
        //The create user function
        const createUser = jest.fn((properties: CreateRequest): any => {
            expect(properties.email).toBe(this._email);
            expect(properties.emailVerified).toBe(true);
            return this._userData;
        });
        //The create custom token function
        const createCustomToken = jest.fn((uid: string, claims: any): any => {
            expect(uid).toStrictEqual(uid);
            expect(claims).toStrictEqual({ userAccount: true })
            return this._customToken;
        });
        //If the create user should be rejected
        if (rejectCreateUser) {
            //Reject the create user function
            createUser.mockRejectedValue(new Error('mock error'));
        }
        //If the create custom token should be rejected
        if (rejectCreateCustomToken) {
            //Reject the create custom token function
            createCustomToken.mockRejectedValue(new Error('mock error'));
        }
        //The auth object
        const auth = jest.fn(() => ({
            createUser: createUser,
            createCustomToken: createCustomToken,
            deleteUser: jest.fn((uid: string) => {
                expect(uid).toBe(this._uid);
            })
        }));
        //Add the auth to the admin mocked object
        mockObjectProperty(admin, auth, 'auth');
    }

    //The mocked Firebase Firestore object
    private _mockFirebaseFirestore({rejectSetUser = false, codeExists = true, codeData = this._codeData,  rejectDeleteCode = false}: MockFirestore): void {
        //The firestore object
        const firestore = jest.fn(() => ({
            collection: jest.fn((collection: string) => {
                if (collection === 'users') return this._userDocRef(rejectSetUser);
                if (collection === 'codes') return this._codeDocRef(codeExists, codeData, rejectDeleteCode);
                return {};
            })
        }));
        //Add the firestore to the admin mocked object
        mockObjectProperty(admin, firestore, 'firestore');
    }

    //****************************Test Cases****************************************//

    public async expectToSucceed() {
        this._mockFirebaseAuth({});
        this._mockFirebaseFirestore({});
        const req = { body: { email: this._email, code: this._code } };
        const res = {
            status: (code: any): any => {
                expect(code).toStrictEqual(200);
                return {
                    send: (body: any) => {
                        expect(body).toStrictEqual({ customToken: this._customToken, code: 0, })
                    }
                }
            }
        };
        await myFunctions.createAccountAndCustomTokenWithEmailRequest(req as Request, (res as unknown) as express.Response);
        expect(this._spyRequest).toHaveBeenCalledTimes(1);;
        expect(admin.auth).toHaveBeenCalledTimes(2);
        expect(admin.firestore).toHaveBeenCalledTimes(2);
    }
    
    public async expectToFailWhenBodyIsUndefined() {
        this._mockFirebaseAuth({});
        this._mockFirebaseFirestore({});
        const req = {};
        const res = {};
        try {
            await myFunctions.createAccountAndCustomTokenWithEmailRequest(req as Request, (res as unknown) as express.Response);
        } catch (e) {
            expect(e).toBeInstanceOf(AppException);
            const subModule = (e as AppException).details as SubModule;
            expect(subModule.errorCode).toBe('invalid-body');
        }
        expect(this._spyRequest).toHaveBeenCalledTimes(1);
        expect(admin.auth).toHaveBeenCalledTimes(0);
        expect(admin.firestore).toHaveBeenCalledTimes(0);
    }

    public async expectToFailWhenBodyIsEmpty() {
        this._mockFirebaseAuth({});
        this._mockFirebaseFirestore({});
        const req = { body: { } };
        const res = {};
        try {
            await myFunctions.createAccountAndCustomTokenWithEmailRequest(req as Request, (res as unknown) as express.Response);
        } catch (e) {
            expect(e).toBeInstanceOf(AppException);
            const subModule = (e as AppException).details as SubModule;
            expect(subModule.errorCode).toBe('invalid-body-fields');
        }
        expect(this._spyRequest).toHaveBeenCalledTimes(1);
        expect(admin.auth).toHaveBeenCalledTimes(0);
        expect(admin.firestore).toHaveBeenCalledTimes(0);
    }

    public async expectToFailWhenBodyHasNoEmail() {
        this._mockFirebaseAuth({});
        this._mockFirebaseFirestore({});
        const req = { body: { code: this._code } };
        const res = {};
        try {
            await myFunctions.createAccountAndCustomTokenWithEmailRequest(req as Request, (res as unknown) as express.Response);
        } catch (e) {
            expect(e).toBeInstanceOf(AppException);
            const subModule = (e as AppException).details as SubModule;
            expect(subModule.errorCode).toBe('invalid-body-fields');
        }
        expect(this._spyRequest).toHaveBeenCalledTimes(1);
        expect(admin.auth).toHaveBeenCalledTimes(0);
        expect(admin.firestore).toHaveBeenCalledTimes(0);
    }

    public async expectToFailWhenBodyHasNoCode() {
        this._mockFirebaseAuth({});
        this._mockFirebaseFirestore({});
        const req = { body: { email: this._email } };
        const res = {};
        try {
            await myFunctions.createAccountAndCustomTokenWithEmailRequest(req as Request, (res as unknown) as express.Response);
        } catch (e) {
            expect(e).toBeInstanceOf(AppException);
            const subModule = (e as AppException).details as SubModule;
            expect(subModule.errorCode).toBe('invalid-body-fields');
        }
        expect(this._spyRequest).toHaveBeenCalledTimes(1);
        expect(admin.auth).toHaveBeenCalledTimes(0);
        expect(admin.firestore).toHaveBeenCalledTimes(0);
    }

    public async expectToFaileWhenCodeDocumentDoesNotExist() {
        this._mockFirebaseAuth({});
        this._mockFirebaseFirestore({
            codeExists: false,
        });
        const req = { body: { email: this._email, code: this._code } };
        const res = {};
        try {
            await myFunctions.createAccountAndCustomTokenWithEmailRequest(req as Request, (res as unknown) as express.Response);
        } catch (e) {
            expect(e).toBeInstanceOf(AppException);
            const subModule = (e as AppException).details as SubModule;
            expect(subModule.errorCode).toBe('document-not-found');
        }
        expect(this._spyRequest).toHaveBeenCalledTimes(1);
        expect(admin.auth).toHaveBeenCalledTimes(0);
        expect(admin.firestore).toHaveBeenCalledTimes(1);
    }

    public async expectToFailWhenCodeDocumentHasNoData() {
        this._mockFirebaseAuth({});
        const data = jest.fn().mockImplementation(() => undefined);
        this._mockFirebaseFirestore({
            codeData: data,
        });
        const req = { body: { email: this._email, code: this._code } };
        const res = {};
        try {
            await myFunctions.createAccountAndCustomTokenWithEmailRequest(req as Request, (res as unknown) as express.Response);
        } catch (e) {
            expect(e).toBeInstanceOf(AppException);
            expect((e as AppException).code).toBe('failed-precondition');
            const subModule = (e as AppException).details as SubModule;
            expect(subModule.errorCode).toBe('unknown');
        }
        expect(this._spyRequest).toHaveBeenCalledTimes(1);
        expect(admin.auth).toHaveBeenCalledTimes(0);
        expect(admin.firestore).toHaveBeenCalledTimes(1);
    }

    public async expectToFailWhenCodesDoNotMatch() {
        this._mockFirebaseAuth({});
        this._mockFirebaseFirestore({});
        const req = { body: { email: this._email, code: '654321' } };
        const res = {};
        try {
            await myFunctions.createAccountAndCustomTokenWithEmailRequest(req as Request, (res as unknown) as express.Response);
        } catch (e) {
            expect(e).toBeInstanceOf(AppException);
            const subModule = (e as AppException).details as SubModule;
            expect(subModule.errorCode).toBe('incorrect-verification-code');
        }
        expect(this._spyRequest).toHaveBeenCalledTimes(1);
        expect(admin.auth).toHaveBeenCalledTimes(0);
        expect(admin.firestore).toHaveBeenCalledTimes(1);
    }

    public async expectToSucceedButFailToRemoveCodeDocument() {
        this._mockFirebaseAuth({});
        this._mockFirebaseFirestore({
            rejectDeleteCode: true,
        });
        const req = { body: { email: this._email, code: this._code } };
        const res = {
            status: (code: any): any => {
                expect(code).toStrictEqual(200);
                return {
                    send: (body: any) => {
                        expect(body).toStrictEqual({ customToken: this._customToken, code: 0, })
                    }
                }
            }
        };
        try {
            await myFunctions.createAccountAndCustomTokenWithEmailRequest(req as Request, (res as unknown) as express.Response);
        } catch (e) {
            expect(e).toBeInstanceOf(AppException);
            const subModule = (e as AppException).details as SubModule;
            expect(subModule.errorCode).toBe('incorrect-verification-code');
        }
        expect(this._spyRequest).toHaveBeenCalledTimes(1);
        expect(admin.auth).toHaveBeenCalledTimes(2);
        expect(admin.firestore).toHaveBeenCalledTimes(2);
    }

    public async expectToFailWhenNoFirebaseUserIsCreated() {
        this._mockFirebaseAuth({
            rejectCreateUser: true,
        });
        this._mockFirebaseFirestore({});
        const req = { body: { email: this._email, code: this._code } };
        const res = {};
        try {
            await myFunctions.createAccountAndCustomTokenWithEmailRequest(req as Request, (res as unknown) as express.Response);
        } catch (e) {
            expect(e).toBeInstanceOf(AppException);
            const subModule = (e as AppException).details as SubModule;
            expect(subModule.errorCode).toBe('user-not-created');
        }
        expect(this._spyRequest).toHaveBeenCalledTimes(1);
        expect(admin.auth).toHaveBeenCalledTimes(1);
        expect(admin.firestore).toHaveBeenCalledTimes(1);
    }
    
    public async expectToFailWhenUserCannotBeStored() {
        this._mockFirebaseAuth({});
        this._mockFirebaseFirestore({
            rejectSetUser: true,
        });
        const req = { body: { email: this._email, code: this._code } };
        const res = {};
        try {
            await myFunctions.createAccountAndCustomTokenWithEmailRequest(req as Request, (res as unknown) as express.Response);
        } catch (e) {
            expect(e).toBeInstanceOf(AppException);
            const subModule = (e as AppException).details as SubModule;
            expect(subModule.errorCode).toBe('document-not-added');
        }
        expect(this._spyRequest).toHaveBeenCalledTimes(1);
        expect(admin.auth).toHaveBeenCalledTimes(2);
        expect(admin.firestore).toHaveBeenCalledTimes(2);
    }

    public async expectToFailWhenCustomTokenCannotBeCreated() {
        this._mockFirebaseAuth({
            rejectCreateCustomToken: true,
        });
        this._mockFirebaseFirestore({});
        const req = { body: { email: this._email, code: this._code } };
        const res = {};
        try {
            await myFunctions.createAccountAndCustomTokenWithEmailRequest(req as Request, (res as unknown) as express.Response);
        } catch (e) {
            expect(e).toBeInstanceOf(AppException);
            const subModule = (e as AppException).details as SubModule;
            expect(subModule.errorCode).toBe('custom-token-failed');
        }
        expect(this._spyRequest).toHaveBeenCalledTimes(1);
        expect(admin.auth).toHaveBeenCalledTimes(2);
        expect(admin.firestore).toHaveBeenCalledTimes(2);
    }


}