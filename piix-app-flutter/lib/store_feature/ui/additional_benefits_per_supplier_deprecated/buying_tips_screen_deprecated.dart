import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/store_feature/utils/store_module_enum_deprecated.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/purchase_invoice_history_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/pending_purchases_of_combo_model.dart';
import 'package:piix_mobile/store_feature/ui/quotations/managing_deprecated/quotation_ui_state_deprecated.dart';
import 'package:piix_mobile/store_feature/utils/buying_tips.dart';

@Deprecated('Will be removed in 4.0')
class BuyingTipsScreenDeprecated extends StatelessWidget {
  static const routeName = '/buying_tips_screen';
  const BuyingTipsScreenDeprecated({
    super.key,
    required this.samePurchase,
    required this.module,
    required this.quotationUiState,
    this.listPurchase = const [],
    this.quoteProductName = '',
  });
  final bool samePurchase;
  final List<PendingPurchasesOfComboModel> listPurchase;
  final StoreModuleDeprecated module;
  final QuotationUiStateDeprecated quotationUiState;
  final String quoteProductName;

  String get duplicateInName => listPurchase.map((e) => e.name).join(',');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 24.w),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Text(
              PiixCopiesDeprecated.weDetectedSomething,
              style: context.textTheme?.headlineMedium?.copyWith(
                color: PiixColors.primary,
              ),
            ),
            SizedBox(height: 24.h),
            if (module != StoreModuleDeprecated.plan)
              Column(
                children: [
                  if (listPurchase.isEmpty)
                    Text.rich(
                      TextSpan(children: [
                        TextSpan(
                            text: PiixCopiesDeprecated.alreadyPaymentLineTip,
                            style: context.textTheme?.bodyMedium),
                        TextSpan(
                          text: PiixCopiesDeprecated.purchaseHistory,
                          style: context.primaryTextTheme?.titleSmall?.copyWith(
                            color: PiixColors.clearBlue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => handleNavigateToHistory(context),
                        ),
                        TextSpan(
                            text: PiixCopiesDeprecated.ifYouInterested,
                            style: context.textTheme?.bodyMedium),
                      ]),
                      textAlign: TextAlign.justify,
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(children: [
                            TextSpan(
                                text: module.firstParagraph(
                                    productName: quoteProductName,
                                    duplicateIn: duplicateInName),
                                style: context.textTheme?.bodyMedium),
                            TextSpan(
                              text: PiixCopiesDeprecated.purchaseHistory,
                              style: context.primaryTextTheme?.titleSmall
                                  ?.copyWith(
                                color: PiixColors.clearBlue,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap =
                                    () => handleNavigateToHistory(context),
                            ),
                            TextSpan(
                                text: module.secondParagraph,
                                style: context.textTheme?.bodyMedium),
                          ]),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 24.h),
                        Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: '• ${module.firstTipBold}',
                              style: context.primaryTextTheme?.titleSmall,
                            ),
                            TextSpan(
                              text: module.firstTipNormal,
                              style: context.textTheme?.bodyMedium,
                            ),
                          ]),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8.h),
                        Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: '• ${module.secondTipBold}',
                              style: context.primaryTextTheme?.titleSmall,
                            ),
                            TextSpan(
                              text: module.secondTipNormal,
                              style: context.textTheme?.bodyMedium,
                            ),
                          ]),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                          text: module.firstParagraph(
                              productName: quoteProductName,
                              duplicateIn: duplicateInName),
                          style: context.textTheme?.bodyMedium),
                      TextSpan(
                        text: PiixCopiesDeprecated.purchaseHistory,
                        style: context.primaryTextTheme?.titleSmall?.copyWith(
                          color: PiixColors.clearBlue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => handleNavigateToHistory(context),
                      ),
                      TextSpan(
                        text: module.secondParagraph,
                        style: context.textTheme?.bodyMedium,
                      ),
                    ]),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 24.h),
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: '• ${module.firstTipBold}',
                        style: context.primaryTextTheme?.titleSmall,
                      ),
                      TextSpan(
                        text: module.firstTipNormal,
                        style: context.textTheme?.bodyMedium,
                      ),
                    ]),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 8.h),
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: '• ${module.secondTipBold}',
                        style: context.primaryTextTheme?.titleSmall,
                      ),
                      TextSpan(
                        text: module.secondTipNormal,
                        style: context.textTheme?.bodyMedium,
                      ),
                    ]),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            SizedBox(height: 24.h),
            SizedBox(
              width: context.width * 0.678,
              height: 34.h,
              child: ElevatedButton(
                onPressed: () => handleQuoteAnyway(),
                child: Text(
                  PiixCopiesDeprecated.quoteAnyway.toUpperCase(),
                  style: context.primaryTextTheme?.titleMedium?.copyWith(
                    color: PiixColors.space,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              width: context.width * 0.678,
              height: 34.h,
              child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    PiixCopiesDeprecated.backText.toUpperCase(),
                    style: context.primaryTextTheme?.titleMedium?.copyWith(
                      color: PiixColors.active,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void handleQuoteAnyway() => quotationUiState.hideBuyingTipsAlert();

  void handleNavigateToHistory(BuildContext context) => NavigatorKeyState()
      .getNavigator(context)
      ?.pushNamed(PurchaseInvoiceHistoryScreenDeprecated.routeName);
}
