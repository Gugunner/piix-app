import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/date_extend_deprecated.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/membership_info_repository_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/membership_model/membership_model_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/piix_app_bar_deprecated.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/bloc/protected_provider.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/model/protected_model.dart';
import 'package:piix_mobile/protected_feature_deprecated/ui/protected_membership_view_deprecated.dart';
import 'package:piix_mobile/protected_feature_deprecated/ui/widgets/protected_row_text_data_deprecated.dart';
import 'package:piix_mobile/protected_feature_deprecated/utils/protected_utils.dart';
import 'package:piix_mobile/ui/common/clamping_scale_deprecated.dart';
import 'package:piix_mobile/ui/common/piix_tag_store.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

/// Creates a screen that shows the detail of a protected.
class ProtectedDetailDeprecated extends StatelessWidget {
  const ProtectedDetailDeprecated({Key? key}) : super(key: key);

  static const String routeName = '/protected_detail';

  Future<bool> handleBackProtectedDetail(BuildContext context) async {
    final protectedProvider = context.read<ProtectedProvider>();
    final membershipInfoBLoC = context.read<MembershipProviderDeprecated>();
    protectedProvider.selectedProtected = null;
    membershipInfoBLoC.setProtectedMembership(null);
    membershipInfoBLoC.protectedBenefitsByTypes = [];
    //Set to retrieved to avoid any conflicts with main membership
    membershipInfoBLoC.membershipInfoState =
        MembershipInfoStateDeprecated.retrieved;
    return true;
  }

  ///Get a protected membership data for protected detail screen
  Map<String, String> protectedMembershipInfoData(
    DateTime? fromDate,
    DateTime? toDate,
    MembershipModelDeprecated? membership,
  ) {
    return {
      PiixCopiesDeprecated.levelLabel:
          membership?.usersMembershipLevel.levelId ?? '-',
      PiixCopiesDeprecated.planLabel:
          membership?.usersMembershipPlans.first.planId ?? '-',
      PiixCopiesDeprecated.memberSince:
          membership?.registerDate.dateFormat ?? '-',
      PiixCopiesDeprecated.validitySince: fromDate?.dateFormat ?? '-',
      PiixCopiesDeprecated.validityUntil: toDate?.dateFormat ?? '-',
      PiixCopiesDeprecated.membershipID: membership?.membershipId ?? '-',
    };
  }

  ///Get a protected address data for protected detail screen
  Map<String, String> protectedAddressData(ProtectedModel? protected) {
    return {
      PiixCopiesDeprecated.country: protected?.countryName ?? '-',
      PiixCopiesDeprecated.state: protected?.stateName ?? '-',
      PiixCopiesDeprecated.city: protected?.city ?? '-',
      PiixCopiesDeprecated.postalCode: protected?.zipCode ?? '-',
    };
  }

  @override
  Widget build(BuildContext context) {
    final protectedProvider = context.watch<ProtectedProvider>();
    final membership =
        context.watch<MembershipProviderDeprecated>().selectedMembership;
    final selectedProtected = protectedProvider.selectedProtected;
    final isProtectedMembershipActive =
        selectedProtected?.membership?.isActive ?? false;
    final hasForm = selectedProtected?.userAlreadyHasBasicMainInfoForm ?? false;

    return WillPopScope(
      onWillPop: () async => handleBackProtectedDetail(context),
      child: ClampingScaleDeprecated(
        child: Scaffold(
          appBar: PiixAppBarDeprecated(
              title: '${selectedProtected?.name ?? '-'} '
                  '${selectedProtected?.firstLastName ?? '-'}'),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 4.h),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 32.h,
                      horizontal: 16.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 4.h,
                        ),
                        GestureDetector(
                          onTap: () =>
                              NavigatorKeyState().getNavigator()?.pushNamed(
                                    ProtectedMembershipViewDeprecated.routeName,
                                  ),
                          child: Text(
                            '${PiixCopiesDeprecated.viewMembership} >>',
                            style: context.accentTextTheme?.headlineLarge
                                ?.copyWith(
                              color: PiixColors.active,
                            ),
                          ),
                        ),
                        if (hasForm) ...[
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            PiixCopiesDeprecated.protectedInProcess,
                            textAlign: TextAlign.center,
                            style: context.accentTextTheme?.bodySmall,
                          ),
                        ],
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          PiixCopiesDeprecated.personalData,
                          style: context.primaryTextTheme?.titleMedium,
                        ),
                        ProtectedRowTextDataDeprecated(
                          data: protectedPersonalData(selectedProtected),
                        ),
                        if (hasForm)
                          Text(
                            PiixCopiesDeprecated.address,
                            style: context.primaryTextTheme?.titleMedium,
                          ),
                        if (hasForm)
                          ProtectedRowTextDataDeprecated(
                            data: protectedAddressData(selectedProtected),
                          ),
                        Text(
                          PiixCopiesDeprecated.membershipInfo,
                          style: context.primaryTextTheme?.titleMedium,
                        ),
                        ProtectedRowTextDataDeprecated(
                          data: protectedMembershipInfoData(
                            membership?.fromDate,
                            membership?.toDate,
                            selectedProtected?.membership,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              style: Theme.of(context).textButtonTheme.style,
                              onPressed: () => NavigatorKeyState()
                                  .getNavigator()
                                  ?.pushNamed(
                                    ProtectedMembershipViewDeprecated.routeName,
                                  ),
                              child: Text(
                                '${PiixCopiesDeprecated.viewMembership} >>',
                                style: context.accentTextTheme?.headlineLarge
                                    ?.copyWith(
                                  color: PiixColors.active,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style:
                                  Theme.of(context).elevatedButtonTheme.style,
                              child: Text(
                                PiixCopiesDeprecated.backText.toUpperCase(),
                                style: context.accentTextTheme?.labelMedium
                                    ?.copyWith(
                                  color: PiixColors.space,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 16.w,
                    top: 4.h,
                    child: Column(
                      children: [
                        Text(
                          '${PiixCopiesDeprecated.singularProtectedText} '
                          '${selectedProtected?.membership?.additionalSerialNumber ?? ''}:'
                          ' ${selectedProtected?.membership?.usersMembershipPlans.first.kinship.name ?? ''}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: PiixColors.gunMetal,
                              ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        SizedBox(
                          height: 24.h,
                          width: context.width * 0.48,
                          child: PiixTagStoreDeprecated(
                            text: isProtectedMembershipActive
                                ? PiixCopiesDeprecated.activatedMembership
                                : !(selectedProtected?.membership?.isActive ??
                                            false) &&
                                        (selectedProtected
                                                ?.userAlreadyHasBasicMainInfoForm ??
                                            false)
                                    ? PiixCopiesDeprecated.inProcesssLabel
                                    : PiixCopiesDeprecated.membershipToActivate,
                            backgroundColor: isProtectedMembershipActive
                                ? PiixColors.successMain
                                : PiixColors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
