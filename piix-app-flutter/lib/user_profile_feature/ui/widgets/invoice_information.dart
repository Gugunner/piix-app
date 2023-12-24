import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/ui_bloc.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/purchase_invoice_history_screen_deprecated.dart';
import 'package:piix_mobile/user_profile_feature/ui/profile_screen.dart';
import 'package:piix_mobile/user_profile_feature/ui/widgets/navigation_row.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_icons.dart';
import 'package:provider/provider.dart';

/// Displays the user's payment and invoice information history.
class InvoiceInformation extends StatelessWidget {
  const InvoiceInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          NavigationRow(
            onTap: () => handleNavigationToPurchaseInvoiceHistory(context),
            label: PiixCopiesDeprecated.shoppingHistory,
            icon: Icon(
              PiixIcons.pagos,
              color: PiixColors.gunMetal,
              size: 25.w,
            ),
          ),
        ],
      ),
    );
  }

  void handleNavigationToPurchaseInvoiceHistory(BuildContext context) {
    final uiBLoC = context.read<UiBLoC>();
    uiBLoC.fromRoute = ProfileScreen.routeName;
    NavigatorKeyState()
        .getNavigator(context)
        ?.pushNamed(PurchaseInvoiceHistoryScreenDeprecated.routeName);
  }
}
