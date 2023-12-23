import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_input_provider.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_service_provider_deprecated.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/utils/auth_user_form_copies.dart';
import 'package:piix_mobile/claim_ticket_feature/utils/claim_tickets_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_banner_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_banner_content_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_values.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

enum AuthFormType { personal, documentation, protected }

extension AuthFormTypeExtend on AuthFormType {
  String get analyticsFormType {
    switch (this) {
      case AuthFormType.personal:
        return PiixAnalyticsValues.personalInformationForm;
      case AuthFormType.documentation:
        return PiixAnalyticsValues.documentationForm;
      case AuthFormType.protected:
        return PiixAnalyticsValues.protectedRegisterForm;
      default:
        return '';
    }
  }
}

void launchWhatsapp(BuildContext context, WidgetRef ref) async {
  final user = context.read<AuthServiceProvider>().user;
  final authMethod = ref.read(authMethodStateProvider);
  var text = '';
  if (user != null &&
      user.name.isNotNullEmpty &&
      user.firstLastName.isNotNullEmpty) {
    final name = user.name;
    final firstLastName = user.firstLastName;
    if (authMethod.isProtected) {
      text = AuthUserFormCopies.registerProtected(
        name!,
        firstLastName!,
      );
    } else {
      text = AuthUserFormCopies.verificationHelpWithName(
        name!,
        firstLastName!,
      );
    }
  } else {
    text = AuthUserFormCopies.verificationHelpNoName;
  }
  final whatsappLink = WhatsAppUnilink(
    //TODO: Add phone number to service in UserAppModel
    phoneNumber: '+525530420546',
    text: text,
  );
  try {
    piixLaunchUrl('$whatsappLink', isPhone: false);
  } catch (e) {
    const banner = PiixBannerContentDeprecated(
      title: PiixCopiesDeprecated.errorWhatsapp,
      iconData: Icons.info,
      cardBackgroundColor: PiixColors.errorMain,
    );
    PiixBannerDeprecated.instance.builder(
      context,
      children: banner.build(context),
    );
  }
}
