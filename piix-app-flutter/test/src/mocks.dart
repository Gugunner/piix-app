import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:piix_mobile/src/features/authentication/data/fake_auth_repository.dart';
import 'package:piix_mobile/src/network/app_dio.dart';

class MockDio extends Mock implements Dio {}

class MockAppDio extends Mock implements AppDio {}

class MockAuthRepository extends Mock implements FakeAuthRepository {}
