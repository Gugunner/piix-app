import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/claim_ticket_feature/data/repository/claim_ticket_repository_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_banner_content_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:url_launcher/url_launcher_string.dart';

extension ClaimTicketStateCases on ClaimTicketStateDeprecated {
  bool get hasErrorState {
    final errorStates = [
      ClaimTicketStateDeprecated.error,
      ClaimTicketStateDeprecated.conflict,
      ClaimTicketStateDeprecated.notFound,
      ClaimTicketStateDeprecated.unexpectedError,
      ClaimTicketStateDeprecated.retrieveError,
    ];
    return errorStates.contains(this);
  }
}

@Deprecated('Will be removed in 4.0')
class ClaimTicketsBannersDeprecated {
  static const ticketInProcessBanner = PiixBannerContentDeprecated(
    title: PiixCopiesDeprecated.ticketInProcess,
    subtitle: PiixCopiesDeprecated.ticketInProcessLabel,
    iconData: Icons.check_circle_outlined,
    cardBackgroundColor: PiixColors.successMain,
  );

  static const ticketCloseBanner = PiixBannerContentDeprecated(
    title: PiixCopiesDeprecated.thanksForQualifying,
    subtitle: PiixCopiesDeprecated.yourOpinionIsImportant,
    iconData: Icons.check_circle_outlined,
    cardBackgroundColor: PiixColors.successMain,
  );

  static const errorCallBanner = PiixBannerContentDeprecated(
    title: PiixCopiesDeprecated.errorCall,
    iconData: Icons.info,
    cardBackgroundColor: PiixColors.errorMain,
  );

  static const errorWhatsappBanner = PiixBannerContentDeprecated(
    title: PiixCopiesDeprecated.errorWhatsapp,
    iconData: Icons.info,
    cardBackgroundColor: PiixColors.errorMain,
  );

  static const errorCreateBanner = PiixBannerContentDeprecated(
    title: PiixCopiesDeprecated.appFailure,
    subtitle: PiixCopiesDeprecated.createClaimErrorMessage,
    iconData: Icons.error_outline,
    cardBackgroundColor: PiixColors.errorMain,
  );

  static const errorCloseBanner = PiixBannerContentDeprecated(
    title: PiixCopiesDeprecated.appFailure,
    subtitle: PiixCopiesDeprecated.finishClaimErrorMessage,
    iconData: Icons.error_outline,
    cardBackgroundColor: PiixColors.errorMain,
  );
}

Future<bool> piixLaunchUrl(String url, {bool isPhone = true}) async {
  try {
    return await launchUrlString(
      url,
      mode:
          isPhone ? LaunchMode.platformDefault : LaunchMode.externalApplication,
    );
  } catch (e) {
    final loggerInstance = PiixLogger.instance;
    final logMessage = loggerInstance.errorMessage(
      messageName: 'Error launching url - $url',
      message: e.toString(),
      isLoggable: false,
    );
    loggerInstance.log(
      logMessage: logMessage.toString(),
      error: e,
      level: Level.error,
      sendToCrashlytics: true,
    );
    return false;
  }
}
