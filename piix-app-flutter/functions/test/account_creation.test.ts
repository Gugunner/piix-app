import * as admin from 'firebase-admin';
import * as myFunctions from '../src/index';
import * as express from 'express';
import { Request } from 'firebase-functions/v2/https';
import { mockObjectProperty } from './utils/mock_objects';
import { AppException } from '../src/exception/app_exception';
import { SubModule } from '../src/exception/modules';
import { CreateRequest } from 'firebase-admin/auth';

//Tests for the createAccountAndCustomTokenWithEmailRequest function
describe('Create Account and Custom Token With Email Request', () => {
    //The defined input arguments
    const email = 'email@gmail.com';
    //The defined expected outputs
    const expectedCustomToken = '1234567890';
    const expectedUid = '0987654321';
    const expectedUser = {
        uid: expectedUid,
    };
    //Creates a spy that check the declared method createAccountAndCustomTokenWithEmailRequest
    const spyRequest = jest.spyOn(myFunctions, 'createAccountAndCustomTokenWithEmailRequest');
    //Clear the mocks
    afterEach(() => {
        jest.clearAllMocks();
    }); 
    it(`WHEN a valid email is received
    THEN a firebase user will be created with custom claim userAccount: true
    AND the user will be stored
    AND a custom token will be created
    AND the returned response body will contain the custom token`, async () => {
        const auth = jest.fn(() => ({
            createUser: jest.fn((properties: CreateRequest): any => {
                expect(properties.email).toBe(email);
                expect(properties.emailVerified).toBe(true);
                return expectedUser;
            }),
            createCustomToken: jest.fn((uid: string, claims: any) => {
                expect(uid).toStrictEqual(expectedUid);
                expect(claims).toStrictEqual({ userAccount: true })
                return expectedCustomToken;
            }),
        }));
        //Add the auth to the admin mocked object
        mockObjectProperty(admin, auth, 'auth');
        const firestore = jest.fn(() => ({
            collection: jest.fn(() => ({
                doc: jest.fn(() => ({
                    set: jest.fn
                })),
            }))
        }));
        //Add the firestore to the admin mocked object
        mockObjectProperty(admin, firestore, 'firestore');
        const req = { body: { email: email } };
        const res = {
            status: (code: any): any => {
                expect(code).toStrictEqual(200);
                return {
                    send: (body: any) => {
                        expect(body).toStrictEqual({ customToken: expectedCustomToken, code: 0, })
                    }
                }
            }
        };
        //Await the call for Promises
        await myFunctions.createAccountAndCustomTokenWithEmailRequest(req as Request, (res as unknown) as express.Response);
        expect(spyRequest).toHaveBeenCalled()
        expect(admin.auth).toHaveBeenCalledTimes(2);
        expect(admin.firestore).toHaveBeenCalledTimes(1);
    });
    it(`WHEN the request body is undefined
    THEN throw an AppException with "invalid-body" errorCode`, async () => {
        //The request and response objects will be empty to simulate the undefined body
        //and since the body is undefined, the function will throw an AppException before the response is created
        const req = {};
        const res = {};
        try {
            await myFunctions.createAccountAndCustomTokenWithEmailRequest(req as Request, (res as unknown) as express.Response);
        } catch (e) {
            expect(e).toBeInstanceOf(AppException);
            const subModule = (e as AppException).details as SubModule;
            expect(subModule.errorCode).toBe('invalid-body');
        }
        expect(spyRequest).toHaveBeenCalled()
        expect(admin.auth).toHaveBeenCalledTimes(0);
        expect(admin.firestore).toHaveBeenCalledTimes(0);
    });
    it(`WHEN the request body does not have an email
    THEN throw an AppException with "invalid-body-fields" errorCode`, async () => {
        //The request object will have an empty body to simulate the undefined email
        //and since the email is undefined, the function will throw an AppException before the response is created
        const req = { body: { } };
        const res = {};
        try {
            //Await the call for Promises
            await myFunctions.createAccountAndCustomTokenWithEmailRequest(req as Request, (res as unknown) as express.Response);
        } catch (e) {
            expect(e).toBeInstanceOf(AppException);
            const subModule = (e as AppException).details as SubModule;
            expect(subModule.errorCode).toBe('invalid-body-fields');
        }
        expect(spyRequest).toHaveBeenCalled()
        expect(admin.auth).toHaveBeenCalledTimes(0);
        expect(admin.firestore).toHaveBeenCalledTimes(0);
    });
    it(`WHEN the user cannot be created in Firebase
    THEN throw an AppException with "user-not-created" errorCode`, async () => {
        //The auth object will have a createUser method that will throw an error
        const auth = jest.fn(() => ({
            createUser: jest.fn().mockRejectedValue(new Error('mock error')),
        }));
        mockObjectProperty(admin, auth, 'auth');
        //The response object will be empty since the function will throw an AppException before the response is created
        const req = { body: { email: email } };
        const res = {};
        try {
            //Await the call for Promises
            await myFunctions.createAccountAndCustomTokenWithEmailRequest(req as Request, (res as unknown) as express.Response);
        } catch (e) {
            expect(e).toBeInstanceOf(AppException);
            const subModule = (e as AppException).details as SubModule;
            expect(subModule.errorCode).toBe('user-not-created');
        }
        expect(spyRequest).toHaveBeenCalled()
        expect(admin.auth).toHaveBeenCalledTimes(1);
        expect(admin.firestore).toHaveBeenCalledTimes(0);
    });
    it(`WHEN the user cannot be stored
    THEN the user is deleted
    AND throw an AppException with "document-not-added" errorCode`, async () => {
        const auth = jest.fn(() => ({
            createUser: jest.fn((properties: CreateRequest): any => {
                expect(properties.email).toBe(email);
                expect(properties.emailVerified).toBe(true);
                return expectedUser;
            }),
            deleteUser: jest.fn((uid: string) => expect(uid).toStrictEqual(expectedUid))
        }));
        mockObjectProperty(admin, auth, 'auth');
        //The firestore object will have a set method that will throw an error
        const firestore = jest.fn(() => ({
            collection: jest.fn(() => ({
                doc: jest.fn(() => ({
                    set: jest.fn().mockRejectedValue(new Error('mock error'))
                })),
            }))
        }));
        mockObjectProperty(admin, firestore, 'firestore');
        //The response object will be empty since the function will throw an AppException before the response is created
        const req = { body: { email: email } };
        const res = {};
        try {
            //Await the call for Promises
            await myFunctions.createAccountAndCustomTokenWithEmailRequest(req as Request, (res as unknown) as express.Response);
        } catch (e) {
            expect(e).toBeInstanceOf(AppException);
            const subModule = (e as AppException).details as SubModule;
            expect(subModule.errorCode).toBe('document-not-added');
        }
        expect(spyRequest).toHaveBeenCalled()
        expect(admin.auth).toHaveBeenCalledTimes(2);
        expect(admin.firestore).toHaveBeenCalledTimes(1);
    });
    it(`WHEN the custom token cannot be created
    THEN throw an AppException with "custom-token-failed" errorCode`, async () => {
        //The auth object will have a createCustomToken method that will throw an error
        const auth = jest.fn(() => ({
            createUser: jest.fn((properties: CreateRequest): any => {
                expect(properties.email).toBe(email);
                expect(properties.emailVerified).toBe(true);
                return expectedUser;
            }),
            deleteUser: jest.fn((uid: string) => expect(uid).toStrictEqual(expectedUid)),
            createCustomToken: jest.fn().mockRejectedValue(new Error('mock error')),
        }));
        mockObjectProperty(admin, auth, 'auth');
        const firestore = jest.fn(() => ({
            collection: jest.fn(() => ({
                doc: jest.fn(() => ({
                    set: jest.fn
                })),
            }))
        }));
        mockObjectProperty(admin, firestore, 'firestore');
        //The response object will be empty since the function will throw an AppException before the response is created
        const req = { body: { email: email } };
        const res = {};
        try {
            await myFunctions.createAccountAndCustomTokenWithEmailRequest(req as Request, (res as unknown) as express.Response);
        } catch (e) {
            expect(e).toBeInstanceOf(AppException);
            const subModule = (e as AppException).details as SubModule;
            expect(subModule.errorCode).toBe('custom-token-failed');
        }
        expect(spyRequest).toHaveBeenCalled()
        expect(admin.auth).toHaveBeenCalledTimes(2);
        expect(admin.firestore).toHaveBeenCalledTimes(1);
    });
});