import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/connectivity_bloc.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/memberships/memberships_builder_deprecated.dart';
import 'package:piix_mobile/ui/common/clamping_scale_deprecated.dart';
import 'package:piix_mobile/widgets/no_internet.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This screen contains a membership level card, user info and welcome text
///
class MembershipsScreenDeprecated extends StatelessWidget {
  static const routeName = '/memberships';
  const MembershipsScreenDeprecated({super.key});

  @override
  Widget build(BuildContext context) {
    final connectivityBLoC = context.watch<ConnectivityBLoC>();
    return ScreenUtilInit(
      designSize: ConstantsDeprecated.designSize,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return ClampingScaleDeprecated(
          child: Scaffold(
            floatingActionButton: const SizedBox(),
            appBar: AppBar(
              leading: const SizedBox(),
              title: const Text(
                PiixCopiesDeprecated.membershipTitle,
              ),
            ),
            body: Builder(
              builder: (context) {
                if (!connectivityBLoC.fullConnection) {
                  return const NoInternet();
                }
                return const MembershipsBuilderDeprecated();
              },
            ),
          ),
        );
      },
    );
  }
}
