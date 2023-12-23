import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_barrel_file.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_benefits_feature/domain/provider/membership_benefits_provider.dart';
import 'package:piix_mobile/membership_benefits_feature/ui/widgets/benefit_card/benefit_list_card.dart';
import 'package:piix_mobile/membership_feature/domain/provider/membership_provider.dart';
import 'package:piix_mobile/widgets/app_bar/title_app_bar.dart';
import 'package:piix_mobile/widgets/app_loading_widget/app_loading_widget.dart';
import 'package:piix_mobile/widgets/screen/app_screen/pop_app_screen.dart';

@Deprecated('Not in use')

///The landing screen where the user can filter and select all the app benefits
///to see it's detail or make a claim request
class MembershipLastGradeBenefitsScreenDeprecated extends AppLoadingWidget {
  static const routeName = '/membership_last_grade_benefits_screen';

  const MembershipLastGradeBenefitsScreenDeprecated({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MembershipLastGradeBenefitsScreenState();
}

class _MembershipLastGradeBenefitsScreenState
    extends AppLoadingWidgetState<MembershipLastGradeBenefitsScreenDeprecated> {
  @override
  Future<void> whileIsRequesting() async => ref
          .watch(membershipBenefitsServiceNotifierProvider)
          .whenOrNull(data: (_) {
        endRequest();
      }, error: (_, __) {
        endRequest();
      });

  @override
  Widget build(BuildContext context) {
    if (isRequesting) whileIsRequesting();
    ref.watch(membershipNotifierPodProvider);
    final benefitCount =
        ref.watch(membershipNotifierPodProvider.notifier).benefitCount;
    final membershipBenefits = ref.watch(membershipBenefitsNotifierProvider);

    return PopAppScreen(
      onWillPop: () async => true,
      appBar: TitleAppBar('Mis beneficios'),
      body: Shimmer(
        child: ShimmerLoading(
          isLoading: isRequesting,
          child: SingleChildScrollView(
            child: Container(
              width: context.width,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (isRequesting || membershipBenefits == null)
                    ...List.generate(
                      benefitCount,
                      (_) => Container(
                        margin: EdgeInsets.symmetric(vertical: 16.h),
                        child: BenefitListCard(),
                      ),
                    )
                  else
                    ...membershipBenefits.lastGradeBenefits.allBenefits.map(
                      (lastGradeBenefitPerSupplierModel) => Container(
                        margin: EdgeInsets.symmetric(vertical: 16.h),
                        child: BenefitListCard(
                          benefitPerSupplierModel:
                              lastGradeBenefitPerSupplierModel,
                        ),
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
