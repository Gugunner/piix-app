import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:piix_mobile/src/constants/widget_keys.dart';
import 'package:piix_mobile/src/features/authentication/domain/authentication_model_barrel_file.dart';
import 'package:piix_mobile/src/features/authentication/presentation/authentication_page_barrel_file.dart';
import 'package:piix_mobile/src/features/authentication/presentation/common_widgets/terms_and_privacy_check.dart';
import 'package:piix_mobile/src/features/authentication/presentation/web/one_column_sign_in_sign_up_submit.dart';
import 'package:piix_mobile/src/network/app_exception.dart';
import 'package:piix_mobile/src/utils/verification_type.dart';

import '../../../goldens/device_sizes.dart';
import '../../../mocks.dart';
import '../../../robot.dart';

void main() {
  late MockAuthService authService;
  setUp(() {
    authService = MockAuthService();
  });

  group('Sign in page', () {
    testWidgets('''WHEN opening the sign in page in a mobile device screen
    IT will show the web one column sign in page
    ''', (tester) async {
      final robot = Robot(tester);
      await robot.auth.pumpAuthPage(
        authService,
        isWeb: true,
        page: const SignInPage(),
      );
      await robot.golden.setSurfaceSize(DeviceSizes.webMobile);
      final oneColumnSignInPageFinder =
          find.byType(OneColumnSignInSignUpSubmit);
      expect(oneColumnSignInPageFinder, findsOneWidget);
    });
    testWidgets('''WHEN opening the sign in page in a web tablet device screen
    IT will show the web one column sign in page
    ''', (tester) async {
      final robot = Robot(tester);
      await robot.auth.pumpAuthPage(
        authService,
        isWeb: true,
        page: const SignInPage(),
      );
      await robot.golden.setSurfaceSize(DeviceSizes.webTablet);
      final oneColumnSignInPageFinder =
          find.byType(OneColumnSignInSignUpSubmit);
      expect(oneColumnSignInPageFinder, findsOneWidget);
    });
    testWidgets('''WHEN opening the sign in page
    IT will show content that reflects the user is signing in and not signing up
    ''', (tester) async {
      final robot = Robot(tester);
      await robot.auth.pumpAuthPage(
        authService,
        isWeb: true,
        page: const SignInPage(),
      );
      final textFinderOne =
          find.text(robot.auth.appIntl.loginWithAOneTimeCodeWithEmail);
      expect(textFinderOne, findsOneWidget);
      final submitEmailButtonFinder = find.byKey(WidgetKeys.submitEmailButton);
      expect(submitEmailButtonFinder, findsOneWidget);
      final submitButton =
          submitEmailButtonFinder.evaluate().first.widget as ElevatedButton;
      final textField = submitButton.child! as Text;
      expect(textField.data, robot.auth.appIntl.sendCode);
    });
    testWidgets('''WHEN submitting an empty email
    IT will show an error text explaining that the email field cannot be empty
    ''', (tester) async {
      final robot = Robot(tester);
      await robot.auth.pumpAuthPage(
        authService,
        isWeb: true,
        page: const SignInPage(),
      );
      await robot.auth.expectEmailCannotBeEmpty();
    });
    testWidgets('''WHEN submitting an email with an invalid format
    IT will show an error text explaining that the email is invalid
    ''', (tester) async {
      final robot = Robot(tester);
      await robot.auth.pumpAuthPage(
        authService,
        isWeb: true,
        page: const SignInPage(),
      );
      await robot.auth.expectEmailIsInvalid();
    });
    testWidgets('''WHEN submitting an email for login 
    AND the email is not used by any user stored
    IT will show an error explaining that the email could not be found.
    ''', (tester) async {
      final robot = Robot(tester);
      when(() => authService.sendVerificationCodeByEmail(
            robot.auth.testEmail,
            robot.auth.locale.languageCode,
            VerificationType.login,
          )).thenThrow(EmailNotFoundException());
      await robot.auth.pumpAuthPage(
        authService,
        isWeb: true,
        page: const SignInPage(),
      );
      await robot.auth.expectEmailNotFound();
    });
    testWidgets('''WHEN submitting an email for login 
    AND an unknow error occurs
    IT will show an error explaining that an unknown error has occured.
    ''', (tester) async {
      final robot = Robot(tester);
      when(() => authService.sendVerificationCodeByEmail(
            robot.auth.testEmail,
            robot.auth.locale.languageCode,
            VerificationType.login,
          )).thenThrow(UnknownErrorException(Exception('mock error')));
      await robot.auth.pumpAuthPage(
        authService,
        isWeb: true,
        page: const SignInPage(),
      );
      robot.auth.expectEmailSubmitUnknowError();
    });
    testWidgets('''When submitting a valid email for login
    IT will show a circular progress indicator while loading''',
        (tester) async {
      //* run test in async to wait for all timers to finish
      await tester.runAsync(() async {
        final robot = Robot(tester);
        when(() => authService.sendVerificationCodeByEmail(
              robot.auth.testEmail,
              robot.auth.locale.languageCode,
              VerificationType.login,
              //* Add a delay to allow time for the loading to work
            )).thenAnswer((_) async => Future.delayed(
              const Duration(milliseconds: 100),
              () => Future.value(),
            ));
        when(() => authService.authStateChange())
            .thenAnswer((_) => const Stream<AppUser>.empty());
        when(() => authService.currentUser).thenReturn(null);
        await robot.auth.pumpAuthPage(
          authService,
          isWeb: true,
          page: const SignInPage(),
        );
        await robot.auth.expectSubmitEmailLoadingIndicator();
      });
    });
    testWidgets('''WHEN submitting an email for login 
    AND the email can be found in a stored user
    IT will show no error.
    ''', (tester) async {
      final robot = Robot(tester);
      when(() => authService.sendVerificationCodeByEmail(
            robot.auth.testEmail,
            robot.auth.locale.languageCode,
            VerificationType.login,
          )).thenAnswer((_) => Future.value());
      when(() => authService.authStateChange())
          .thenAnswer((_) => const Stream<AppUser>.empty());
      when(() => authService.currentUser).thenReturn(null);
      await robot.auth.pumpAuthPage(
        authService,
        isWeb: true,
        page: const SignInPage(),
      );
      await robot.auth.expectSubmitEmailSuccess();
    });
  });

  group('Sign up page', () {
    testWidgets('''WHEN opening the sign up page in a mobile device screen
    IT will show the web one column sign up page
    ''', (tester) async {
      final robot = Robot(tester);
      await robot.auth.pumpAuthPage(
        authService,
        isWeb: true,
        page: const SignUpPage(),
      );
      await robot.golden.setSurfaceSize(DeviceSizes.webMobile);
      final oneColumnSignInPageFinder =
          find.byType(OneColumnSignInSignUpSubmit);
      expect(oneColumnSignInPageFinder, findsOneWidget);
    });
    testWidgets('''WHEN opening the sign up page in a web tablet device screen
    IT will show the web one column sign up page
    ''', (tester) async {
      final robot = Robot(tester);
      await robot.auth.pumpAuthPage(
        authService,
        isWeb: true,
        page: const SignUpPage(),
      );
      await robot.golden.setSurfaceSize(DeviceSizes.webTablet);
      final oneColumnSignInPageFinder =
          find.byType(OneColumnSignInSignUpSubmit);
      expect(oneColumnSignInPageFinder, findsOneWidget);
    });
    testWidgets('''WHEN opening the sign up page
    IT will show content that reflects the user is signing up and not signing in
    ''', (tester) async {
      final robot = Robot(tester);
      await robot.auth.pumpAuthPage(
        authService,
        isWeb: true,
        page: const SignUpPage(),
      );
      final textFinderOne =
          find.text(robot.auth.appIntl.enterYourEmailForVerfication);
      expect(textFinderOne, findsOneWidget);
      final submitEmailButtonFinder = find.byKey(WidgetKeys.submitEmailButton);
      expect(submitEmailButtonFinder, findsOneWidget);
      final termsAndPrivacyCheckFinder = find.byType(TermsAndPrivacyCheck);
      expect(termsAndPrivacyCheckFinder, findsOneWidget);
      final submitButton =
          submitEmailButtonFinder.evaluate().first.widget as ElevatedButton;
      final textField = submitButton.child! as Text;
      expect(textField.data, robot.auth.appIntl.verifyEmail);
    });
    testWidgets(
        '''WHEN the user has not accepted the terms of service and privacy policy
    IT will not be able to press submit email
    ''', (tester) async {
      final robot = Robot(tester);
      await robot.auth.pumpAuthPage(
        authService,
        isWeb: true,
        page: const SignUpPage(),
      );
      await robot.auth.expectAcceptanceOfTermsAndPrivacyToBe(false);
      await robot.auth.expectSubmitEmailButtonEnabledToBe(false);
    });
    testWidgets(
        '''WHEN the user has accepted the terms of service and privacy policy
    IT will be able to press submit email
    ''', (tester) async {
      final robot = Robot(tester);
      await robot.auth.pumpAuthPage(
        authService,
        isWeb: true,
        page: const SignUpPage(),
      );
      await robot.auth.tapTermsAndPrivacyCheckBox();
      await robot.auth.expectAcceptanceOfTermsAndPrivacyToBe(true);
      await robot.auth.expectSubmitEmailButtonEnabledToBe(true);
    });
    testWidgets('''WHEN submitting an empty email
    IT will show an error text explaining that the email field cannot be empty
    ''', (tester) async {
      final robot = Robot(tester);
      await robot.auth.pumpAuthPage(
        authService,
        isWeb: true,
        page: const SignUpPage(),
      );
      await tester.runAsync(() async {
        await robot.auth.tapTermsAndPrivacyCheckBox();
        await robot.auth.expectEmailCannotBeEmpty();
      });
    });
    testWidgets('''WHEN submitting an email with an invalid format
    IT will show an error text explaining that the email is invalid
    ''', (tester) async {
      final robot = Robot(tester);
      await robot.auth.pumpAuthPage(
        authService,
        isWeb: true,
        page: const SignUpPage(),
      );
      await robot.auth.tapTermsAndPrivacyCheckBox();
      await robot.auth.expectEmailIsInvalid();
    });
    testWidgets('''WHEN submitting an email to create an account 
    AND the email is already in use by another stored user
    IT will show an error explaining that the email already exists.
    ''', (tester) async {
      final robot = Robot(tester);
      when(() => authService.sendVerificationCodeByEmail(
            robot.auth.testEmail,
            robot.auth.locale.languageCode,
            VerificationType.register,
          )).thenThrow(EmailAlreadyExistsException());
      await robot.auth.pumpAuthPage(
        authService,
        isWeb: true,
        page: const SignUpPage(),
      );
      await robot.auth.tapTermsAndPrivacyCheckBox();
      await robot.auth.expectEmailAlreadyExists();
    });
    testWidgets('''WHEN submitting an email for login 
    AND an unknow error occurs
    IT will show an error explaining that an unknown error has occured.
    ''', (tester) async {
      final robot = Robot(tester);
      when(() => authService.sendVerificationCodeByEmail(
            robot.auth.testEmail,
            robot.auth.locale.languageCode,
            VerificationType.login,
          )).thenThrow(UnknownErrorException(Exception('mock error')));
      await robot.auth.pumpAuthPage(
        authService,
        isWeb: true,
        page: const SignUpPage(),
      );
      await robot.auth.tapTermsAndPrivacyCheckBox();
      robot.auth.expectEmailSubmitUnknowError();
    });
    testWidgets('''When submitting a valid email for login
    IT will show a circular progress indicator while loading''',
        (tester) async {
      //* run test in async to wait for all timers to finish
      await tester.runAsync(() async {
        final robot = Robot(tester);
        when(() => authService.sendVerificationCodeByEmail(
              robot.auth.testEmail,
              robot.auth.locale.languageCode,
              VerificationType.login,
              //* Add a delay to allow time for the loading to work
            )).thenAnswer((_) async => Future.delayed(
              const Duration(milliseconds: 100),
              () => Future.value(),
            ));
        when(() => authService.authStateChange())
            .thenAnswer((_) => const Stream<AppUser>.empty());
        when(() => authService.currentUser).thenReturn(null);
        await robot.auth.pumpAuthPage(
          authService,
          isWeb: true,
          page: const SignUpPage(),
        );
        await robot.auth.tapTermsAndPrivacyCheckBox();
        await robot.auth.expectSubmitEmailLoadingIndicator();
      });
    });
    testWidgets('''WHEN submitting an email for login 
    AND the email can be found in a stored user
    IT will show no error.
    ''', (tester) async {
      final robot = Robot(tester);
      when(() => authService.sendVerificationCodeByEmail(
            robot.auth.testEmail,
            robot.auth.locale.languageCode,
            VerificationType.register,
          )).thenAnswer((_) => Future.value());
      when(() => authService.authStateChange())
          .thenAnswer((_) => const Stream<AppUser>.empty());
      when(() => authService.currentUser).thenReturn(null);
      await robot.auth.pumpAuthPage(
        authService,
        isWeb: true,
        page: const SignUpPage(),
      );
      await robot.auth.tapTermsAndPrivacyCheckBox();
      await robot.auth.expectSubmitEmailSuccess();
    });
  });
}
