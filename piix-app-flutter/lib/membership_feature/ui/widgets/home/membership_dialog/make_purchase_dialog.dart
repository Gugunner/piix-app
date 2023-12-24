import 'package:piix_mobile/utils/app_copies_barrel_file.dart';
import 'package:piix_mobile/widgets/dialog/app_default_dialog_deprecated.dart';

//TODO: Add documentation once new dialog UI is provided
class MakePurchaseDialog extends AppDefaultDialogDeprecated {
  MakePurchaseDialog({super.key})
      : super(
          title: MembershipCopies.whereToBuy,
          message: MembershipCopies.inStore,
          isCompact: true,
        );
}
