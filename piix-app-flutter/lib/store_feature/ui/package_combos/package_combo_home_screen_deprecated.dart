import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_error_screen_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/store_feature/data/repository/package_combos/package_combos_repository.dart';
import 'package:piix_mobile/store_feature/domain/bloc/package_combos_bloc.dart';
import 'package:piix_mobile/store_feature/ui/blank_slates_deprecated/blank_slate_store_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/package_combos/package_combo_list_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/package_combo_list_skeleton_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This is a main package combo screen, this widget depends the state render
///skeleton screen or package combo list or error screen.
///
class PackageComboHomeScreenDeprecated extends StatefulWidget {
  static const routeName = '/package_combos_home';
  const PackageComboHomeScreenDeprecated({super.key});

  @override
  State<PackageComboHomeScreenDeprecated> createState() =>
      _PackageComboHomeScreenDeprecatedState();
}

class _PackageComboHomeScreenDeprecatedState
    extends State<PackageComboHomeScreenDeprecated> {
  final idle = PackageCombosState.idle;
  final getting = PackageCombosState.getting;
  final accomplished = PackageCombosState.accomplished;
  final empty = PackageCombosState.empty;
  final error = PackageCombosState.error;
  final unexpectedError = PackageCombosState.unexpectedError;
  final conflict = PackageCombosState.conflict;

  late PackageComboBLoC packageComboBLoC;
  late MembershipProviderDeprecated membershipBLoC;

  Future<void> _initScreen() async {
    await packageComboBLoC.getPackageCombosByMembership(
      membershipId: membershipBLoC.selectedMembership?.membershipId ?? '',
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async => _initScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final usefullScreenHeight = context.height - kToolbarHeight;
    packageComboBLoC = context.watch<PackageComboBLoC>();
    membershipBLoC = context.watch<MembershipProviderDeprecated>();
    final packageComboState = packageComboBLoC.packageComboState;
    return Scaffold(
      appBar: AppBar(
        title: const Text(PiixCopiesDeprecated.combos),
        centerTitle: true,
        elevation: 0,
      ),
      body: SizedBox(
        height: usefullScreenHeight,
        width: context.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (packageComboState == idle || packageComboState == getting)
              const Expanded(
                child: PackageComboListSkeletonDeprecated(),
              )
            else if (packageComboState == accomplished)
              const Expanded(
                child: PackageComboListScreenDeprecated(),
              )
            else if (packageComboState == empty ||
                packageComboState == PackageCombosState.notFound)
              const BlankSlateStoreDeprecated(
                  label: PiixCopiesDeprecated.combos)
            else if (packageComboState == error ||
                packageComboState == unexpectedError ||
                packageComboState == PackageCombosState.conflict)
              PiixErrorScreenDeprecated(
                errorMessage: PiixCopiesDeprecated.unexpectedErrorStore,
                onTap: () async {
                  await _initScreen();
                },
              )
          ],
        ),
      ),
    );
  }
}
