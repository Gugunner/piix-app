import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')
class SupplierRichTextDeprecated extends StatelessWidget {
  const SupplierRichTextDeprecated({Key? key, required this.supplierName})
      : super(key: key);
  final String supplierName;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '${PiixCopiesDeprecated.supplier}: ',
              style: context.primaryTextTheme?.titleMedium
                  ?.copyWith(color: PiixColors.secondary),
            ),
            TextSpan(
              text: supplierName,
              style: context.textTheme?.bodyMedium?.copyWith(
                color: PiixColors.secondary,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.start);
  }
}
