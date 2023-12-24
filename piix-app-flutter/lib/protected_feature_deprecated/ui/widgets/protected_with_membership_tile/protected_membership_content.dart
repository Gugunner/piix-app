import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/ui/widgets/submit_button_builder_deprecated.dart';
import 'package:piix_mobile/extensions/date_extend_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/bloc/protected_provider.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/model/protected_model.dart';
import 'package:piix_mobile/protected_feature_deprecated/ui/protected_detail_deprecated.dart';
import 'package:provider/provider.dart';

class ProtectedMembershipContent extends StatelessWidget {
  const ProtectedMembershipContent({
    super.key,
    required this.protected,
    this.isActive = false,
  });

  final ProtectedModel protected;
  final bool isActive;

  void _toProtectedDetail(BuildContext context) {
    context.read<ProtectedProvider>().selectedProtected = protected;
    Navigator.of(context).pushNamed(ProtectedDetailDeprecated.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final kinshipName =
        protected.membership?.usersMembershipPlans.first.kinship.name ?? '';
    return Row(
      crossAxisAlignment:
          isActive ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              protected.fullName ?? '',
              style: context.textTheme?.titleMedium,
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              '${PiixCopiesDeprecated.kinshipColon} $kinshipName',
              style: context.textTheme?.bodyMedium,
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              '${PiixCopiesDeprecated.protectedNumber} '
              '${protected.membership?.additionalSerialNumber ?? ''}',
              style: context.textTheme?.bodyMedium,
            ),
            if (isActive) ...[
              SizedBox(
                height: 4.h,
              ),
              Text(
                '${PiixCopiesDeprecated.birthDateColon} '
                '${protected.birthdate?.dateFormat ?? '-'}',
                style: context.textTheme?.bodyMedium,
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                '${PiixCopiesDeprecated.upDate} '
                '${protected.membership?.registerDate.dateFormat ?? '-'}',
                style: context.textTheme?.bodyMedium,
              ),
            ],
          ],
        ),
        SizedBox(
          width: context.width * 0.16,
          height: context.height * 0.06,
          child: SubmitButtonBuilderDeprecated(
            onPressed: () => _toProtectedDetail(context),
            text: PiixCopiesDeprecated.viewText,
          ),
        ),
      ],
    );
  }
}
