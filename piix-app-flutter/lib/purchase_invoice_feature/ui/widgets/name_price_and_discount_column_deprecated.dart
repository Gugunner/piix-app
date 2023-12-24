import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/utils/constants_deprecated/benefit_per_supplier_copies_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/int_extention.dart';
import 'package:piix_mobile/utils/extensions/list_extend.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_model.dart';
import 'package:piix_mobile/purchase_invoice_feature/utils/product_type_enum_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')

///This widget contains a name price and discount on especific type of payment
///
class NamePriceAndDiscountColumDeprecated extends StatelessWidget {
  const NamePriceAndDiscountColumDeprecated({
    Key? key,
    required this.invoice,
  }) : super(key: key);
  final InvoiceModel invoice;

  String get invoiceCoverageName {
    final products = invoice.products;
    final productName = products.productName;
    final productType = invoice.userQuotation.productType;
    switch (productType) {
      case ProductTypeDeprecated.LEVEL:
      case ProductTypeDeprecated.COMBO:
        return productName;
      case ProductTypeDeprecated.PLAN:
        final protecteds = 'protegido${products.protectedAcquired.pluralWithS}';
        return '${products.protectedAcquired.toString()} $protecteds';
      case ProductTypeDeprecated.ADDITIONAL:
        final additionalBenefitsPerSupplier =
            products.additionalBenefitsPerSupplier;
        if (additionalBenefitsPerSupplier.isNullOrEmpty) return '';
        final additionalBenefitPerSupplier =
            products.additionalBenefitsPerSupplier!.first;
        final coverageOfferValue =
            additionalBenefitPerSupplier.coverageOfferValue;
        final coverageOfferType =
            additionalBenefitPerSupplier.coverageOfferType;
        return '$productName con cobertura de hasta '
            '${BenefitPerSupplierCopiesDeprecated.coverageDescription(
          coverageOfferType,
          coverageOfferValue,
        )}';
      default:
        return '';
    }
  }

  String get peopleInCoverage {
    final protectedQuantity =
        invoice.protectedQuantityInCoverage.protectedQuantity;
    final includesMainUser =
        invoice.protectedQuantityInCoverage.includesMainUser;
    final protecteds = 'protegido${protectedQuantity.pluralWithS}';
    if (!includesMainUser) return 'para $protectedQuantity $protecteds';
    if (protectedQuantity == 0) {
      return 'para el titular';
    }
    return 'para ${protectedQuantity + 1} personas, $protectedQuantity '
        '$protecteds y el titular';
  }

  @override
  Widget build(BuildContext context) {
    final totalPremium = invoice.userQuotation.totalPremium;
    return Column(
      children: [
        Text(
          invoice.coverageNextStepText,
          style: context.textTheme?.bodyMedium?.copyWith(
            color: PiixColors.primary,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 8.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 4.w,
          ),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: invoiceCoverageName,
                  style: context.textTheme?.headlineSmall?.copyWith(
                    color: PiixColors.primary,
                  ),
                ),
                if (invoice.userQuotation.productType ==
                    ProductTypeDeprecated.PLAN)
                  TextSpan(
                    text: ' ${PiixCopiesDeprecated.aditionalsLabel}',
                    style: context.textTheme?.bodyMedium?.copyWith(
                      color: PiixColors.primary,
                    ),
                  )
                else
                  TextSpan(
                    text: '\n' + peopleInCoverage,
                    style: context.textTheme?.bodyMedium?.copyWith(
                      color: PiixColors.primary,
                    ),
                  ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${PiixCopiesDeprecated.total} ',
                style: context.textTheme?.displaySmall?.copyWith(
                  color: PiixColors.primary,
                ),
              ),
              TextSpan(
                text: BenefitPerSupplierCopiesDeprecated.coverageDescription(
                  ConstantsDeprecated.sumInsured,
                  totalPremium,
                ),
                style: context.textTheme?.displaySmall?.copyWith(
                  color: PiixColors.primary,
                ),
              ),
            ],
          ),
        ),
        Text(
          PiixCopiesDeprecated.includedDiscount(
            invoice.percentageFinalDiscount.toStringAsFixed(2),
          ),
          style: context.textTheme?.bodyMedium?.copyWith(
            color: PiixColors.primary,
          ),
        ),
      ],
    );
  }
}
