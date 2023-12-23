import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/navigation_deprecated/navigation_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/bloc_deprecated/purchase_invoice_bloc_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_model.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_status_model.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/payment_line_from_invoice_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/utils/constants_deprecated/purchase_invoice_copies_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/additional_benefits_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/levels_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/package_combos_bloc.dart';
import 'package:piix_mobile/store_feature/domain/bloc/plans_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/plans/managing_deprecated/plan_ui_state_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/additional_benefit_quotation_home_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/level/level_quotation_home_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/package_combo_quotation_home_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/plans_quotation_home_screen_deprecated.dart';
import 'package:piix_mobile/ui/common/piix_confirm_alert_deprecated.dart';
import 'package:provider/provider.dart';

void ticketToLevelQuotation(BuildContext context) {
  final levelsBLoC = context.read<LevelsBLoCDeprecated>();
  final currentInvoiceTicket = getCurrentInvoiceTicket(context);
  final level = currentInvoiceTicket?.products.level;
  levelsBLoC.setCurrentLevel(level);
  Navigator.popAndPushNamed(
      context, LevelQuotationHomeScreenDeprecated.routeName);
}

void ticketToPlanQuotation(
    BuildContext context, PlanUiStateDeprecated planUiState) {
  final plansBLoC = context.read<PlansBLoCDeprecated>();
  final currentInvoiceTicket = getCurrentInvoiceTicket(context);
  final plansId =
      currentInvoiceTicket?.products.plans?.map((e) => e.planId).join(',');
  plansBLoC.currentPlanIds = plansId;

  Navigator.popAndPushNamed(
      context, PlanQuotationHomeScreenDeprecated.routeName,
      arguments: planUiState);
}

void ticketToComboQuotation(BuildContext context) {
  final packageComboBLoC = context.read<PackageComboBLoC>();
  final currentInvoiceTicket = getCurrentInvoiceTicket(context);
  final packageCombo = currentInvoiceTicket?.products.packageCombo;
  packageComboBLoC.setCurrentPackageCombo(packageCombo);
  Navigator.popAndPushNamed(
      context, PackageComboQuotationHomeScreenDeprecated.routeName);
}

void ticketToAdditionalBenefitQuotation(BuildContext context) {
  final additionalBenefitsPerSupplierBLoC =
      context.read<AdditionalBenefitsPerSupplierBLoCDeprecated>();
  final currentInvoiceTicket = getCurrentInvoiceTicket(context);
  final additionalBenefitPerSupplier =
      currentInvoiceTicket?.products.additionalBenefitsPerSupplier?.first;
  additionalBenefitsPerSupplierBLoC
      .setCurrentAdditionalBenefitPerSupplier(additionalBenefitPerSupplier);
  Navigator.popAndPushNamed(
      context, AdditionalBenefitQuotationHomeScreenDeprecated.routeName);
}

InvoiceModel? getCurrentInvoiceTicket(BuildContext context) {
  final purchaseInvoiceBLoC = context.read<PurchaseInvoiceBLoCDeprecated>();
  final currentInvoiceTicket = purchaseInvoiceBLoC.invoice;
  return currentInvoiceTicket;
}

void navigateToSpecificHomeScreenTab(
  BuildContext context, {
  int tab = 0,
}) {
  final navigationProvider = context.read<NavigationProviderDeprecated>();
  navigationProvider.setCurrentNavigationBottomTab(tab);
  NavigatorKeyState().navigateToHomeRoute();
}

void handleNavigationOutofInvoice({
  required BuildContext context,
  required InvoiceStatusModel invoiceStatusModel,
  required PlanUiStateDeprecated planUiState,
}) async {
  final invoiceDialog = ({
    required String title,
    required String message,
    required VoidCallback onConfirm,
  }) =>
      showDialog<bool>(
        context: context,
        builder: (_) => PiixConfirmAlertDialogDeprecated(
          title: title,
          titleStyle: context.headlineSmall
              ?.copyWith(color: PiixColors.mainText, height: 14.sp / 14.sp),
          message: message,
          onCancel: () => Navigator.pop(context, false),
          onConfirm: onConfirm,
        ),
      );

  const terminatedDialogTitle =
      PurchaseInvoiceCopiesDeprecated.continueToQuotation;
  const terminatedDialogMessage =
      PurchaseInvoiceCopiesDeprecated.exitAndViewQuotation;
  const toStoreDialogTitle = PurchaseInvoiceCopiesDeprecated.continueToStore;
  const toStoreDialogMessage =
      PurchaseInvoiceCopiesDeprecated.exitAndViewSimilarProducts;
  final terminatedDialogOnConfirm = () =>
      NavigatorKeyState().confirmNavigateToSpecificModule(context, planUiState);
  final toStoreDialogOnConfirm =
      () => navigateToSpecificHomeScreenTab(context, tab: 2);
  final terminatedCallback = (_) => invoiceDialog(
        title: terminatedDialogTitle,
        message: terminatedDialogMessage,
        onConfirm: terminatedDialogOnConfirm,
      );
  final toStoreCallback = (_) => invoiceDialog(
        title: toStoreDialogTitle,
        message: toStoreDialogMessage,
        onConfirm: toStoreDialogOnConfirm,
      );

  invoiceStatusModel.map(
    (value) => null,
    created: (_) => NavigatorKeyState()
        .getNavigator(context)
        ?.pushNamed(PaymentLineFromInvoiceDeprecated.routeName),
    awaitingPayment: (_) => NavigatorKeyState()
        .getNavigator(context)
        ?.pushNamed(PaymentLineFromInvoiceDeprecated.routeName),
    expired: terminatedCallback,
    bounced: (_) => terminatedCallback,
    paymentInProcess: (_) => NavigatorKeyState()
        .getNavigator(context)
        ?.pushNamed(PaymentLineFromInvoiceDeprecated.routeName),
    canceled: terminatedCallback,
    paymentInMediation: (_) => NavigatorKeyState()
        .getNavigator(context)
        ?.pushNamed(PaymentLineFromInvoiceDeprecated.routeName),
    refunded: toStoreCallback,
    paid: toStoreCallback,
    awaitingFulfilment: toStoreCallback,
    fullfilled: toStoreCallback,
  );
}
