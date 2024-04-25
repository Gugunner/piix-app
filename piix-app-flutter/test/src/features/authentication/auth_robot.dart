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
import 'package:flutter_gen/gen_l10n/app_intl.dart';
import 'package:piix_mobile/src/theme/theme_barrel_file.dart';

///Helper class for testing Widgets in the authentication feature.
class AuthRobot {
  AuthRobot(this.tester, this.locale);

  final WidgetTester tester;
  final Locale locale;

  final testEmail = 'email@gmail.com';

  AppIntl get appIntl => lookupAppIntl(locale);

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
          designSize: isWeb ? webDesignSize : appDesignSize,
          minTextAdapt: true,
          builder: ((context, child) {
            return MaterialApp(
              home: page,
              theme: AppTheme.themeData,
              locale: locale,
              supportedLocales: AppIntl.supportedLocales,
              localizationsDelegates: AppIntl.localizationsDelegates,
            );
          }),
        ),
      ),
      // Durations.long4,
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
    expect(textField.decoration!.hintText, appIntl.enterYourEmail);
    return textField;
  }

  Future<void> expectEmailCannotBeEmpty() async {
    await tapSubmitEmailButton();
    final textField = expectToReturnEmailFormField();
    expect(textField.decoration!.errorText, appIntl.emptyEmailField);
  }

  Future<void> expectEmailIsInvalid() async {
    await enterEmail(testEmail.substring(0, 3));
    await tapSubmitEmailButton();
    final textField = expectToReturnEmailFormField();
    expect(textField.decoration!.errorText, appIntl.invalidEmail);
  }

  Future<void> expectEmailNotFound() async {
    await enterEmail(testEmail);
    await tapSubmitEmailButton();
    final textField = expectToReturnEmailFormField();
    expect(textField.decoration!.errorText, appIntl.emailNotFound);
  }

  Future<void> expectEmailAlreadyExists() async {
    await enterEmail(testEmail);
    await tapSubmitEmailButton();
    final textField = expectToReturnEmailFormField();
    expect(textField.decoration!.errorText, appIntl.emailAlreadyExists);
  }

  Future<void> expectEmailSubmitUnknowError() async {
    await enterEmail(testEmail);
    await tapSubmitEmailButton();
    final textField = expectToReturnEmailFormField();
    expect(textField.decoration!.errorText, appIntl.unknownError);
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
