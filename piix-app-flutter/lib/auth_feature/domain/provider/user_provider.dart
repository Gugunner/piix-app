import 'package:logger/logger.dart';
import 'package:piix_mobile/auth_feature/domain/model/auth_user_model.dart';
import 'package:piix_mobile/auth_feature/domain/model/user_app_model.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_input_provider.dart';
import 'package:piix_mobile/form_feature/domain/model/form_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/api/local/app_shared_preferences.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

///The single instance for the [UserAppModel]
///state management.
@Riverpod(keepAlive: true)
class UserPod extends _$UserPod {
  @override
  UserAppModel? build() => null;

  UserAppModel? get user => state;

  //TODO: Update to the new personal information form once service is deployed
  ///Stores a copy of the [user] with the personal information
  void setUpPersonalInformation() {
    if (state == null) return;
    final form = ref.read(formNotifierProvider);
    //The form includes information that the user needs to have, to avoid
    //requesting again the user, from each form field tha value is obtained
    //to be stored in the local user state
    final name = form?.formFieldResponseBy('name');
    final middleName = form?.formFieldResponseBy('middleName');
    final firstLastName = form?.formFieldResponseBy('firstLastName');
    final secondLastName = form?.formFieldResponseBy('secondLastName');
    final email = form?.formFieldResponseBy('email');
    final phoneNumber = form?.formFieldResponseBy('phoneNumber');
    final dateOfBirth = form?.formFieldResponseBy('birthdate');
    final genderId = form?.formFieldResponseBy('genderId');
    final genderName = form?.formFieldBy('genderId')?.stringResponse;
    final countryId = form?.formFieldResponseBy('countryId');
    final countryName = form?.formFieldBy('countryId')?.stringResponse;
    final stateId = form?.formFieldResponseBy('stateId');
    final stateName = form?.formFieldBy('stateId')?.stringResponse;
    final zipCode = form?.formFieldResponseBy('zipCode');
    final planId = form?.formFieldResponseBy('planId');

    ///Since the user has already verified one of the
    ///credentials the other one will become true
    var verifiedEmail = state!.emailVerified;
    var verifiedPhone = state!.phoneVerified;
    if (!verifiedPhone) verifiedPhone = true;
    if (!verifiedEmail) verifiedEmail = true;
    final user = state!.copyWith(
      name: name,
      middleName: middleName,
      firstLastName: firstLastName,
      secondLastName: secondLastName,
      email: email,
      phoneNumber: phoneNumber,
      birthdate: toDateTime(dateOfBirth),
      genderId: genderId,
      genderName: genderName,
      countryId: countryId,
      countryName: countryName,
      stateId: stateId,
      stateName: stateName,
      zipCode: zipCode,
      planId: planId,
      processingStatus: UserAuthenticationStatus.IDLE,
      emailVerified: verifiedEmail,
      phoneVerified: verifiedPhone,
    );
    set(user);
  }

  @Deprecated('Will be removed in 4.0')

  ///Stores a copy of the [user] with the documentaion information
  void setUpDocumentation() {
    final form = ref.read(formNotifierProvider);
    //The form includes information that the user needs to have, to avoid
    //requesting again the user, from then unique id form field tha value
    //is obtained to be stored in the local user state
    final uniqueId = form?.formFieldResponseBy('uniqueId');
    final communityTypeId = form?.formFieldResponseBy('communityTypeId');
    final communityName = form?.formFieldResponseBy('communityName');
    AppSharedPreferences.saveUserCommunityName(communityTypeId ?? '');
    AppSharedPreferences.saveUserCommunityType(communityName ?? '');
    final user = state?.copyWith(
      uniqueId: uniqueId,
      communityTypeId: communityTypeId,
      communityName: communityName,
    );
    set(user);
  }

  //Declare a set to avoid calling [state] directly
  //outside the provider class
  void set(UserAppModel? user) {
    state = user?.copyWithUsingJson(state);
  }
}

@Deprecated('Will be removed in 4.0')

///A provider that handles the storage of
///the user information in the [SharedPreferences]
///every time the user receives a new customAccessToken
@Riverpod(keepAlive: true)
class AuthUserNotifierPod extends _$AuthUserNotifierPod {
  @override
  Future<AuthUserModel?> build() async {
    ///Watch if customAccessToken changes if it does the new AuthUser will be
    ///stored every time then recovered only when calling the provider.
    ref.watch(userPodProvider.select((value) => value?.customAccessToken));
    await store();
    return recover();
  }

  Future<AuthUserModel?> recover() async {
    return AppSharedPreferences.recoverAuthUser();
  }

  void setAuthUser(AuthUserModel? value) {
    state = AsyncValue.data(value);
  }

  Future<void> _log() async {
    final user = ref.read(userPodProvider);

    PiixLogger.instance
      ..log(
          logMessage:
              'Old custom access token - ${state.value?.customAccessToken}',
          level: Level.debug)
      ..log(
          logMessage: 'New custom access token - ${user?.customAccessToken}',
          level: Level.debug);
  }

  ///Stores the local user information, pass a [hashableUnixTime] when
  ///sending a new verification code to the server.
  Future<void> store([int? hashableUnixTime]) async {
    final user = ref.read(userPodProvider);
    final credential = ref.read(usernameCredentialProvider);
    final oldAuthUser = await recover();
    _log();
    final authUser = AuthUserModel.local(
      userId: user?.userId ?? state.value?.userId ?? oldAuthUser?.userId ?? '',
      //Keep the old credential to always persist the value the user entered
      //when signing in or signing up
      usernameCredential: credential ??
          state.value?.phoneNumber ??
          oldAuthUser?.phoneNumber ??
          '',
      // //Keep old auth method to always maintain if the user signed in
      // //or signed up with phone or email
      // authMethod: oldAuthUser?.authMethod ?? authMethod ??,
      //Keep old custom access token as the hashing key must be the same to
      //the one used in the signed in or signed up moment so the app can
      // always retrieve the custom firebase token used for the
      //custom sign in which in turn allows the retrieval of the firebase token
      //used for any request that needs authorization
      customAccessToken: oldAuthUser?.customAccessToken ??
          user?.customAccessToken ??
          state.value?.customAccessToken ??
          '',
      //Keep old unix time as the hashing key must be the same to
      //the one used in the signed in or signed up moment so the app can
      // always retrieve the custom firebase token used for the
      //custom sign in which in turn allows the retrieval of the firebase token
      //used for any request that needs authorization
      hashableUnixTime: state.value?.hashableUnixTime ??
          oldAuthUser?.hashableUnixTime ??
          hashableUnixTime ??
          -1,
      //Always update the authorizedUser property with the new user passed
      authorizedUser: user?.approved ?? false,
      //Always update the verifiedPhone property with the new user passed
      phoneVerified: user?.phoneVerified ?? false,
      //Always update the verifiedEmail property with the new user passed
      emailVerified: user?.emailVerified ?? false,
    );
    await AppSharedPreferences.saveAuthUser(authUser);
    return;
  }
}
