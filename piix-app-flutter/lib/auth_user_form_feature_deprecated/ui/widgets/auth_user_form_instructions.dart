import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/utils/auth_user_form_copies.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/header_description_rich_text_widget.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_verification_feature/domain/provider/membership_verification_provider.dart';

@Deprecated('Do not use')
class AuthUserFormInstructions extends ConsumerWidget {
  const AuthUserFormInstructions({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final community = ref.watch(communityDeprecatedPodProvider);
    final showCommunityInstructions = community.showCommunityInstructions;
    final loadImageInstructions = community.loadImageInstructions ?? '';
    final communityNameInstructions = community.communityNameInstructions ?? '';
    final idNumberInstructions = community.idNumberInstructions ?? '';
    return SizedBox(
      child: Column(
        children: [
          if (showCommunityInstructions)
            Container(
              padding: EdgeInsets.all(
                8.w,
              ),
              width: context.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: PiixColors.successMain,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AuthUserFormCopies.fillInstructions,
                    style: context.primaryTextTheme?.titleMedium,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  HeaderDescriptionRichTextWidget(
                    header: AuthUserFormCopies.loadingImages,
                    text: loadImageInstructions,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  HeaderDescriptionRichTextWidget(
                    header: AuthUserFormCopies.communityName,
                    text: communityNameInstructions,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  HeaderDescriptionRichTextWidget(
                    header: AuthUserFormCopies.idNumber,
                    text: idNumberInstructions,
                  ),
                ],
              ),
            ),
          if (child != null) child!,
        ],
      ),
    );
  }
}
