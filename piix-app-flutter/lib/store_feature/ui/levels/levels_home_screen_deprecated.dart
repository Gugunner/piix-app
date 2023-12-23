import 'package:flutter/material.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/store_feature/data/repository/levels_deprecated/levels_repository_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/levels_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/levels/widgets/state_switcher_widget_level_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This is a main level screen, is responsible for calling the get levels by
/// membership service, and renders the state switcher
///
class LevelsHomeScreenDeprecated extends StatefulWidget {
  static const routeName = '/levels_home_screen';
  const LevelsHomeScreenDeprecated({super.key});

  @override
  State<LevelsHomeScreenDeprecated> createState() =>
      _LevelsHomeScreenDeprecatedState();
}

class _LevelsHomeScreenDeprecatedState
    extends State<LevelsHomeScreenDeprecated> {
  late Future<void> getLevelsFuture;
  late LevelsBLoCDeprecated levelsBLoC;

  @override
  void initState() {
    super.initState();
    getLevelsFuture = getLevelsByMembership();
  }

  @override
  Widget build(BuildContext context) {
    final useFullScreenHeight = context.height - kToolbarHeight;
    levelsBLoC = context.watch<LevelsBLoCDeprecated>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(PiixCopiesDeprecated.levels),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder(
          future: getLevelsFuture,
          builder: (_, __) {
            return SizedBox(
              height: useFullScreenHeight,
              width: context.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StateSwitcherWidgetLevelDeprecated(
                    retryLevelsByMembership: retryPlansByMembership,
                  ),
                ],
              ),
            );
          }),
    );
  }

  //This future, retrieve a levels to acquire
  Future<void> getLevelsByMembership() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final membershipId = context
          .read<MembershipProviderDeprecated>()
          .selectedMembership!
          .membershipId;
      await levelsBLoC.getLevelsByMembership(
        membershipId: membershipId,
      );
      final levels = levelsBLoC.filteredLevels;
      if (levels.isEmpty) {
        levelsBLoC.levelState = LevelStateDeprecated.empty;
      }
    });
  }

  //This function resets the future of getLevelsByMembership, and reruns it
  void retryPlansByMembership() => setState(() {
        getLevelsFuture = getLevelsByMembership();
      });
}
