import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/ui/widgets/submit_button_builder_deprecated.dart';
import 'package:piix_mobile/extensions/date_extend_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_model.dart';
import 'package:piix_mobile/purchase_invoice_feature/utils/constants_deprecated/purchase_invoice_copies_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/utils/invoice_navigation_utils.dart';
import 'package:piix_mobile/store_feature/ui/payments/widgets/how_to_pay_dialog_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/plans/managing_deprecated/plan_ui_state_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This widget contain instruction and a button for navigate to catch line
///
class InstructionFromStatusCardDeprecated extends StatefulWidget {
  const InstructionFromStatusCardDeprecated({
    Key? key,
    required this.invoice,
  }) : super(key: key);
  final InvoiceModel invoice;

  @override
  State<InstructionFromStatusCardDeprecated> createState() =>
      _InstructionFromStatusCardDeprecatedState();
}

class _InstructionFromStatusCardDeprecatedState
    extends State<InstructionFromStatusCardDeprecated> {
  late PlanUiStateDeprecated planUiState;

  bool get showIcon => widget.invoice.invoiceStatus.maybeMap(
        (_) => false,
        created: (value) => true,
        awaitingPayment: (value) => true,
        expired: (_) => true,
        orElse: () => false,
      );

  String get warningIconText {
    final expirationDate = widget.invoice.expirationDate;
    final pendingText = '${PurchaseInvoiceCopiesDeprecated.notLooseDiscount} '
        '${expirationDate.dateFormatWhithMonth}.';
    return widget.invoice.invoiceStatus.maybeMap(
      (_) => '',
      created: (value) => pendingText,
      awaitingPayment: (value) => pendingText,
      expired: (_) => PurchaseInvoiceCopiesDeprecated.paymentLineExpireReQuote,
      orElse: () => '',
    );
  }

  @override
  void initState() {
    super.initState();
    planUiState = PlanUiStateDeprecated(setState: setState);
  }

  @override
  void dispose() {
    super.dispose();
    planUiState.cleanState();
  }

  @override
  Widget build(BuildContext context) {
    final currentInvoice = widget.invoice;
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          children: [
            Stack(
              children: [
                Text(
                  currentInvoice.instructionText,
                  style: context.textTheme?.bodyMedium,
                  textAlign: TextAlign.justify,
                ),
                Positioned(
                  bottom: 1.h,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => handleHowToPayDialog(context),
                    child: Icon(
                      Icons.info_outline,
                      size: 12.sp,
                      color: PiixColors.active,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            if (showIcon) ...[
              SizedBox(
                height: 12.h,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.warning,
                    color: PiixColors.error,
                  ),
                  SizedBox(width: 8.w),
                  Flexible(
                    child: Text(
                      warningIconText,
                      style: context.textTheme?.bodyMedium?.copyWith(
                        color: PiixColors.error,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
            ],
            SubmitButtonBuilderDeprecated(
              onPressed: () => handleNavigationOutofInvoice(
                context: context,
                invoiceStatusModel: currentInvoice.invoiceStatus,
                planUiState: planUiState,
              ),
              text: currentInvoice.invoiceStatus.actionText.toUpperCase(),
            ),
          ],
        ),
      ),
    );
  }

  void handleHowToPayDialog(BuildContext context) => showDialog<void>(
        context: context,
        barrierColor: PiixColors.mainText.withOpacity(0.62),
        builder: (context) => const HowToPayDialogDeprecated(),
      );
}
