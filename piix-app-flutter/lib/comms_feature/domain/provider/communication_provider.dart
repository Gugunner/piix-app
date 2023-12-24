import 'package:flutter/material.dart';
import 'package:piix_mobile/auth_feature/domain/provider/user_provider.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_input_provider.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/utils/app_copies_barrel_file.dart';
import 'package:piix_mobile/utils/log_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

part 'communication_provider.g.dart';

@riverpod
class WhatsappComms extends _$WhatsappComms with LogAppCall {
  @override
  void build(BuildContext context) => _prepareWhatsappLink(context);

  WhatsAppUnilink _getWhatsappLink(String text, [String? phoneNumber]) =>
      WhatsAppUnilink(
        //TODO: Add phone number to service in UserAppModel
        phoneNumber: phoneNumber ?? '+525530420546',
        text: text,
      );

  void _launchWhatsappLink(WhatsAppUnilink link) {
    try {
      launchUrlString('$link', mode: LaunchMode.externalApplication);
    } catch (error) {
      logError(error, className: 'WhatsappComms');
      rethrow;
    }
  }

  void _prepareWhatsappLink(BuildContext context) async {
    final user = ref.read(userPodProvider);
    WhatsAppUnilink link;
    if (user == null ||
        user.name.isNullOrEmpty ||
        user.firstLastName.isNullOrEmpty) {
      link = _getWhatsappLink(AuthUserFormCopies.verificationHelpNoName);
      return _launchWhatsappLink(link);
    }
    final authMethod = ref.read(authMethodStateProvider);
    final name = user.name;
    final firstLastName = user.firstLastName;
    if (authMethod.isProtected) {
      final text = AuthUserFormCopies.registerProtected(name!, firstLastName!);
      link = _getWhatsappLink(text);
    } else {
      final text = AuthUserFormCopies.verificationHelpWithName(
        name!,
        firstLastName!,
      );
      link = _getWhatsappLink(text);
    }
    return _launchWhatsappLink(link);
  }
}
