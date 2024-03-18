import * as admin from 'firebase-admin';
import * as myFunctions from '../src/index';
import * as express from 'express';
import { Request } from 'firebase-functions/v2/https';
import { mockObjectProperty } from './utils/mock_objects';
import { AppException } from '../src/exception/app_exception';
import { SubModule } from '../src/exception/modules';

//Tests for the sendVerificationCodeRequest function
describe('Send Verification Code Request', () => {
    const email = 'example@gmail.com';
    const languageCode = 'en';
    //Creates a spy that check the declared method sendVerificationCodeRequest
    const spyRequest = jest.spyOn(myFunctions, 'sendVerificationCodeRequest');
    //Clear the mocks
   afterEach(() => {
    jest.clearAllMocks();
   });
    it(`WHEN a valid email and languageCode is received
    THEN the response status code will be a 200
    AND the returned response body will be a code: 0`, async () => {
        const firestore = jest.fn(() => ({
            collection: jest.fn(() => ({
                doc: jest.fn(() => ({
                    set: jest.fn
                })),
            }))
        }));
        //Add the firestore to the admin mocked object
        mockObjectProperty(admin, firestore);
        const req = { body: { email: email, languageCode: languageCode } };
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
        expect(spyRequest).toHaveBeenCalled();
        expect(admin.firestore).toHaveBeenCalledTimes(1);
    });

    it(`WHEN the request body is undefined
    THEN throw an AppException with "invalid-body" errorCode `, async () => {
        const req = {};
        const res = {};
        try {
            await myFunctions.sendVerificationCodeRequest(req as Request, (res as unknown) as express.Response);
        } catch (e) {
            expect(e).toBeInstanceOf(AppException);
            const subModule = (e as AppException).details as SubModule;
            expect(subModule.errorCode).toBe('invalid-body');
        }
        expect(spyRequest).toHaveBeenCalled();
        expect(admin.firestore).toHaveBeenCalledTimes(0);
    });

    it(`WHEN the request body does not have an email
    THEN throw an AppException with "invalid-body-fields" errorCode `, async () => {
        const req = { body: { languageCode: languageCode } };
        const res = {};
        try {
            await myFunctions.sendVerificationCodeRequest(req as Request, (res as unknown) as express.Response);
        } catch (e) {
            expect(e).toBeInstanceOf(AppException);
            const subModule = (e as AppException).details as SubModule;
            expect(subModule.errorCode).toBe('invalid-body-fields');
        }
        expect(spyRequest).toHaveBeenCalled();
        expect(admin.firestore).toHaveBeenCalledTimes(0);
    });

    it(`WHEN the request body does not have a languageCode
    THEN throw an AppException with "invalid-body-fields" errorCode `, async () => {
        const req = { body: { email: email } };
        const res = {};
        try {
            await myFunctions.sendVerificationCodeRequest(req as Request, (res as unknown) as express.Response);
        } catch (e) {
            expect(e).toBeInstanceOf(AppException);
            const subModule = (e as AppException).details as SubModule;
            expect(subModule.errorCode).toBe('invalid-body-fields');
        }
        expect(spyRequest).toHaveBeenCalled();
        expect(admin.firestore).toHaveBeenCalledTimes(0);
    });

    it(`WHEN firestore "set" method fails
    THEN throw an AppException with 'document-not-added errorCode`, async () => {
        const req = { body: { email: 'examples@gmail.com', languageCode: 'en' } };
        const res = {};
        const firestore = jest.fn(() => ({
            collection: jest.fn(() => ({
                doc: jest.fn(() => ({
                    //Mock the set method to throw an error
                    set: jest.fn().mockRejectedValue(new Error('mock error'))
                })),
            }))
        }));
        //Add the firestore to the admin mocked object
        mockObjectProperty(admin, firestore);
        //Await the call for Promises
        try {
            await myFunctions.sendVerificationCodeRequest(req as Request, (res as unknown) as express.Response);
        } catch (e) {
            expect(e).toBeInstanceOf(AppException);
            const subModule = (e as AppException).details as SubModule;
            expect(subModule.errorCode).toBe('document-not-added');
        }
        expect(spyRequest).toHaveBeenCalled();
    });
});


