import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/int_extention.dart';

part 'protected_quantity_model.freezed.dart';

part 'protected_quantity_model.g.dart';

@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType'
)
class ProtectedQuantityModel with _$ProtectedQuantityModel {
  const ProtectedQuantityModel._();

  factory ProtectedQuantityModel({
    @JsonKey(required: true)
    required int protectedQuantity,
    @Default(true)
    bool includesMainUser,
  }) = _ProtectedQuantityModel;

  factory ProtectedQuantityModel.fromJson(Map<String, dynamic> json) =>
      _$ProtectedQuantityModelFromJson(json);

}

extension ProtectedQuantityExtension on ProtectedQuantityModel? {
  String get protectedInCoverage {
    final protectedQuantity = this?.protectedQuantity ?? 0;
    final includesMainUser = this?.includesMainUser ?? false;
    final protecteds = 'protegido${protectedQuantity.pluralWithS}';
    if (includesMainUser) {
      if (protectedQuantity == 0) {
        return 'titular';
      }
      return '$protectedQuantity $protecteds '
          'y el titular';
    } else {
      return '$protectedQuantity $protecteds';
    }
  }

  String get totalQuantityCovered {
    final protectedQuantity = this?.protectedQuantity ?? 0;
    final includesMainUser = this?.includesMainUser ?? false;

    if (includesMainUser) {
      return '${protectedQuantity + 1} ';
    } else {
      return '$protectedQuantity';
    }
  }
}
