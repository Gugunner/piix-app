import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/date_extend_deprecated.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/ui_bloc.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/membership_info_repository_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/piix_app_bar_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/piix_benefit_deprecated/piix_benefit_list_deprecated.dart';
import 'package:piix_mobile/ui/common/piix_full_loader_deprecated.dart';
import 'package:piix_mobile/ui/common/piix_tag_store.dart';
import 'package:provider/provider.dart';

import '../domain/bloc/protected_provider.dart';

@Deprecated('Will be removed in 4.0')

///This screen render a protected membership view
class ProtectedMembershipViewDeprecated extends StatefulWidget {
  const ProtectedMembershipViewDeprecated({Key? key}) : super(key: key);
  static const String routeName = '/protected_membership_view';

  @override
  State<ProtectedMembershipViewDeprecated> createState() =>
      _ProtectedMembershipViewDeprecatedState();
}

class _ProtectedMembershipViewDeprecatedState
    extends State<ProtectedMembershipViewDeprecated> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initScreen();
    });
  }

  Future<void> _initScreen() async {
    final membershipInfoBLoC = context.read<MembershipProviderDeprecated>();
    final protectedBLoC = context.read<ProtectedProvider>();
    final uiBLoC = context.read<UiBLoC>();
    final membership = protectedBLoC.selectedProtected?.membership;
    if (membership == null) return;
    uiBLoC.loadText = PiixCopiesDeprecated.gettingUserInfo;
    await membershipInfoBLoC.getMembershipInfo(
      membership: membership,
      isProtected: true,
    );
    uiBLoC.loadText = '';
  }

  @override
  Widget build(BuildContext context) {
    final protectedBLoC = context.watch<ProtectedProvider>();
    final membershipInfoBLoC = context.watch<MembershipProviderDeprecated>();
    final membership = membershipInfoBLoC.selectedMembership;
    final selectedProtected = protectedBLoC.selectedProtected;
    final protectedMembership = membershipInfoBLoC.protectedMembership;
    final isMembershipActive = protectedMembership?.isActive ?? false;

    return Scaffold(
      appBar: PiixAppBarDeprecated(title: selectedProtected?.fullName ?? ''),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: membershipInfoBLoC.membershipInfoState ==
                MembershipInfoStateDeprecated.retrieving
            ? const PiixFullLoaderDeprecated()
            : Column(
                children: [
                  Card(
                          color: PiixColors.greyCard,
                          elevation: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selectedProtected?.fullName ?? ' ',
                                style: context.textTheme?.headlineSmall,
                              )
                                  .padHorizontal(
                                    12.w,
                                  )
                                  .padTop(
                                    16.h,
                                  ),
                              SizedBox(
                                height: 4.h,
                                width: double.infinity,
                              ),
                              Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                    text:
                                        '${PiixCopiesDeprecated.membershipWord}: ',
                                    style: context.textTheme?.headlineSmall,
                                  ),
                                  TextSpan(
                                    text:
                                        protectedMembership?.membershipId ?? '',
                                    style: context.textTheme?.headlineSmall,
                                  ),
                                ]),
                              ).padHorizontal(12.w),
                              SizedBox(height: 4.h),
                              Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                    text:
                                        '${PiixCopiesDeprecated.packageText} ',
                                    style: context.primaryTextTheme?.titleSmall,
                                  ),
                                  TextSpan(
                                    text: membership?.package.name ?? '',
                                    style: context.primaryTextTheme?.titleSmall,
                                  ),
                                ]),
                              ).padHorizontal(12.w),
                              SizedBox(height: 4.h),
                              Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                    text:
                                        '${PiixCopiesDeprecated.validityFrom} ',
                                    style: context.primaryTextTheme?.titleSmall,
                                  ),
                                  TextSpan(
                                    text: protectedMembership
                                            ?.fromDate.dateFormat ??
                                        '',
                                    style: context.textTheme?.bodyMedium,
                                  ),
                                ]),
                                textAlign: TextAlign.start,
                              ).padHorizontal(
                                12.w,
                              ),
                              Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                    text: '${PiixCopiesDeprecated.validityTo} ',
                                    style: context.primaryTextTheme?.titleSmall,
                                  ),
                                  TextSpan(
                                    text: protectedMembership
                                            ?.toDate.dateFormat ??
                                        '',
                                    style: context.textTheme?.bodyMedium,
                                  ),
                                ]),
                                textAlign: TextAlign.start,
                              ).padHorizontal(
                                12.w,
                              ),
                              SizedBox(height: 4.h),
                              Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                    text:
                                        '${PiixCopiesDeprecated.kinshipColon} ',
                                    style: context.primaryTextTheme?.titleSmall,
                                  ),
                                  TextSpan(
                                    text: selectedProtected?.membership
                                            ?.usersMembershipPlans.first.name ??
                                        '',
                                    style: context.textTheme?.bodyMedium,
                                  ),
                                ]),
                                textAlign: TextAlign.end,
                              )
                                  .padHorizontal(
                                    12.w,
                                  )
                                  .padBottom(
                                    16.h,
                                  ),
                            ],
                          ))
                      .padTop(
                        8.h,
                      )
                      .padHorizontal(
                        4.w,
                      ),
                  Card(
                    child: Column(
                      children: [
                        SizedBox(height: 9.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              PiixCopiesDeprecated.membershipCoverage,
                              style: context.textTheme?.headlineSmall,
                            ),
                            SizedBox(
                              height: 16.h,
                              width: context.width * 0.24,
                              child: PiixTagStoreDeprecated(
                                text: isMembershipActive
                                    ? PiixCopiesDeprecated.activeMembership
                                    : PiixCopiesDeprecated.inactiveMembership,
                                backgroundColor: isMembershipActive
                                    ? PiixColors.successMain
                                    : PiixColors.blueGrey,
                              ),
                            ),
                          ],
                        )
                            .padHorizontal(
                              8.w,
                            )
                            .padBottom(
                              12.h,
                            ),
                        const PiixBenefitListDeprecated(),
                      ],
                    ),
                  ).padHorizontal(4.w),
                ],
              ),
      ),
    );
  }
}
