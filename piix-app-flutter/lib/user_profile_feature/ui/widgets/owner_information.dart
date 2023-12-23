import 'package:flutter/material.dart';
import 'package:piix_mobile/extensions/date_extend_deprecated.dart';
import 'package:piix_mobile/utils/date_util.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:piix_mobile/user_profile_feature/ui/widgets/row_profile_label.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:provider/provider.dart';

/// Shows the user's personal information, such as their government number,
/// birthdate and address
class OwnerInformation extends StatelessWidget {
  const OwnerInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserBLoCDeprecated>().user;
    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          RowProfileLabel(
              label:
                  '${PiixCopiesDeprecated.uniqueId}: ${user?.uniqueId ?? ''}'),
          RowProfileLabel(
              label:
                  '${PiixCopiesDeprecated.birthDate}: ${user?.birthdate?.dateFormat ?? '-'}'),
          if (user?.birthdate != null)
            RowProfileLabel(
                label: PiixCopiesDeprecated.ageInYears(age(user!.birthdate!))),
          RowProfileLabel(
              label:
                  '${PiixCopiesDeprecated.genderLabel}: ${user?.genderName ?? '-'}'),
          //TODO: Once the user address information is added, refactor and use this code
          // const AnimatedAddressRow(),
        ],
      ),
    );
  }
}
