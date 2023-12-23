import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/ui/benefit_per_supplier_detail/benefit_per_supplier_detail_screen_deprecated.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/place_empty_list.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/bloc_deprecated/purchase_invoice_bloc_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_model.dart';
import 'package:piix_mobile/store_feature/domain/bloc/additional_benefits_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/utils/combos.dart';
import 'package:piix_mobile/ui/common/piix_tag_store.dart';
import 'package:provider/provider.dart';

///This widget maps and displays all the combo additions that each type of
///membership addition has.
class MyCombosList extends StatelessWidget {
  const MyCombosList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final purchaseInvoiceBLoC = context.watch<PurchaseInvoiceBLoCDeprecated>();
    final purchaseComboList = purchaseInvoiceBLoC.comboPurchaseList;

    return purchaseComboList.isEmpty
        ? const PlaceEmptyList(
            placeholderText: PiixCopiesDeprecated.notBuyCombo)
        : Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              listTileTheme: ListTileTheme.of(context).copyWith(dense: true),
            ),
            child: ExpansionTile(
                initiallyExpanded: true,
                collapsedIconColor: PiixColors.activeButton,
                iconColor: PiixColors.activeButton,
                tilePadding: EdgeInsets.only(right: 20.w, left: 12.w),
                title: Text(
                  PiixCopiesDeprecated.combos,
                  style: context.textTheme?.headlineSmall,
                ),
                children: <Widget>[
                  const Divider(
                      height: 1,
                      thickness: 1,
                      color: PiixColors.veryLightPink2),
                  SizedBox(height: 4.h),
                  ...purchaseComboList.map((InvoiceModel purchaseInvoiceModel) {
                    final index =
                        purchaseComboList.indexOf(purchaseInvoiceModel);
                    final combo = purchaseInvoiceModel.products.packageCombo;
                    final purchaseInvoiceId =
                        purchaseInvoiceModel.purchaseInvoiceId;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 8.h),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  combo?.name ?? '',
                                  style: context.textTheme?.bodyMedium,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              SizedBox(
                                width: 60.w,
                                height: 20.sp,
                                child: const PiixTagStoreDeprecated(
                                  text: PiixCopiesDeprecated.activeProduct,
                                  backgroundColor: PiixColors.successMain,
                                ),
                              ),
                            ]),
                        Divider(
                          height: 8.h,
                          color: PiixColors.mainText,
                        ),
                        ...combo?.additionalBenefitsPerSupplier.sortBenefits
                                .map(
                              (additionalBenefit) {
                                final additionalBenefitPerSupplier =
                                    additionalBenefit.mapOrNull((value) => null,
                                        purchased: (value) => value);
                                return Container(
                                  padding: EdgeInsets.symmetric(vertical: 8.h),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            additionalBenefitPerSupplier
                                                    ?.benefit.name ??
                                                '',
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                context.textTheme?.bodyMedium,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        GestureDetector(
                                            onTap: () => handleNavigateToDetail(
                                                context,
                                                purchaseInvoiceId,
                                                additionalBenefitPerSupplier),
                                            child: Text(
                                                PiixCopiesDeprecated.viewText,
                                                style: context.primaryTextTheme
                                                    ?.titleMedium
                                                    ?.copyWith(
                                                  color: PiixColors.active,
                                                ),
                                                textAlign: TextAlign.center))
                                      ]),
                                );
                              },
                            ) ??
                            [],
                        if (index == purchaseComboList.length - 1)
                          SizedBox(height: 12.h)
                        else
                          const Divider(
                            height: 16,
                            thickness: 1,
                            color: PiixColors.veryLightPink2,
                          )
                      ],
                    ).padHorizontal(12.w);
                  }),
                ]),
          );
  }

  void handleNavigateToDetail(BuildContext context, String purchaseInvoiceId,
      BenefitPerSupplierModel? additionalBenefitPerSupplier) async {
    final purchaseInvoiceBLoC = context.read<PurchaseInvoiceBLoCDeprecated>();
    final additionalBenefitsPerSupplierBLoC =
        context.read<AdditionalBenefitsPerSupplierBLoCDeprecated>();
    final selectedMembership =
        context.read<MembershipProviderDeprecated>().selectedMembership;
    final benefitPerSupplierBLoC =
        context.read<BenefitPerSupplierBLoCDeprecated>();
    if (selectedMembership != null && additionalBenefitPerSupplier != null) {
      additionalBenefitsPerSupplierBLoC.setCurrentAdditionalBenefitPerSupplier(
          purchaseInvoiceBLoC
              .invoice?.products.additionalBenefitsPerSupplier?.first);
      benefitPerSupplierBLoC
        ..isCobenefit = false
        ..setSelectedAdditionalBenefitPerSupplier(
          additionalBenefitPerSupplier,
        );
      NavigatorKeyState().getNavigator()?.pushNamed(
            BenefitPerSupplierDetailScreenDeprecated.routeName,
          );
    }
  }
}
