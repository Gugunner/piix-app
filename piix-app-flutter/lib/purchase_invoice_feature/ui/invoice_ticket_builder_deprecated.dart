import 'package:flutter/material.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/utils/product_type_enum_deprecated.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/file_system_bloc.dart';
import 'package:piix_mobile/file_feature/domain/model/file_model.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/bloc_deprecated/purchase_invoice_bloc_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/state_ui_switcher_invoice_ticket_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')
class InvoiceTicketBuilderDeprecated extends StatefulWidget {
  const InvoiceTicketBuilderDeprecated({super.key});

  @override
  State<InvoiceTicketBuilderDeprecated> createState() =>
      _InvoiceTicketBuilderDeprecatedState();
}

class _InvoiceTicketBuilderDeprecatedState
    extends State<InvoiceTicketBuilderDeprecated> {
  List<Future<FileModel?>> logoFutures = [];
  late Future<void> getPurchaseDetailFuture;
  late PurchaseInvoiceBLoCDeprecated purchaseInvoiceBLoC;

  @override
  void initState() {
    super.initState();
    getPurchaseDetailFuture = getPurchaseDetail();
  }

  @override
  Widget build(BuildContext context) {
    purchaseInvoiceBLoC = context.watch<PurchaseInvoiceBLoCDeprecated>();
    return FutureBuilder(
        future: getPurchaseDetailFuture,
        builder: (_, __) {
          return StateUiSwitcherInvoiceTicketDeprecated(
            retryPurchaseDetail: retryPurchaseDetail,
          );
        });
  }

  //This future, retrieve a purchase invoice history
  Future<void> getPurchaseDetail() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        final userBLoC = context.read<UserBLoCDeprecated>();
        final membershipBLoC = context.read<MembershipProviderDeprecated>();
        final user = userBLoC.user;
        final selectedMembership = membershipBLoC.selectedMembership;
        final invoice = purchaseInvoiceBLoC.invoice;
        if (selectedMembership == null || invoice == null || user == null)
          return;
        final purchaseInvoiceId = invoice.purchaseInvoiceId;
        final productType = invoice.userQuotation.productType;
        final membershipId = selectedMembership.membershipId;
        if (productType == ProductTypeDeprecated.ADDITIONAL) {
          await purchaseInvoiceBLoC.getAdditionalBenefitPurchaseInvoiceById(
            membershipId: membershipId,
            purchaseInvoiceId: purchaseInvoiceId,
          );
          final fileSystemBloc = context.read<FileSystemBLoC>();
          if (invoice.products.additionalBenefitsPerSupplier == null) return;
          final additionalBenefitsPerSupplier =
              invoice.products.additionalBenefitsPerSupplier ?? [];
          for (final additionalBenefit in additionalBenefitsPerSupplier) {
            if (additionalBenefit.supplier == null) continue;
            final callService = additionalBenefit.supplier!.logo.isNotEmpty &&
                additionalBenefit.supplier!.logoMemory.isNullOrEmpty;
            if (callService) {
              logoFutures.add(
                fileSystemBloc.getFileFromPath(
                  userId: user.userId,
                  filePath: additionalBenefit.supplier!.logo,
                  propertyName:
                      'supplierLogo/${additionalBenefit.benefitPerSupplierId}',
                ),
              );
            }
          }
          if (logoFutures.isNotEmpty) {
            final logoFiles = await Future.wait(logoFutures);
            purchaseInvoiceBLoC
                .setAdditionalBenefitPerSupplierLogoFiles(logoFiles);
          }
          return;
        }
        if (productType == ProductTypeDeprecated.COMBO) {
          await purchaseInvoiceBLoC.getPackageComboPurchaseInvoiceById(
            membershipId: membershipId,
            purchaseInvoiceId: purchaseInvoiceId,
          );
          return;
        }
        if (productType == ProductTypeDeprecated.PLAN) {
          await purchaseInvoiceBLoC.getPlanPurchaseInvoiceById(
            membershipId: membershipId,
            purchaseInvoiceId: purchaseInvoiceId,
          );
          return;
        }
        if (productType == ProductTypeDeprecated.LEVEL) {
          await purchaseInvoiceBLoC.getLevelPurchaseInvoiceById(
            membershipId: membershipId,
            purchaseInvoiceId: purchaseInvoiceId,
          );
          return;
        }
      },
    );
  }

  //This function resets the future of getPurchaseInvoice, and reruns it
  void retryPurchaseDetail() => setState(() {
        getPurchaseDetailFuture = getPurchaseDetail();
      });
}
