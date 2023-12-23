import 'package:flutter/material.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/data/repository/auth_service_repository.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_service_provider_deprecated.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/utils/auth_method_enum.dart';
import 'package:piix_mobile/general_app_feature/api/local/app_shared_preferences.dart';
import 'package:piix_mobile/general_app_feature/data/repository/file_system_repository_deprecated.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/file_system_bloc.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/ui_bloc.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/user_repository_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/memberships/blank_membership.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/memberships/memberships_cards_widget_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/location_utils.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget contains the calls to the services in order to load the user
///and membership information
///
class MembershipsBuilderDeprecated extends StatefulWidget {
  const MembershipsBuilderDeprecated({super.key});

  @override
  State<MembershipsBuilderDeprecated> createState() =>
      _MembershipsBuilderDeprecatedState();
}

class _MembershipsBuilderDeprecatedState
    extends State<MembershipsBuilderDeprecated> {
  late UiBLoC uiBLoC;
  late UserBLoCDeprecated userBLoC;
  late MembershipProviderDeprecated membershipBLoC;
  late FileSystemBLoC fileSystemBLoC;
  late Future<void> initScreenFuture;
  bool loadingMembershipImages = true;

  bool get showNoMembership =>
      userBLoC.userActionState == UserActionStateDeprecated.empty ||
      userBLoC.userActionState == UserActionStateDeprecated.error ||
      userBLoC.userActionState == UserActionStateDeprecated.notFound;

  bool get showMembership =>
      userBLoC.userActionState == UserActionStateDeprecated.retrieved &&
      userBLoC.memberships.isNotEmpty &&
      fileSystemBLoC.fileState != FileStateDeprecated.retrieving;

  Future<void> initScreen() async {
    setState(() {
      loadingMembershipImages = true;
    });
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        userBLoC.userActionState = UserActionStateDeprecated.retrieving;
        uiBLoC.loadText = PiixCopiesDeprecated.gettingMemberships;
        //TODO: Change to logic that check if memberships are already loaded so
        //it loads in the background the value
        if (membershipBLoC.selectedMembership != null) {
          uiBLoC.loadText = PiixCopiesDeprecated.gettingMemberships;
          await userBLoC.getUserLevelsAndPlans();
          setState(() {
            loadingMembershipImages = false;
          });
          return;
        }
        final authUser = await AppSharedPreferences.recoverAuthUser();
        if (authUser == null) {
          userBLoC.userActionState = UserActionStateDeprecated.notAuthorized;
          return;
        }
        final authServiceProvider = context.read<AuthServiceProvider>();
        await authServiceProvider.sendHashableAuthValues(
          userId: authUser.userId ?? '',
          hashableCustomAuthToken: authUser.customAccessToken ?? '',
          hashableUnixTime: authUser.hashableUnixTime ?? -1,
        );
        if (authServiceProvider.authState == AuthState.unauthorized) return;
        final usernameCredential = authUser.phoneNumber;
        const authMethod = AuthMethod.phoneSignIn;
        await getPermission();
        if (usernameCredential == null) {
          userBLoC.userActionState = UserActionStateDeprecated.notAuthorized;
          return;
        }
        await userBLoC.getUserByUsernameCredential(
          usernameCredential: usernameCredential,
          isPhoneNumber: authMethod.isPhoneNumber,
        );
        if (userBLoC.userActionState != UserActionStateDeprecated.retrieved)
          return;
        if (userBLoC.memberships.isEmpty) {
          userBLoC.userActionState = UserActionStateDeprecated.empty;
          return;
        }
        final futures = userBLoC.prepareMembershipLevelCardImages();
        final files = await Future.wait(futures);
        await userBLoC.obtainMembershipLevelCardImages(files);
        setState(() {
          loadingMembershipImages = false;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    initScreenFuture = initScreen();
  }

  @override
  Widget build(BuildContext context) {
    uiBLoC = context.watch<UiBLoC>();
    userBLoC = context.watch<UserBLoCDeprecated>();
    membershipBLoC = context.watch<MembershipProviderDeprecated>();
    fileSystemBLoC = context.watch<FileSystemBLoC>();
    return FutureBuilder(
      future: initScreenFuture,
      builder: (context, snapshot) {
        //Checks all possible loading phases of the future and of the requests
        //made
        final isLoading = snapshot.connectionState == ConnectionState.waiting ||
            userBLoC.userActionState == UserActionStateDeprecated.retrieving ||
            fileSystemBLoC.fileState == FileStateDeprecated.retrieving ||
            loadingMembershipImages;
        if (showNoMembership) {
          return const BlankMembership();
        }
        return MembershipsCardsWidgetDeprecated(
          isLoading: isLoading,
        );
      },
    );
  }
}
