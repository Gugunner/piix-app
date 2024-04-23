import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piix_mobile/app_bootstrap.dart';
import 'package:piix_mobile/src/constants/app_sizes.dart';
import 'package:piix_mobile/src/constants/widget_keys.dart';
import 'package:piix_mobile/src/features/authentication/application/auth_service_barrel_file.dart';
import 'package:piix_mobile/src/features/authentication/presentation/authentication_page_barrel_file.dart';
import 'package:piix_mobile/src/features/authentication/presentation/common_widgets/terms_and_privacy_check.dart';
import 'package:piix_mobile/src/localization/string_hardcoded.dart';

///Helper class for testing Widgets in the authentication feature.
class AuthRobot {
  AuthRobot(this.tester);

  final WidgetTester tester;

  final testEmail = 'email@gmail.com';
  final testLanguageCode = 'en';

  ///Pumps the [WelcomePage] and overrides
  ///the [authServiceProvider] with the passed
  ///[authService].
  Future<void> pumpAuthPage(
    FakeAuthService authService, {
    isWeb = false,
    platform = TargetPlatform,
    page = const WelcomePage(),
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authServiceProvider.overrideWithValue(authService),
          platformProvider.overrideWith((ref) => platform),
          isWebProvider.overrideWithValue(isWeb)
        ],
        child: ScreenUtilInit(
          designSize: isWeb ? webDesignSize : appDesigSize,
          minTextAdapt: true,
          child: MaterialApp(
            home: page,
          ),
        ),
      ),
      Durations.long4,
    );
    await tester.pumpAndSettle();
  }

  Future<void> tapTermsAndPrivacyCheckBox() async {
    final checkBoxFinder = find.byType(Checkbox);
    expect(checkBoxFinder, findsOneWidget);
    await tester.tap(checkBoxFinder);
    await tester.pumpAndSettle();
  }

  Future<void> tapSubmitEmailButton({bool pupmAndSettle = true}) async {
    final submitButtonFinder = find.byKey(WidgetKeys.submitEmailButton);
    expect(submitButtonFinder, findsOneWidget);
    //** Use direct call instead of tester tap to prevent errors when using tap sequentially such as tap checkbox then tap button*/
    final submitButton =
        submitButtonFinder.evaluate().first.widget as ElevatedButton;
    submitButton.onPressed!.call();
    if (pupmAndSettle) {
      await tester.pumpAndSettle();
      return;
    }
    await tester.pump();
  }

  Future<void> expectAcceptanceOfTermsAndPrivacyToBe(bool check) async {
    final termsAndPrivacyCheckFinder = find.byType(TermsAndPrivacyCheck);
    expect(termsAndPrivacyCheckFinder, findsOneWidget);
    final termsAndPrivacyCheck = termsAndPrivacyCheckFinder
        .evaluate()
        .first
        .widget as TermsAndPrivacyCheck;
    expect(termsAndPrivacyCheck.check, check ? isTrue : isFalse);
  }

  Future<void> expectSubmitEmailButtonEnabledToBe(bool enabled) async {
    final submitButtonFinder = find.byKey(WidgetKeys.submitEmailButton);
    expect(submitButtonFinder, findsOneWidget);
    final submitButton =
        submitButtonFinder.evaluate().first.widget as ButtonStyleButton;
    expect(submitButton.enabled, enabled ? isTrue : isFalse);
    expect(submitButton.onPressed, enabled ? isNotNull : isNull);
  }

  Future<void> enterEmail(String email) async {
    final textFieldFinder = find.byType(TextField);
    await tester.enterText(textFieldFinder, email);
    await tester.pumpAndSettle();
  }

  TextField expectToReturnEmailFormField() {
    final textFieldFinder = find.byType(TextField);
    expect(textFieldFinder, findsOneWidget);
    final textField = textFieldFinder.evaluate().first.widget as TextField;
    expect(textField.decoration!.hintText, 'Enter your email'.hardcoded);
    return textField;
  }

  Future<void> expectEmailCannotBeEmpty() async {
    await tapSubmitEmailButton();
    final textField = expectToReturnEmailFormField();
    expect(textField.decoration!.errorText,
        'The email field cannot be empty.'.hardcoded);
  }

  Future<void> expectEmailIsInvalid() async {
    await enterEmail(testEmail.substring(0, 3));
    await tapSubmitEmailButton();
    final textField = expectToReturnEmailFormField();
    expect(textField.decoration!.errorText, 'The email is invalid.'.hardcoded);
  }

  Future<void> expectEmailNotFound() async {
    await enterEmail(testEmail);
    await tapSubmitEmailButton();
    final textField = expectToReturnEmailFormField();
    expect(textField.decoration!.errorText,
        'The email could not be found.'.hardcoded);
  }

  Future<void> expectEmailAlreadyExists() async {
    await enterEmail(testEmail);
    await tapSubmitEmailButton();
    final textField = expectToReturnEmailFormField();
    expect(textField.decoration!.errorText,
        'That email is already in use.'.hardcoded);
  }

  Future<void> expectEmailSubmitUnknowError() async {
    await enterEmail(testEmail);
    await tapSubmitEmailButton();
    final textField = expectToReturnEmailFormField();
    expect(
      textField.decoration!.errorText,
      'We are sorry, an unknow error has occured.'.hardcoded,
    );
  }

  Future<void> expectSubmitEmailLoadingIndicator() async {
    await enterEmail(testEmail);
    await tapSubmitEmailButton(pupmAndSettle: false);
    final progressIndicator = find.byType(CircularProgressIndicator);
    expect(progressIndicator, findsOneWidget);
  }

  Future<void> expectSubmitEmailSuccess() async {
    await enterEmail(testEmail);
    await tapSubmitEmailButton();
    final textField = expectToReturnEmailFormField();
    expect(textField.controller!.text, isEmpty);
  }
}
