import 'package:flutter_test/flutter_test.dart';
import 'package:piix_mobile/src/features/authentication/application/auth_service_barrel_file.dart';
import 'package:piix_mobile/src/features/authentication/application/fake_auth_service.dart';
import 'package:piix_mobile/src/features/authentication/domain/authentication_model_barrel_file.dart';
import 'package:piix_mobile/src/network/app_exception.dart';

void main() {
  const testEmail = 'email@gmail.com';
  final expectedFakeAppUser = FakeAppUser(
    uid: testEmail.split('').reversed.join(),
    email: testEmail,
    emailVerified: true,
    verificationCode: '123456',
  );

  FakeAuthService createFakeAuthService() {
    final authService = FakeAuthService(addDelay: false);
    addTearDown(authService.dispose);
    return authService;
  }

  Future<void> setAndCreateNewUser(FakeAuthService authService) async {
    await authService.sendVerificationCodeByEmail(testEmail);
    await authService.createAccountWithEmailAndVerificationCode(
      testEmail,
      expectedFakeAppUser.verificationCode,
    );
  }

  group('Fake Auth Service', () {
    test('''WHEN creating a new FakeAuthService instance
    THEN the current user is null
    AND the authStateChange emits null
    AND the idTokenChanges emits null''', () {
      final authService = createFakeAuthService();
      expect(authService.currentUser, isNull);
      expect(authService.authStateChange(), emits(null));
      expect(authService.idTokenChanges(), emits(null));
    });

    test('''WHEN calling sendVerificationCodeByEmail with a new email
    THEN the user is added to the list of users
    AND the emailVerified property is false
    AND the current user is null
    AND the authStateChange emits null
    AND the idTokenChanges emits null''', () {
      final authService = createFakeAuthService();
      authService.sendVerificationCodeByEmail(expectedFakeAppUser.email!);
      expect(authService.readUsers(), [
        expectedFakeAppUser.copyWith(email: '', emailVerified: false),
      ]);
      expect(authService.currentUser, isNull);
      expect(authService.authStateChange(), emits(null));
      expect(authService.idTokenChanges(), emits(null));
    });

    test('''WHEN calling createAccountWithEmailAndVerificationCode
    without calling sendVerificationCodeByEmail
    THEN the user is not added to the list of users
    AND the current user is null
    AND the authStateChange emits null
    AND the idTokenChanges emits null''', () async {
      final authService = createFakeAuthService();
      expect(
          () async => authService.createAccountWithEmailAndVerificationCode(
              expectedFakeAppUser.email!, expectedFakeAppUser.verificationCode),
          throwsA(isA<UnkownErrorException>()));
      expect(authService.readUsers(), isEmpty);
      expect(authService.currentUser, isNull);
      expect(authService.authStateChange(), emits(null));
      expect(authService.idTokenChanges(), emits(null));
    });
    test('''WHEN calling createAccountWithEmailAndVerificationCode
    after calling sendVerificationCodeByEmail
    THEN the user is already added to the list of users
    AND the current user is not null
    AND the emailVerified property is true
    AND the authStateChange emits the user
    AND the idTokenChanges emits the user''', () async {
      final authService = createFakeAuthService();
      await setAndCreateNewUser(authService);
      expect(authService.readUsers(), [expectedFakeAppUser]);
      expect(authService.currentUser, expectedFakeAppUser);
      expect(authService.authStateChange(), emits(expectedFakeAppUser));
      expect(authService.idTokenChanges(), emits(expectedFakeAppUser));
    });
    test('''WHEN calling createAccountWithEmailAndVerificationCode
    after calling sendVerificationCodeByEmail
    AND entering am email that already has a users in the list
    THEN throw an EmailAlreadyExistsException
    AND the current user is null
    AND the authStateChange emits null
    AND the idTokenChanges emits null''', () async {
      final authService = createFakeAuthService();
      await setAndCreateNewUser(authService);
      expect(authService.readUsers(), [expectedFakeAppUser]);
      expect(authService.currentUser, expectedFakeAppUser);
      expect(authService.authStateChange(), emits(expectedFakeAppUser));
      expect(authService.idTokenChanges(), emits(expectedFakeAppUser));
      expect(
          () async => authService.createAccountWithEmailAndVerificationCode(
              expectedFakeAppUser.email!, expectedFakeAppUser.verificationCode),
          throwsA(isA<EmailAlreadyExistsException>()));
      expect(authService.readUsers(), [expectedFakeAppUser]);
      expect(authService.currentUser, isNull);
      expect(authService.authStateChange(), emits(null));
      expect(authService.idTokenChanges(), emits(null));
    });
    test('''WHEN calling createAccountWithEmailAndVerificationCode
    after calling sendVerificationCodeByEmail
    AND entering an incorrect verification code
    THEN throw an IncorrectVerificationCodeException
    AND the current user is null
    AND the authStateChange emits null
    AND the idTokenChanges emits null''', () async {
      final authService = createFakeAuthService();
      await authService.sendVerificationCodeByEmail(expectedFakeAppUser.email!);
      expect(
          () async => authService.createAccountWithEmailAndVerificationCode(
              expectedFakeAppUser.email!, 'wrong code'),
          throwsA(isA<IncorrectVerificationCodeException>()));
      expect(authService.readUsers(), [
        expectedFakeAppUser.copyWith(email: '', emailVerified: false),
      ]);
      expect(authService.currentUser, isNull);
      expect(authService.authStateChange(), emits(null));
      expect(authService.idTokenChanges(), emits(null));
    });
    test('''WHEN calling signInWithEmailAndVerificationCode
    after calling createAccountWithEmailAndVerificationCode 
    THEN the current user is not null
    AND the authStateChange emits the user
    AND the idTokenChanges emits the user
    ''', () async {
      final authService = createFakeAuthService();
      await setAndCreateNewUser(authService);
      authService.signInWithEmailAndVerificationCode(
        expectedFakeAppUser.email!,
        expectedFakeAppUser.verificationCode,
      );
      expect(authService.currentUser, expectedFakeAppUser);
      expect(authService.authStateChange(), emits(expectedFakeAppUser));
      expect(authService.idTokenChanges(), emits(expectedFakeAppUser));
    });
    test('''WHEN calling signInWithEmailAndVerificationCode
    without calling createAccountWithEmailAndVerificationCode
    THEN throw an EmailNotFoundException
    AND the users list is empty
    AND the current user is null
    AND the authStateChange emits null
    AND the idTokenChanges emits null''', () {
      final authService = createFakeAuthService();
      expect(
          () => authService.signInWithEmailAndVerificationCode(
              expectedFakeAppUser.email!, expectedFakeAppUser.verificationCode),
          throwsA(isA<EmailNotFoundException>()));
      expect(authService.readUsers(), isEmpty);
      expect(authService.currentUser, isNull);
      expect(authService.authStateChange(), emits(null));
      expect(authService.idTokenChanges(), emits(null));
    });
    test('''WHEN calling signInWithEmailAndVerificationCode
    after calling createAccountWithEmailAndVerificationCode 
    AND entering an incorrect verification code
    THEN throw an IncorrectVerificationCodeException 
    AND the users list contains the user
    AND the current user is null
    AND the authStateChange emits null
    AND the idTokenChanges emits null
    ''', () async {
      final authService = createFakeAuthService();
      await setAndCreateNewUser(authService);
      expect(
          () async => authService.signInWithEmailAndVerificationCode(
              expectedFakeAppUser.email!, 'wrong code'),
          throwsA(isA<IncorrectVerificationCodeException>()));
      expect(authService.readUsers(), [expectedFakeAppUser]);
      expect(authService.currentUser, isNull);
      expect(authService.authStateChange(), emits(null));
      expect(authService.idTokenChanges(), emits(null));
    });
    test('''WHEN calling signOut
    after calling createAccountWithEmailAndVerificationCode
    THEN the users list contains the user
    AND the current user is null
    AND the authStateChange emits null
    AND the idTokenChanges emits null
    ''', () async {
      final authService = createFakeAuthService();
      await setAndCreateNewUser(authService);
      await authService.signOut();
      expect(authService.readUsers(), [expectedFakeAppUser]);
      expect(authService.currentUser, isNull);
      expect(authService.authStateChange(), emits(null));
      expect(authService.idTokenChanges(), emits(null));
    });
    test('''WHEN calling signOut
    without calling createAccountWithEmailAndVerificationCode
    THEN the users list is empty
    AND the current user is null
    AND the authStateChange emits null
    AND the idTokenChanges emits null
    ''', () async {
      final authService = createFakeAuthService();
      await authService.signOut();
      expect(authService.readUsers(), isEmpty);
      expect(authService.currentUser, isNull);
      expect(authService.authStateChange(), emits(null));
      expect(authService.idTokenChanges(), emits(null));
    });
  });
}
