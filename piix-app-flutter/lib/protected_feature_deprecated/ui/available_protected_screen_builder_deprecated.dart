import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/auth_feature/domain/model/user_app_model.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/connectivity_bloc.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/load_error_widget_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/route_utils.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/piix_app_bar_deprecated.dart';
import 'package:piix_mobile/protected_feature_deprecated/data/repository/protected_repository.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/bloc/protected_provider.dart';
import 'package:piix_mobile/protected_feature_deprecated/utils/protected_copies.dart';
import 'package:piix_mobile/ui/common/clamping_scale_deprecated.dart';
import 'package:piix_mobile/widgets/no_internet.dart';
import 'package:provider/provider.dart';

import 'widgets/available_protected_deprecated/available_protected_widget_deprecated.dart';

@Deprecated('No longer in use with Piix 4.0 MyGroupHomeScreen')

/// Main screen for the protected section.
class ProtectedScreenBuilderDeprecated extends ConsumerStatefulWidget {
  const ProtectedScreenBuilderDeprecated({Key? key}) : super(key: key);

  @override
  ConsumerState<ProtectedScreenBuilderDeprecated> createState() =>
      _ProtectedScreenBuilderState();
}

class _ProtectedScreenBuilderState
    extends ConsumerState<ProtectedScreenBuilderDeprecated> {
  @override
  void initState() {
    initScreen();
    super.initState();
  }

  void initScreen() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        final protectedProvider = context.read<ProtectedProvider>();
        if (protectedProvider.protectedsInfo != null) return;
        final membershipBLoC = context.read<MembershipProviderDeprecated>();
        final membership = membershipBLoC.selectedMembership;
        final membershipId = membership?.membershipId ?? '';
        await protectedProvider.getAvailableProtected(
          membershipId: membershipId,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userBLoC = context.watch<UserBLoCDeprecated>();
    final membershipInfoBLoC = context.watch<MembershipProviderDeprecated>();
    final connectivityBLoC = context.watch<ConnectivityBLoC>();
    final protectedBLoC = context.watch<ProtectedProvider>();
    final activateStore = membershipInfoBLoC.activateStore;
    return WillPopScope(
      onWillPop: () async => goToMemberships(context, ref),
      child: ClampingScaleDeprecated(
        child: Scaffold(
          appBar: PiixAppBarDeprecated(
            title: '${userBLoC.user?.displayNames(max: 1) ?? ''} '
                '${userBLoC.user?.displayLastNames(max: 1) ?? ''}',
            isTabScreen: true,
            onPressed: () => goToMemberships(context, ref),
          ),
          body: Builder(
            builder: (context) {
              final protectedState = protectedBLoC.protectedState;
              final isLoading = protectedState == ProtectedState.retrieving ||
                  protectedState == ProtectedState.idle;
              if (!connectivityBLoC.fullConnection) {
                return const NoInternet();
              }
              if (protectedState == ProtectedState.error ||
                  protectedState == ProtectedState.notFound) {
                return LoadErrorWidgetDeprecated(
                  message: ProtectedCopies.protectedCouldNotLoad,
                  onPressed: initScreen,
                  textAction: PiixCopiesDeprecated.retry,
                );
              }
              return AvailableProtectedWidgetDeprecated(
                shouldActivateEcommerce: activateStore,
                isLoading: isLoading,
              );
            },
          ),
        ),
      ),
    );
  }
}
