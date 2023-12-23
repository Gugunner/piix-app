import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

///This is a purchase invoice tooltip key
///It is used to be able to render the tooltip
final purchaseInvoiceKey = GlobalKey();

@Deprecated('Will be removed in 4.0')

///This widget contains a purchase invoice instructions and instructions tooltip
///
class PurchaseInvoiceInstructionsContainerDeprecated extends StatelessWidget {
  const PurchaseInvoiceInstructionsContainerDeprecated({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      PiixCopiesDeprecated.purchaseInvoiceInstruction,
      textAlign: TextAlign.justify,
      style: context.textTheme?.bodyMedium,
    );
  }
}
