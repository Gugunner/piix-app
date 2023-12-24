import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/file_system_bloc.dart';
import 'package:piix_mobile/file_feature/domain/model/file_model.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/levels_bloc_deprecated.dart';
import 'package:piix_mobile/ui/common/image_with_placeholder_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a row with level image, level name and coverage info text
///
class RowMainLevelInfoDeprecated extends StatefulWidget {
  const RowMainLevelInfoDeprecated({
    super.key,
    required this.selectedTab,
  });
  final int selectedTab;

  @override
  State<RowMainLevelInfoDeprecated> createState() =>
      _RowMainLevelInfoDeprecatedState();
}

class _RowMainLevelInfoDeprecatedState
    extends State<RowMainLevelInfoDeprecated> {
  List<Future<FileModel?>> levelImageFutures = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async => _initScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final levelsBLoC = context.watch<LevelsBLoCDeprecated>();
    final levels = levelsBLoC.filteredLevels;
    if (levels.isEmpty) return const SizedBox();
    final level = levels[widget.selectedTab].mapOrNull((value) => value);
    if (level == null) return const SizedBox();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            children: [
              Text(
                levels[widget.selectedTab].name,
                style: context.textTheme?.headlineMedium,
              ).padBottom(16.h),
              Text(
                PiixCopiesDeprecated.newCoverageApplyToProtected,
                style: context.textTheme?.bodyMedium,
              ),
            ],
          ).padRight(16.w),
        ),
        ImageWithPlaceholderDeprecated(
          urlImage: level.membershipLevelImageMemory,
          width: 65.w,
          height: 100.h,
          type: 'level',
        )
      ],
    );
  }

  Future<void> _initScreen() async {
    final userBLoC = context.read<UserBLoCDeprecated>();
    final levelsBLoC = context.read<LevelsBLoCDeprecated>();
    final levels = levelsBLoC.filteredLevels;
    final fileSystemBloc = context.read<FileSystemBLoC>();
    if (userBLoC.user == null) return;
    for (final level in levels) {
      final callService = level.membershipLevelImage.isNotEmpty &&
          level.membershipLevelImageMemory.isEmpty;
      if (callService) {
        levelImageFutures.add(fileSystemBloc.getFileFromPath(
          userId: userBLoC.user!.userId,
          filePath: level.membershipLevelImage,
          propertyName: 'levelImage/${level.levelId}',
        ));
      }
    }
    if (levelImageFutures.isNotEmpty) {
      final levelImageFiles = await Future.wait(levelImageFutures);
      levelsBLoC.setLevelsImageFiles(levelImageFiles);
    }
  }
}
