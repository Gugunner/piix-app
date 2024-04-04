import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:piix_mobile/src/features/authentication/application/auth_service_barrel_file.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:piix_mobile/src/features/authentication/data/fake_auth_repository.dart';
import 'package:piix_mobile/src/network/app_dio.dart';

/// Sets up the mocks for Firebase Core
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockFirebaseUser extends Mock implements User {}

typedef Callback = void Function(MethodCall call);

void setupFirebaseAuthMocks([Callback? customHandlers]) {
  TestWidgetsFlutterBinding.ensureInitialized();

  setupFirebaseCoreMocks();
}

/// Sets up the mocks for Http Requests

class MockDio extends Mock implements Dio {}

class MockAppDio extends Mock implements AppDio {}

/// Sets up the mocks for Authentication
class MockAuthRepository extends Mock implements FakeAuthRepository {}

class MockAuthService extends Mock implements AuthService {}

class MockFakeAuthService extends Mock implements FakeAuthService {}
