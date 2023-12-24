import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/membership_info_repository_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/membership_info_model.dart';

///Handles all real api service implementation calls for membership information
extension MembershipInfoRepositoryImplementation
    on MembershipInfoRepositoryDeprecated {
  Future<dynamic> getMembershipInfoRequestedImpl(
      RequestMembershipInfoModel requestModel) async {
    try {
      final response =
          await membershipInfoApi.getMembershipInfoApi(requestModel);
      final statusCode = response.statusCode ?? HttpStatus.internalServerError;
      if (!PiixApiDeprecated.checkStatusCode(statusCode: statusCode) ||
          response.data == null) {
        return MembershipInfoStateDeprecated.error;
      }
      response.data['state'] = MembershipInfoStateDeprecated.retrieved;
      return response.data;
    } on DioError catch (dioError) {
      var membershipInfoState = MembershipInfoStateDeprecated.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.notFound) {
        membershipInfoState = MembershipInfoStateDeprecated.notFound;
      }
      if (membershipInfoState != MembershipInfoStateDeprecated.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in getMembershipInfoRequestedImpl '
              'with id ${requestModel.membershipId}',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.error,
        );
        return membershipInfoState;
      }
      throw piixApiExceptions;
    }
  }
}
