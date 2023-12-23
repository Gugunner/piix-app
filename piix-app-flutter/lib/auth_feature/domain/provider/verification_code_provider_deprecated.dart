import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/auth_feature/domain/model/auth_user_model.dart';
import 'package:piix_mobile/utils/list_utils.dart';
import 'package:piix_mobile/utils/log_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'verification_code_provider_deprecated.g.dart';

@Deprecated('Will be removed in 4.0')

///All the possible states when choosing
///the correct mode to verify a code
enum VerificationModeStateDeprecated {
  idle,
  authenticating,
  authorizing,
  updating,
  //TODO: Use updating instead of completing
  completing,
  adding,
}

@Deprecated('Will be removed in 4.0')

///All the possible states when verifying
///a code
enum VerificationStateDeprecated {
  idle,
  conflict,
  error,
  success;

  bool get generalError {
    switch (this) {
      case VerificationStateDeprecated.conflict:
      case VerificationStateDeprecated.error:
        return true;
      default:
        return false;
    }
  }

  bool get wrongCode => this == VerificationStateDeprecated.conflict;

  bool get unexpectedError => this == VerificationStateDeprecated.error;
}

@Deprecated('Will be removed in 4.0')

///The provider that handles the state of the verification code
///the user enters when verifying the phone number or email.
@riverpod
class VerificationCode extends _$VerificationCode {
  ///Adds a value to the list at the end if value is not passed
  ///it always adds -1.
  void _addValue([int? value = -1]) => state = [...state, value];

  ///Sets the value at the selected index in the list
  void setVerificationCodeBy(int index, {int? value}) {
    final element = state.guardElementAt<int?>(index);
    if (element == null) return _handleValueBy(index, value: value);
    state = state.updateIndexValue<int?>(index, value: value);
  }

  ///Adds missing values if index is bigger than the current list
  ///length. And adds the value at the corresponding index.
  void _handleValueBy(int index, {int? value}) {
    for (var i = 0; i < index; i++) {
      final element = state.guardElementAt<int?>(i);
      if (element == null) {
        _addValue();
      }
    }
    _addValue(value);
  }

  @override
  String toString() => state.isNotEmpty ? state.join('') : '';

  @override
  List<int?> build() => [];

  List<int?> get verificationCode => state;

  void setVerificationCode(List<int?> verificationCode) {
    state = verificationCode;
  }
}

@Deprecated('Will be removed in 4.0')

///Provider that handles what is the verification code being used for
///either to sign in, sign up, update credentials or add a protected.
@Riverpod(keepAlive: true)
class VerificationMode extends _$VerificationMode {
  @override
  VerificationModeStateDeprecated build() =>
      VerificationModeStateDeprecated.idle;

  VerificationModeStateDeprecated get verificationModeState => state;
  void setVerificationModeState(VerificationModeStateDeprecated mode) {
    state = mode;
  }
}

@Deprecated('Will be removed in 4.0')
@Riverpod(keepAlive: true)
class VerificationStatePod extends _$VerificationStatePod {
  @override
  VerificationStateDeprecated build() => VerificationStateDeprecated.idle;

  void setVerificationState(VerificationStateDeprecated value) {
    state = value;
  }
}

///A simple state provider to store the hashable unix time
///that is stored in the local user data and in the server
///to create a hash id
final hashableUnixTimeProvider =
    StateProvider<int>((ref) => DateTime.now().millisecondsSinceEpoch);

@Deprecated('Will be removed in 4.0')

///The provider that handles verifying the code
///and sets the [verificationStatePodProvider] value
///in the request.
@riverpod
class VerifyCodeService extends _$VerifyCodeService
    with LogApiCall, LogAppCall {
  @override
  FutureOr<void> build({bool updateCredential = false}) => {};
  // _verifyCode(updateCredential);

  // @Deprecated('Will be removed in 4.0')
  ///Returns an [AuthUserModel] of [modelType] credential
  // Future<AuthUserModel> _getAuthModel([bool updateCredential = false]) async {
  //   final usernameCredential = ref
  //       .read(usernameCredentialProvider.notifier)
  //       .completeUsernameCredential;
  //   final authMethod = ref.read(authMethodStateProvider);
  //   final verificationCode =
  //       ref.read(verificationCodeProvider.notifier).toString();
  //   if (updateCredential) {
  //     final userId =
  //         ref.read(userPodProvider.select((value) => value?.userId ?? ''));
  //     return AuthUserModel.updateCredential(
  //       userId: userId,
  //       usernameCredential: usernameCredential,
  //       verificationCode: verificationCode,
  //       authMethod: authMethod,
  //     );
  //   }
  //   final authUser =
  //       ref.read(authUserNotifierPodProvider.select((value) => value.value));
  //   //Get a unix time that is used for a hashing key by the server
  //   //to help with automatic sign in. Only used if the user is signing
  //   //in or signing up
  //   final hashableUnixTime = ref.read(hashableUnixTimeProvider.notifier).state;
  //   return AuthUserModel.verification(
  //     usernameCredential: usernameCredential,
  //     authMethod: authMethod,
  //     verificationCode: verificationCode,
  //     hashableUnixTime: authUser?.hashableUnixTime ?? hashableUnixTime,
  //   );
  // }

  ///Calls [verifyCode] and sets the [verificationStatePod] value
  // Future<void> _verifyCode([bool updateCredential = false]) async {
  //   final verificationCodeService =
  //       ref.read(verificationCodeServiceRepositoryProvider.notifier);
  //   try {
  //     final authModel = await _getAuthModel(updateCredential);
  //     final user = await verificationCodeService.verifyCode(authModel);
  //     ref.read(userPodProvider.notifier).set(user);
  //     final hashableUnixTime =
  //         ref.read(hashableUnixTimeProvider.notifier).state;
  //     //Store the user with the hashableUnixTime as the watch in the
  //     //authUserProvider runs after the authModel is retrieved when getting
  //     //the [customAccessToken] which sends an empty authModel
  //     await ref
  //         .read(authUserNotifierPodProvider.notifier)
  //         .store(hashableUnixTime);
  //     ref
  //         .read(verificationStatePodProvider.notifier)
  //         .setVerificationState(VerificationStateDeprecated.success);
  //   } catch (error) {
  //     if (error is! DioError) {
  //       logError(error, className: 'VerificationCodeService');
  //       rethrow;
  //     }
  //     logDioException(error, className: 'VerificationCodeService');
  //     final statusCode = error.response?.statusCode ?? 500;
  //     final verificationCodeState = statusCode == HttpStatus.conflict
  //         ? VerificationStateDeprecated.conflict
  //         : VerificationStateDeprecated.error;
  //     ref
  //         .read(verificationStatePodProvider.notifier)
  //         .setVerificationState(verificationCodeState);
  //     rethrow;
  //   }
  // }
}

@Deprecated('Will be removed in 4.0')

///The provider that handles the sending again the crendentials
///to receieve a new verification code.
@riverpod
class SendCredentialService extends _$SendCredentialService
    with LogApiCall, LogAppCall {
  ///Returns an [AuthUserModel] of [modelType] credential
  // AuthUserModel get _authModel {
  //   final usernameCredential = ref
  //       .read(usernameCredentialProvider.notifier)
  //       .completeUsernameCredential;
  //   final authMethod = ref.read(authMethodStateProvider);
  //   return AuthUserModel.credential(
  //     usernameCredential: usernameCredential,
  //     authMethod: authMethod,
  //   );
  // }

  @override
  FutureOr<void> build() => _sendCredential();

  ///Sends the [AuthUserModel] information to request a new
  ///verification code.
  Future<void> _sendCredential() async {
    //Call the request to obtain a verification code either by email or phone
    // final authCredentialService =
    //     ref.read(authCredentialServiceRepositoryProvider.notifier);
    // try {
    //   return await authCredentialService.sendCredential(_authModel);
    // } catch (error) {
    //   if (error is! DioError) if (error is! DioError) {
    //     logError(error, className: 'VerificationCodeService');
    //     rethrow;
    //   }
    //   logDioException(error, className: 'SendCredentialService');
    //   rethrow;
    // }
  }
}
