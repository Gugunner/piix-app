import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/bloc/protected_provider.dart';
import 'package:piix_mobile/protected_feature_deprecated/ui/widgets/protected_with_membership_tile/protected_with_membership_tile_builder.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:provider/provider.dart';

/// Creates a expansion card list with the protected memberships.
class ProtectedExpansionCardList extends StatelessWidget {
  const ProtectedExpansionCardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final protectedBLoC = context.watch<ProtectedProvider>();
    return Card(
      child: Column(
        children: [
          ProtectedWithMembershipTileBuilder(
            protectedWithMembership:
                protectedBLoC.protectedWithActiveMembership,
            title: PiixCopiesDeprecated.protectedWithAssignedMembership,
          ),
          const Divider(
            color: PiixColors.grey,
          ),
          ProtectedWithMembershipTileBuilder(
            protectedWithMembership:
                protectedBLoC.protectedWithInactiveMembership,
            title: PiixCopiesDeprecated.protectedWithoutAssignedMembership,
          ),
        ],
      ),
    );
  }
}
