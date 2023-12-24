import 'package:flutter/material.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/bloc_deprecated/purchase_invoice_bloc_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/state_ui_switcher_purchase_invoice_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget is a purchase invoice builder, contains a state ui switcher
///widget
class PurchaseInvoiceBuilderDeprecated extends StatefulWidget {
  const PurchaseInvoiceBuilderDeprecated({super.key});

  @override
  State<PurchaseInvoiceBuilderDeprecated> createState() =>
      _PurchaseInvoiceBuilderDeprecatedState();
}

class _PurchaseInvoiceBuilderDeprecatedState
    extends State<PurchaseInvoiceBuilderDeprecated> {
  late Future<void> getPurchaseInvoiceFuture;
  late PurchaseInvoiceBLoCDeprecated purchaseInvoiceBLoC;

  @override
  void initState() {
    getPurchaseInvoiceFuture = getPurchaseInvoice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final useFullScreenHeight = context.height - kToolbarHeight;
    purchaseInvoiceBLoC = context.watch<PurchaseInvoiceBLoCDeprecated>();
    return FutureBuilder<void>(
        future: getPurchaseInvoiceFuture,
        builder: (_, __) {
          return SizedBox(
            height: useFullScreenHeight,
            width: context.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StateUiSwitcherPurchaseInvoiceDeprecated(
                  retryPurchaseInvoice: retryPurchaseInvoice,
                ),
              ],
            ),
          );
        });
  }

  //This future, retrieve a purchase invoice history
  Future<void> getPurchaseInvoice() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final selectedMembership =
          context.read<MembershipProviderDeprecated>().selectedMembership;
      if (selectedMembership != null) {
        final membershipId = selectedMembership.membershipId;
        await purchaseInvoiceBLoC.getAllInvoicesByMembership(
          membershipId: membershipId,
        );
      }
    });
  }

  //This function resets the future of getPurchaseInvoice, and reruns it
  void retryPurchaseInvoice() => setState(() {
        getPurchaseInvoiceFuture = getPurchaseInvoice();
      });
}
