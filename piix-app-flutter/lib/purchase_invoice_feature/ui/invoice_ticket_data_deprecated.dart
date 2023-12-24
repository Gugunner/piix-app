import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/ui/widgets/submit_button_builder_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/bloc_deprecated/purchase_invoice_bloc_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/frequent_questions_button_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/info_ticket_card_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/instruction_from_status_card_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/plan_approved_card_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/status_payment_image_container_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/ticket_text_button_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/utils/product_type_enum_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/utils/invoice_navigation_utils.dart';
import 'package:piix_mobile/store_feature/ui/plans/managing_deprecated/plan_ui_state_deprecated.dart';
import 'package:piix_mobile/ui/common/piix_confirm_alert_deprecated.dart';
import 'package:provider/provider.dart';

import 'widgets/name_price_and_discount_column_deprecated.dart';

@Deprecated('Will be removed in 4.0')
class InvoiceTicketDataDeprecated extends StatefulWidget {
  const InvoiceTicketDataDeprecated({super.key});

  @override
  State<InvoiceTicketDataDeprecated> createState() =>
      _InvoiceTicketDataDeprecatedState();
}

class _InvoiceTicketDataDeprecatedState
    extends State<InvoiceTicketDataDeprecated> {
  late PlanUiStateDeprecated planUiState;

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
    final purchaseInvoiceBLoC = context.watch<PurchaseInvoiceBLoCDeprecated>();
    final currentInvoice = purchaseInvoiceBLoC.invoice;
    if (currentInvoice == null) return const SizedBox();
    final userQuote = currentInvoice.userQuotation;
    final actionText = currentInvoice.invoiceStatus.actionText.toUpperCase();
    return SingleChildScrollView(
      child: Column(
        children: [
          StatusPaymentImageContainerDeprecated(
            invoice: currentInvoice,
          ),
          SizedBox(
            height: 16.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            child: Column(
              children: [
                NamePriceAndDiscountColumDeprecated(
                  invoice: currentInvoice,
                ),
                SizedBox(
                  height: 16.h,
                ),
                InstructionFromStatusCardDeprecated(
                  invoice: currentInvoice,
                ),
                SizedBox(
                  height: 16.h,
                ),
                if (userQuote.productType == ProductTypeDeprecated.PLAN &&
                    currentInvoice.isPaid)
                  const PlanApprovedCardDeprecated(),
                InfoTicketCardDeprecated(
                  invoice: currentInvoice,
                ),
                SizedBox(
                  height: 16.h,
                ),
                if (actionText.isNotEmpty)
                  SubmitButtonBuilderDeprecated(
                    onPressed: () => handleNavigationOutofInvoice(
                      context: context,
                      invoiceStatusModel: currentInvoice.invoiceStatus,
                      planUiState: planUiState,
                    ),
                    text: actionText,
                  ),
                SizedBox(
                  height: 4.h,
                ),
                TicketTextButtonDeprecated(
                  label:
                      PiixCopiesDeprecated.viewCurrentMembership.toUpperCase(),
                  onPressed: () => handleNavigateToMembership(context),
                ),
                SizedBox(
                  height: 8.h,
                ),
                const FrequentQuestionsButtonDeprecated(),
                SizedBox(
                  height: 24.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void handleNavigateToMembership(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (_) => PiixConfirmAlertDialogDeprecated(
        title: PiixCopiesDeprecated.navigateToMembershipTitle,
        titleStyle: context.textTheme?.headlineSmall?.copyWith(
          color: PiixColors.primary,
        ),
        message: PiixCopiesDeprecated.navigateToMembershipSubTitle,
        onCancel: () => Navigator.pop(context, false),
        onConfirm: () => navigateToSpecificHomeScreenTab(context, tab: 0),
      ),
    );
  }
}
