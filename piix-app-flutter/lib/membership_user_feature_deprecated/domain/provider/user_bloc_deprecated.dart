import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/auth_feature/domain/model/user_app_model.dart';
import 'package:piix_mobile/data/datasource/user_repository_impl_deprecated.dart';
import 'package:piix_mobile/general_app_feature/api/local/app_shared_preferences.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/data/repository/file_system_repository_deprecated.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/file_system_bloc.dart';
import 'package:piix_mobile/file_feature/domain/model/file_model.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/freezed_utils.dart';
import 'package:piix_mobile/utils/extensions/list_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/user_repository_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/membership_model/membership_model_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/user_credential_model.dart';
import 'package:piix_mobile/user_profile_feature/domain/model/update_credential_model.dart';

@Deprecated('Will be removed in 4.0')

/// This BLoC is where all the logic for user info is located.
class UserBLoCDeprecated extends ChangeNotifier {
  UserAppModel? _user;
  UserAppModel? get user => _user;
  set user(UserAppModel? user) => _user = user;

  bool get userIsNotNull => _user != null;

  bool get userHasBasicForm =>
      _user != null && _user!.userAlreadyHasBasicMainInfoForm;

  bool get userAlreadyHasNotBasicMainInfoForm =>
      _user != null && !_user!.userAlreadyHasBasicMainInfoForm;

  /// Search the given membership by their id and then set the given
  /// image memory.
  void setCardImageByMembershipId(String membershipId, String imageMemory,
      [String? cardImage]) {
    final membershipIndex = (user?.memberships ?? [])
        .indexWhere((m) => m.membershipId == membershipId);
    //If the membershipId is not found in the users memberships exit
    //and do nothing
    if (membershipIndex < 0) return;
    final membership = user?.memberships?[membershipIndex];
    //If no membership is found exit and do nothing
    if (membership == null) return;
    final membershipLevelModel = membership.usersMembershipLevel.copyWith(
      cardImage: cardImage,
      cardImageMemory: imageMemory,
      cardImageCache: base64Decode(imageMemory),
    );
    user!.updateMembership(
      membership.copyWith(
        usersMembershipLevel: membershipLevelModel,
      ),
      UserMembershipUpdateDeprecated.level,
    );
  }

  //TODO: Optimize setting value to UserAppModel directly
  set setUserEmail(String email) {
    user = user?.copyWith(
      email: email,
    );
    notifyListeners();
  }

  //TODO: Optimize setting value to UserAppModel directly
  set setUserPhone(String phone) {
    user = user?.copyWith(
      phoneNumber: phone,
    );
    notifyListeners();
  }

  bool? _isChangedDefaultPassword;
  bool? get isChangedDefaultPassword => _isChangedDefaultPassword;

  bool _isConnectionAvailable = true;
  bool get isConnectionAvailable => _isConnectionAvailable;
  set isConnectionAvailable(bool value) {
    _isConnectionAvailable = value;
    notifyListeners();
  }

  UserActionStateDeprecated _userActionState = UserActionStateDeprecated.idle;
  UserActionStateDeprecated get userActionState => _userActionState;
  set userActionState(UserActionStateDeprecated state) {
    _userActionState = state;
    notifyListeners();
  }

  List<MembershipModelDeprecated> get memberships {
    if (user != null) {
      if (user!.memberships != null) {
        return user!.memberships!;
      }
    }
    return [];
  }

  UserRepositoryDeprecated get userRepository =>
      getIt<UserRepositoryDeprecated>();
  FileSystemBLoC get fileSystemBLoC => getIt<FileSystemBLoC>();
  UserRepositoryImplDeprecated get userRepositoryImpl =>
      getIt<UserRepositoryImplDeprecated>();

  Future<void> getUserByUsernameCredential({
    required String usernameCredential,
    required bool isPhoneNumber,
  }) async {
    try {
      final credentialModel =
          UserCredentialModel(usernameCredential: usernameCredential);
      userActionState = UserActionStateDeprecated.retrieving;
      final data = isPhoneNumber
          ? await userRepository.getUserByPhoneRequested(credentialModel)
          : await userRepository.getUserByEmailRequested(credentialModel);

      if (data is UserActionStateDeprecated) {
        userActionState = data;
      } else {
        final communityType =
            await AppSharedPreferences.recoverUserCommunityType();
        final communityName =
            await AppSharedPreferences.recoverUserCommunityName();
        final userData = UserAppModel.fromJson(data);
        user = userData.copyWith(
          communityName: communityName,
          communityTypeId: communityType,
        );
        if (user!.memberships.isNullOrEmpty) {
          userActionState = UserActionStateDeprecated.empty;
          return;
        }
        if (!(user!.approved)) {
          userActionState = UserActionStateDeprecated.notAuthorized;
          return;
        } else {
          userActionState = data['state'];
        }
      }
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in getUserByUsernameCredential',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      userActionState = UserActionStateDeprecated.error;
    }
  }

  ///Update user email.
  Future<void> updateUserEmail({
    required String userId,
    required String? currentEmail,
    required String newEmail,
  }) async {
    try {
      final requestModel = UpdateEmailRequestModel(
        userId: userId,
        currentEmail: currentEmail,
        newEmail: newEmail,
      );
      userActionState = UserActionStateDeprecated.updating;
      userActionState =
          await userRepository.updateUserEmailRequested(requestModel);
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in updateUserEmail',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      userActionState = UserActionStateDeprecated.errorUpdating;
    }
  }

//Update user phone number.
  Future<void> updateUserPhoneNumber({
    required String userId,
    required String newPhoneNumber,
  }) async {
    try {
      final internationalPhoneCode = user?.internationalPhoneCode ?? '';
      final phoneNumber = user?.phoneNumber ?? '';
      final requestModel = UpdatePhoneNumberRequestModel(
        userId: userId,
        currentPhoneNumber: '$internationalPhoneCode$phoneNumber',
        newPhoneNumber: newPhoneNumber,
      );
      userActionState = UserActionStateDeprecated.updating;
      userActionState =
          await userRepository.updateUserPhoneNumberRequested(requestModel);
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in updateUserPhoneNumber',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      userActionState = UserActionStateDeprecated.errorUpdating;
    }
  }

  ///Retrieves a list of futures that will request a membership card image.
  ///
  /// Can use a new list of [newMemberships] instead of this [memberships]
  List<Future<FileModel?>> prepareMembershipLevelCardImages(
      [List<MembershipModelDeprecated>? newMemberships]) {
    final futures = <Future<FileModel?>>[];
    final userId = user?.userId ?? '';
    for (final membership in (newMemberships ?? memberships)) {
      //If the card image is not present move to the next membership
      if (membership.usersMembershipLevel.cardImage == null) continue;
      final filePath = membership.usersMembershipLevel.cardImage!;
      final propertyName = '${membership.membershipId}/cardImage';
      futures.add(
        fileSystemBLoC.getFileFromPath(
            userId: userId, filePath: filePath, propertyName: propertyName),
      );
    }
    return futures;
  }

  ///Given a list of futures set the cardImageMemory on each resolved future [FileModel]
  Future<void> obtainMembershipLevelCardImages(List<FileModel?> files,
      [String? cardImage]) async {
    try {
      if (fileSystemBLoC.fileState != FileStateDeprecated.retrieved) return;
      for (final file in files) {
        //If no file is found check the next file
        if (file == null) continue;
        final fileContent = file.fileContent;
        //If the file has no content check the next file
        if (fileContent == null) continue;
        final fileName = fileContent.name;
        //If the file has no name check the next file
        if (fileName.isEmpty) continue;
        final membershipId = fileName.split('/')[0];
        final imageMemory = fileContent.base64Content;
        setCardImageByMembershipId(
          membershipId,
          imageMemory,
          cardImage,
        );
      }
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in obtainMembershipLevelCardImages '
            'with cardImage $cardImage',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      fileSystemBLoC.fileState = FileStateDeprecated.error;
    }
  }

  /// Get all new levels and plans and set new memberships info.
  Future<void> getUserLevelsAndPlans() async {
    try {
      userActionState = UserActionStateDeprecated.retrieving;
      final data = await userRepository.getUserLevelsAndPlansRequested();
      if (data is UserActionStateDeprecated) {
        userActionState = data;
      } else {
        addDefaultType(data, 'memberships');
        final newMemberships = (data['memberships'] as List<dynamic>)
            .map((membership) => MembershipModelDeprecated.fromJson(membership))
            .toList();
        final oldMemberships = user?.memberships;
        //TODO: Add logic when there are no old memberships if user just got the first one
        if (oldMemberships != null && oldMemberships.isNotEmpty) {
          for (final newMembership in newMemberships) {
            //Updates Plan in Membership
            user?.updateMembership(
                newMembership, UserMembershipUpdateDeprecated.plan);
            //Updates cardImage path
            user?.updateMembership(
                newMembership, UserMembershipUpdateDeprecated.level);
          }
          final futures = prepareMembershipLevelCardImages(newMemberships);
          final files = await Future.wait(futures);
          //Obtain new images base64 content of membership level card
          await obtainMembershipLevelCardImages(files);
        }
        userActionState = data['state'];
      }
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in getUserLevelsAndPlans',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      userActionState = UserActionStateDeprecated.error;
    }
  }

  void setUserAlreadyHasBasicMainInfoForm(bool status) {
    user = user?.copyWith(
      userAlreadyHasBasicMainInfoForm: status,
    );
    notifyListeners();
  }

  // Clear BLoC state.
  void clearProvider() {
    _user = null;
    _isChangedDefaultPassword = null;
    _userActionState = UserActionStateDeprecated.idle;
    notifyListeners();
  }
}
