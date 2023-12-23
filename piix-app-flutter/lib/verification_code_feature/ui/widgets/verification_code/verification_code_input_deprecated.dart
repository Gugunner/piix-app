import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/data/repository/auth_service_repository.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_service_provider_deprecated.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/utils/auth_user_copies.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/verification_code_feature/ui/widgets/verification_code/verification_codes_builder_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Use instead AppVerificationCodeScreen')
class VerificationCodeInputDeprecated extends StatelessWidget {
  const VerificationCodeInputDeprecated({super.key});

  @override
  Widget build(BuildContext context) {
    final verificationCodeState =
        context.watch<AuthServiceProvider>().verificationCodeState;
    final hasError = verificationCodeState == VerificationCodeState.conflict;
    return FocusScope(
      debugLabel: 'Focus Verification Code Input',
      autofocus: true,
      child: Focus(
        child: Builder(builder: (context) {
          final focusNode = Focus.of(context);
          final hasFocus = focusNode.hasFocus;
          return GestureDetector(
            onTap: () {
              if (hasFocus) {
                focusNode.unfocus();
              } else {
                focusNode.requestFocus();
              }
            },
            child: SizedBox(
              width: context.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            AuthUserCopies.codeInputLabel,
                            style: context.textTheme?.bodyMedium?.copyWith(
                              color: !hasError
                                  ? hasFocus
                                      ? PiixColors.insurance
                                      : PiixColors.infoDefault
                                  : PiixColors.error,
                              height: 12.sp / 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.w,
                  ),
                  SizedBox(
                    child: VerificationCodesBuilderDeprecated(
                      hasError: hasError,
                    ),
                  ),
                  if (hasError)
                    SizedBox(
                      child: Text(
                        AuthUserCopies.incorrectCode,
                        style: context.textTheme?.labelMedium?.copyWith(
                          color: PiixColors.error,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
