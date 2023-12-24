import 'package:piix_mobile/general_app_feature/utils/constants/piix_icons.dart';
import 'package:piix_mobile/membership_feature/ui/widgets/home/membership_panel_option/app_membership_panel_option.dart';

class PendingPurchasePanelOption extends AppMembershipPanelOption {
  PendingPurchasePanelOption({super.key, this.count = 0})
      : assert(count >= 0),
        super(
            text: 'Compras por pagar ($count)',
            icon: PiixIcons.carrito_de_compras,
            onTap: () {
              //TODO: Navigate to PendingPurchaseScreen
            });

  ///Number of pending purchase
  final int count;
}
