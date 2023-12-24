import 'package:flutter/material.dart' show Color, IconData;
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';

/// Model for BenefitsByType object
class BenefitsByType {
  BenefitsByType({
    this.type,
    this.name,
    this.color,
    this.text,
    this.icon,
    this.benefits,
  });

  String? type;
  String? name;
  Color? color;
  String? text;
  IconData? icon;
  List<BenefitPerSupplierModel>? benefits;
}
