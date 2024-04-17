import 'package:piix_mobile/src/features/authentication/application/auth_service.dart';
import 'package:piix_mobile/src/features/authentication/data/auth_repository.dart';
import 'package:piix_mobile/src/features/authentication/domain/authentication_model_barrel_file.dart';
import 'package:piix_mobile/src/network/app_exception.dart';
import 'package:piix_mobile/src/utils/delay.dart';
import 'package:piix_mobile/src/utils/fake_memory_store.dart';

/// A fake implementation of [AuthService] for testing purposes.
class FakeAuthService implements AuthService {
  FakeAuthService({this.addDelay = false});

  final bool addDelay;

  /// A [FakeMemoryStore] to store the current user.
  final _authState = FakeMemoryStore<AppUser?>(null);

  /// Emits the current user when it changes.
  @override
  Stream<AppUser?> authStateChange() {
    // If the current user is not null and the email is verified,
    if (_authState.value != null && _authState.value!.emailVerified) {
      // Emit the current user.
      return _authState.stream;
    } else {
      // Otherwise, emit null.
      return Stream.value(null);
    }
  }

  /// Emits the current user when the id token changes.
  @override
  Stream<AppUser?> idTokenChanges() {
    // If the current user is not null and the email is verified,
    if (_authState.value != null && _authState.value!.emailVerified) {
      // Emit the current user.
      return _authState.stream;
    } else {
      // Otherwise, emit null.
      return Stream.value(null);
    }
  }

  ///A list where all the users are stored.
  final List<FakeAppUser> _users = [];

  /// Returns a list of all the users.
  List<FakeAppUser> readUsers() => _users;

  /// Returns the current user.
  @override
  AppUser? get currentUser => _authState.value;

  /// Sends a verification code to the user's email.
  @override
  Future<void> sendVerificationCodeByEmail(
    String email,
    String languageCode,
    VerificationType verificationType,
  ) {
    if (addDelay) {
      delay(addDelay);
    }
    //Iterates over each user to find if the email already exists.
    for (final user in _users) {
      if (user.email == email) {
        //If the email already exists, returns an empty value an exits
        //the function.
        return Future.value();
      }
    }
    //If the email does not exist, prepare the user for future verification.
    _prepareNewUserForVerification(email, '123456');
    //Return an empty value and exits the function.
    return Future.value();
  }

  /// Creates an account with the email and verification code.
  @override
  Future<void> createAccountWithEmailAndVerificationCode(
      String email, String verificationCode) {
    if (addDelay) {
      delay(addDelay);
    }
    //Iterates over each user to find if the email already exists or if the
    //verification code is correct for a user already set.
    for (final user in _users) {
      //Obtain the uid from the email
      final uid = _toUidOrEmail(email);
      //Check if the email already exists.
      if (user.email == email) {
        //Set the current user to null.
        _authState.value = null;
        throw EmailAlreadyExistsException();
      }
      //If the user is already set
      else if (user.uid == uid) {
        //Check the verification code
        if (user.verificationCode != verificationCode) {
          //If the verification code is incorrect, set the current user to null
          _authState.value = null;
          throw IncorrectVerificationCodeException();
        }
        //If the verification code is correct, verify the new user.
        _verifyNewUser(uid);
        //Return an empty value and exits the function.
        return Future.value();
      }
    }
    //If the user has not been set, set the current user to null.
    _authState.value = null;
    throw UnkownErrorException(Exception('mock error'));
  }

  /// Signs in with the email and verification code.
  @override
  Future<void> signInWithEmailAndVerificationCode(
      String email, String verificationCode) {
    if (addDelay) {
      delay(addDelay);
    }
    //Iterates over each user to find if the email already exists or if the
    //verification code is correct for a user already set.
    for (final user in _users) {
      //Check if the email already exists.
      if (user.email == email) {
        //Check the verification code
        if (user.verificationCode != verificationCode) {
          //If the verification code is incorrect, set the current user to null
          _authState.value = null;
          throw IncorrectVerificationCodeException();
        }
        //If the verification code is correct, set the current user to the user
        //and return empty value and exits the function.
        _authState.value = user;
        return Future.value();
      }
    }
    //If the user has not been created, set the current user to null.
    _authState.value = null;
    throw EmailNotFoundException();
  }

  /// Signs out the current user.
  @override
  Future<void> signOut() {
    if (addDelay) {
      delay(addDelay);
    }
    //Set the current user to null.
    _authState.value = null;
    return Future.value();
  }

  /// Disposes the [FakeMemoryStore] instance.
  void dispose() => _authState.dispose();

  /// Prepares a new user for verification.
  void _prepareNewUserForVerification(String email, String verificationCode) {
    //Create a new user with the email and verification code.
    final user = FakeAppUser(
      uid: _toUidOrEmail(email),
      email: '',
      emailVerified: false,
      verificationCode: verificationCode,
    );
    //Add the user to the list of users.
    _users.add(user);
  }

  /// Verifies a new user.
  void _verifyNewUser(
    String uid,
  ) {
    //Find the index of the user in the list of users.
    final userIndex = _users.indexWhere((user) => user.uid == uid);
    //Set the email of the user to the uid and set the email verified to true.
    _users[userIndex] = _users[userIndex].copyWith(
      email: _toUidOrEmail(uid),
      emailVerified: true,
    );
    //Set the current user to the user.
    _authState.value = _users[userIndex];
  }

  /// Converts a uid to an email by reversing it and viceversa.
  String _toUidOrEmail(String str) => str.split('').reversed.join();
}
