import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/date_extend_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///Shows a validities in a row format.
class ValidityRowDeprecated extends StatelessWidget {
  const ValidityRowDeprecated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final membership =
        context.watch<MembershipProviderDeprecated>().selectedMembership;
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
                text: PiixCopiesDeprecated.validityFrom.toUpperCase(),
                style: context.textTheme?.labelMedium,
                children: <TextSpan>[
                  TextSpan(
                    text: ' ${membership?.fromDate.dateFormat ?? '-'}',
                    style: context.textTheme?.labelMedium,
                  )
                ]),
          ),
          const SizedBox(height: 4),
          Text.rich(
            TextSpan(
                text: PiixCopiesDeprecated.validityLabel.toUpperCase(),
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(11),
                    color: Colors.transparent),
                children: <TextSpan>[
                  TextSpan(
                    text: PiixCopiesDeprecated.validityTo.toUpperCase(),
                    style: context.textTheme?.labelMedium,
                  ),
                  TextSpan(
                    text: ' ${membership?.toDate.dateFormat ?? '-'}',
                    style: context.textTheme?.labelMedium,
                  )
                ]),
          ),
        ],
      ),
    );
  }
}
