import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/model/protected_model.dart';
import 'package:piix_mobile/protected_feature_deprecated/ui/widgets/protected_with_membership_tile/protected_membership_content.dart';
import 'package:piix_mobile/ui/common/piix_tag.dart';

class ProtectedWithMembershipTileContent extends StatelessWidget {
  const ProtectedWithMembershipTileContent({
    super.key,
    required this.protected,
  });

  final ProtectedModel protected;

  @override
  Widget build(BuildContext context) {
    final isActive = protected.membership?.isActive ?? false;

    return Stack(
      children: [
        ProtectedMembershipContent(
          protected: protected,
          isActive: isActive,
        ),
        if (!isActive)
          const Positioned(
            right: 0,
            top: 0,
            child: PiixTagDeprecated(
              text: PiixCopiesDeprecated.pendingProduct,
              backgroundColor: PiixColors.blueGrey,
            ),
          ),
      ],
    );
  }
}
