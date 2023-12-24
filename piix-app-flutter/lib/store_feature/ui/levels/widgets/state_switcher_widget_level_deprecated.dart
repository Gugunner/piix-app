import 'package:flutter/material.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_error_screen_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/data/repository/levels_deprecated/levels_repository_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/levels_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/blank_slates_deprecated/blank_slate_store_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/levels/levels_to_acquire_data_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/level_skeleton.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///Depending on the state it can
///render the skeleton loader, the data screen, or the error messages
///as well as a button to retry loading the data
///
class StateSwitcherWidgetLevelDeprecated extends StatelessWidget {
  const StateSwitcherWidgetLevelDeprecated({
    super.key,
    required this.retryLevelsByMembership,
  });
  final void Function()? retryLevelsByMembership;

  static const getting = LevelStateDeprecated.getting;
  static const idle = LevelStateDeprecated.idle;
  static const accomplished = LevelStateDeprecated.accomplished;
  static const empty = LevelStateDeprecated.empty;
  static const unexpectedError = LevelStateDeprecated.unexpectedError;
  static const error = LevelStateDeprecated.error;

  @override
  Widget build(BuildContext context) {
    final levelsBLoC = context.watch<LevelsBLoCDeprecated>();
    final levelState = levelsBLoC.levelState;
    switch (levelState) {
      case getting:
      case idle:
        return const Expanded(
          child: LevelSkeleton(),
        );
      case empty:
        return const Expanded(
          child: BlankSlateStoreDeprecated(
            label: PiixCopiesDeprecated.levels,
          ),
        );
      case accomplished:
        return const Expanded(
          child: LevelsToAcquireDataDeprecated(),
        );
      case unexpectedError:
      case error:
        return PiixErrorScreenDeprecated(
                errorMessage: PiixCopiesDeprecated.unexpectedErrorStore,
                onTap: retryLevelsByMembership)
            .padTop(context.height * 0.25);

      default:
        return const SizedBox();
    }
  }
}
