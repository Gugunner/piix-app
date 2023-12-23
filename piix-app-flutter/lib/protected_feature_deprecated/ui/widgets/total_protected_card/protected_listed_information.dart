import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/listed_property_widget.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/int_extention.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/bloc/protected_provider.dart';
import 'package:provider/provider.dart';

class ProtectedListedInformation extends StatelessWidget {
  const ProtectedListedInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final protectedBLoC = context.watch<ProtectedProvider>();
    final protectedsInfo = protectedBLoC.protectedsInfo;
    final protectedToRegister = protectedsInfo?.slots.totalAvailableSlots ?? 0;
    final totalProtected = protectedsInfo?.protected.length ?? 0;
    return SizedBox(
      width: context.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListedPropertyWidget(
            keyText: '${PiixCopiesDeprecated.youHave}: ',
            valueText: '$totalProtected protegido${totalProtected.pluralWithS} '
                'registrado${totalProtected.pluralWithS}',
          ),
          ListedPropertyWidget(
            keyText: '${PiixCopiesDeprecated.withActiveMembreship}: ',
            valueText: '${protectedBLoC.protectedWithActiveMembership.length}',
          ),
          ListedPropertyWidget(
            keyText: '${PiixCopiesDeprecated.withInactiveMembership}: ',
            valueText:
                '${protectedBLoC.protectedWithInactiveMembership.length}',
          ),
          ListedPropertyWidget(
            keyText: '${PiixCopiesDeprecated.protectedToRegister}: ',
            valueText: '$protectedToRegister',
          ),
        ],
      ),
    );
  }
}
