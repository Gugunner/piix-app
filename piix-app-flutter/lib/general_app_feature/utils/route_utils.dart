import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/notification_bloc.dart';
import 'package:piix_mobile/navigation_feature/utils/routes_utils.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/membership_info_repository_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/user_repository_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/bloc/protected_provider.dart';
import 'package:provider/provider.dart';

Future<bool> goToMemberships(BuildContext context, WidgetRef ref) async {
  final userBLoC = context.read<UserBLoCDeprecated>();
  final formNotifier = ref.read(formNotifierProvider.notifier);
  final notificationBLoC = context.read<NotificationBLoC>();
  final protectedBLoC = context.read<ProtectedProvider>();
  final membershipInfoBLoC = context.read<MembershipProviderDeprecated>();
  //Clean any forms and answers from the user
  formNotifier.setForm(null);
  userBLoC.userActionState = UserActionStateDeprecated.idle;
  notificationBLoC.clearNotifications();
  membershipInfoBLoC.membershipInfoState = MembershipInfoStateDeprecated.idle;
  protectedBLoC.clearProvider();
  RegisteredRouteUtils.appBarNav(context: context);
  return true;
}
