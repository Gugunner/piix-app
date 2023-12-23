import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

part 'linkup_code_type_model.freezed.dart';
part 'linkup_code_type_model.g.dart';

@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType',
)
class LinkupCodeTypeModel with _$LinkupCodeTypeModel {
  @JsonSerializable(explicitToJson: true)
  const LinkupCodeTypeModel._();

  const factory LinkupCodeTypeModel({
    @JsonKey(required: true, name: 'linkupCodeType')
    required LinkupCodeType type,
    @JsonKey(required: true) required String name,
  }) = _LinkupCodeTypeModel;

  factory LinkupCodeTypeModel.fromJson(Map<String, dynamic> json) =>
      _$LinkupCodeTypeModelFromJson(json);
}

enum LinkupCodeType {
  community,
  userGroup;

  //Used an extension as enhanced enums require constant values
//which can't occur with localMessage.
  String getTypeName(BuildContext context) {
    if (this == LinkupCodeType.community)
      return context.localeMessage.community;
    return context.localeMessage.familyGroup;
  }
}
