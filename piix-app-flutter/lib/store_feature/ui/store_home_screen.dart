import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/route_utils.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/piix_app_bar_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/store_home_builder_deprecated.dart';

//TODO: Remake the Screen
///This is main store screen, includes a store home builder
///
class StoreHomeScreen extends ConsumerWidget {
  static const routeName = '/store_home_screen';
  const StoreHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async => goToMemberships(context, ref),
      child: Scaffold(
        appBar: PiixAppBarDeprecated(
          title: PiixCopiesDeprecated.store,
          isTabScreen: true,
          onPressed: () => goToMemberships(context, ref),
        ),
        body: const StoreHomeBuilderDeprecated(),
      ),
    );
  }
}
