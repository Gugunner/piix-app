import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:piix_mobile/src/features/authentication/presentation/common_widgets/verification_code_input/countdown_timer_controller.dart';
import 'package:piix_mobile/src/theme/theme_barrel_file.dart';
import 'package:piix_mobile/src/utils/text_duration.dart';

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
    Duration? timerDuration,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authServiceProvider.overrideWithValue(authService),
          platformProvider.overrideWith((ref) => platform),
          isWebProvider.overrideWithValue(isWeb),
          resendCodeTimerProvider.overrideWith(
            (ref) => CountDownNotifier(
              timerDuration ?? const Duration(seconds: 3),
            ),
          ),
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
    //** Ensure the checkbox is visible by scrolling before tapping */
    await tester.ensureVisible(checkBoxFinder);
    await tester.tap(checkBoxFinder);
    await tester.pumpAndSettle();
  }

  Future<void> tapButtonByKey({
    bool pupmAndSettle = true,
    required Key widgetKey,
  }) async {
    final submitButtonFinder = find.byKey(widgetKey);
    expect(submitButtonFinder, findsOneWidget);
    //** Ensure the checkbox is visible by scrolling before tapping */
    await tester.ensureVisible(submitButtonFinder);
    //** Use direct call instead of tester tap to prevent errors when using tap sequentially such as tap checkbox then tap button*/
    final button =
        submitButtonFinder.evaluate().first.widget as ButtonStyleButton;
    button.onPressed!.call();
    if (pupmAndSettle) {
      await tester.pumpAndSettle();
      return;
    }
    await tester.pump();
  }

  Future<void> expectButtonByKeyToBeEnabled(
    bool enabled, {
    required Key widgetKey,
  }) async {
    final submitButtonFinder = find.byKey(widgetKey);
    expect(submitButtonFinder, findsOneWidget);
    final submitButton =
        submitButtonFinder.evaluate().first.widget as ButtonStyleButton;
    expect(submitButton.enabled, enabled ? isTrue : isFalse);
    expect(submitButton.onPressed, enabled ? isNotNull : isNull);
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
    await tapButtonByKey(widgetKey: WidgetKeys.submitEmailButton);
    final textField = expectToReturnEmailFormField();
    expect(textField.decoration!.errorText, appIntl.emptyEmailField);
  }

  Future<void> expectEmailIsInvalid() async {
    await enterEmail(testEmail.substring(0, 3));
    await tapButtonByKey(widgetKey: WidgetKeys.submitEmailButton);
    final textField = expectToReturnEmailFormField();
    expect(textField.decoration!.errorText, appIntl.invalidEmail);
  }

  Future<void> expectEmailNotFound() async {
    await enterEmail(testEmail);
    await tapButtonByKey(widgetKey: WidgetKeys.submitEmailButton);
    final textField = expectToReturnEmailFormField();
    expect(textField.decoration!.errorText, appIntl.emailNotFound);
  }

  Future<void> expectEmailAlreadyExists() async {
    await enterEmail(testEmail);
    await tapButtonByKey(widgetKey: WidgetKeys.submitEmailButton);
    final textField = expectToReturnEmailFormField();
    expect(textField.decoration!.errorText, appIntl.emailAlreadyExists);
  }

  Future<void> expectEmailSubmitUnknowError() async {
    await enterEmail(testEmail);
    await tapButtonByKey(widgetKey: WidgetKeys.submitEmailButton);
    final textField = expectToReturnEmailFormField();
    expect(textField.decoration!.errorText, appIntl.unknownError);
  }

  Future<void> expectSubmitEmailLoadingIndicator() async {
    await enterEmail(testEmail);
    await tapButtonByKey(
        pupmAndSettle: false, widgetKey: WidgetKeys.submitEmailButton);
    final progressIndicator = find.byType(CircularProgressIndicator);
    expect(progressIndicator, findsOneWidget);
  }

  Future<void> expectSubmitEmailSuccess() async {
    await enterEmail(testEmail);
    await tapButtonByKey(widgetKey: WidgetKeys.submitEmailButton);
    final textField = expectToReturnEmailFormField();
    expect(textField.controller!.text, isEmpty);
  }

  Future<void> expectTextInTimeToBe(Duration duration) async {
    final textFinder = find.byKey(WidgetKeys.countDownText);
    expect(textFinder, findsOneWidget);
    final text = textFinder.evaluate().first.widget as Text;
    expect(text.textSpan, isNotNull);
    final textInTime = text.textSpan!.toPlainText().split(' ')[1];
    expect(textInTime, duration.minutesAndSeconds);
  }

  void expectExactlyNSingleCodeBoxes(int n) {
    final singleCodeBoxFinder = find.byType(TextField);
    expect(singleCodeBoxFinder, findsExactly(n));
  }

  Future<void> enterVerificationCode({bool reverseCode = false}) async {
    final singleCodeBoxFinder = find.byType(TextField);
    final singleCodeBoxes = singleCodeBoxFinder.evaluate().toList();
    final numberOfBoxes = singleCodeBoxes.length;
    for (var i = 0; i < numberOfBoxes; i++) {
      await expectSingleCodeBoxHaveFocusAt(i, finder: singleCodeBoxFinder);
      if (reverseCode) {
        await tester.enterText(
            singleCodeBoxFinder.at(i), '${numberOfBoxes - i}');
      } else {
        await tester.enterText(singleCodeBoxFinder.at(i), '${i + 1}');
      }
      await tester.pumpAndSettle();
      await expectSingleCodeBoxHaveFocusAt(
        i,
        hasFocus: false,
        finder: singleCodeBoxFinder,
      );
    }
  }

  Future<void> deleteSingleCodeBoxAt(int boxNumber) async {
    final singleCodeBoxFinder = find.byType(TextField);
    await tester.tap(
      singleCodeBoxFinder.at(boxNumber),
    );
    await tester.pumpAndSettle();
    const invisibleChar = '\u200B';
    await expectSingleCodeBoxHaveFocusAt(
      boxNumber,
      finder: singleCodeBoxFinder,
    );
    final currentSingleCodeBox =
        singleCodeBoxFinder.at(boxNumber).evaluate().first.widget as TextField;
    expect(currentSingleCodeBox.controller, isNotNull);
    //* Simulates first backspace call
    currentSingleCodeBox.controller!.text = invisibleChar;
    expect(currentSingleCodeBox.controller!.text, invisibleChar);
    //*Simulates second backspace call
    currentSingleCodeBox.controller!.text = '';
    await tester.pumpAndSettle();
    await expectSingleCodeBoxHaveFocusAt(
      boxNumber,
      hasFocus: false,
      finder: singleCodeBoxFinder,
    );
  }

  Future<void> expectSingleCodeBoxHaveFocusAt(
    int boxNumber, {
    bool hasFocus = true,
    Finder? finder,
  }) async {
    final singleCodeBoxFinder = finder ?? find.byType(TextField);
    final codeBoxTextField =
        singleCodeBoxFinder.at(boxNumber).evaluate().first.widget as TextField;
    expect(codeBoxTextField.focusNode, isNotNull);
    expect(codeBoxTextField.focusNode!.hasFocus, hasFocus ? isTrue : isFalse);
  }

  Future<void> expectSubmitVerificationCodeUnknownException() async {
    await enterVerificationCode(reverseCode: true);
    await tapButtonByKey(
      widgetKey: WidgetKeys.submitVerificationCodeButton,
    );
    final textFinder = find.text(appIntl.unknownError);
    expect(textFinder, findsOneWidget);
  }

  Future<void> expectSubmitVerificationCodeSuccess() async {
    expectExactlyNSingleCodeBoxes(6);
    await enterVerificationCode();
    await tapButtonByKey(widgetKey: WidgetKeys.submitVerificationCodeButton);
    final progressIndicator = find.byType(CircularProgressIndicator);
    expect(progressIndicator, findsNothing);
    var textFinder = find.text(appIntl.unknownError);
    expect(textFinder, findsNothing);
    textFinder = find.text(appIntl.incorrectVerificationCode);
    expect(textFinder, findsNothing);
  }

  Future<void> expectCountdownToFinish(
      Duration testDuration, Duration longerTestDuration) async {
    await expectTextInTimeToBe(testDuration);
    await expectButtonByKeyToBeEnabled(
      false,
      widgetKey: WidgetKeys.requestNewCodebutton,
    );
    await tester.pumpAndSettle(longerTestDuration);
    await expectButtonByKeyToBeEnabled(
      true,
      widgetKey: WidgetKeys.requestNewCodebutton,
    );
    await expectTextInTimeToBe(Duration.zero);
  }
}
