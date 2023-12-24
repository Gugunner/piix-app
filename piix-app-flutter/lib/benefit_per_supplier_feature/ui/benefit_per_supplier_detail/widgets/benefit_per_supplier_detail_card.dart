import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/ui/benefit_per_supplier_detail/claim_column_buttons_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/ui/benefit_per_supplier_detail/supplier_row_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/ui/benefit_per_supplier_detail/tag_benefit_row_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/image_memory_button.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/utils/piix_memberships_util_deprecated.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/bloc/protected_provider.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_html_parser.dart';
import 'package:piix_mobile/ui/common/piix_text_button_deprecated.dart';
import 'package:piix_mobile/ui/pdf/pdf_screen.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

/// Custom card for showing the benefits of a membership
class BenefitPerSupplierDetailCardDeprecated extends StatelessWidget {
  const BenefitPerSupplierDetailCardDeprecated({
    super.key,
    this.isLoading = false,
    required this.benefitPerSupplier,
  });
  final bool isLoading;
  final BenefitPerSupplierModel? benefitPerSupplier;

  @override
  Widget build(BuildContext context) {
    final protectedBLoC = context.watch<ProtectedProvider>();
    final shouldBlockActions = protectedBLoC.shouldBlockMainUserActions;
    if (benefitPerSupplier == null) return const SizedBox();
    final isCobenefit = benefitPerSupplier!.isCobenefit;
    return SizedBox(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TagBenefitRowDeprecated(
                benefitPerSupplier: benefitPerSupplier!,
                isCoBenefit: isCobenefit,
              ),
              Text(
                benefitPerSupplier!.benefitName,
                textAlign: TextAlign.start,
                style: context.primaryTextTheme?.displayMedium,
              ),
              if (benefitPerSupplier!.hasBenefitForm &&
                  !benefitPerSupplier!.userHasAlreadySignedTheBenefitForm &&
                  !shouldBlockActions) ...[
                const SizedBox(height: 8),
                Text(
                  getSignInfoLabelFromBenefit(
                      benefitPerSupplier!.needsBenefitFormSignature),
                  style: context.accentTextTheme?.bodySmall,
                ),
              ],
              SupplierRowDeprecated(
                isLoading: isLoading,
              ),
              ImageMemoryButton(
                imageMemory:
                    base64Decode(benefitPerSupplier!.benefitImageMemory),
                placeholder: PiixAssets.placeholderBen,
                width: context.width,
                boxFit: BoxFit.cover,
                isLoading: isLoading,
              ),
              SizedBox(
                height: 12.h,
              ),
              PiixHtmlParser(
                html: benefitPerSupplier?.wordingZero ?? '',
              ),
              if (benefitPerSupplier!.pdfWordingMemory?.base64Content != null)
                PiixTextButtonDeprecated(
                  text: PiixCopiesDeprecated.viewConditionsText,
                  onPressed:
                      benefitPerSupplier!.pdfWordingMemory?.base64Content !=
                              null
                          ? () {
                              Navigator.pushNamed(
                                context,
                                PDFDetailScreen.routeName,
                                arguments: benefitPerSupplier!.pdfWordingMemory,
                              );
                            }
                          : null,
                ),
              if ((!(benefitPerSupplier!.hasCobenefits) &&
                      !shouldBlockActions &&
                      !(benefitPerSupplier!.fromStore)) ||
                  isCobenefit) ...[
                SizedBox(height: 4.h),
                ClaimColumnButtonsDeprecated(isBenefit: !isCobenefit)
              ]
            ],
          ),
        ),
      ),
    );
  }
}
