import 'package:json_annotation/json_annotation.dart';

part 'selector_model.g.dart';

///Handles any data that is to be used as a selector inside an input
@JsonSerializable()
class SelectorModel {
  SelectorModel({
    required this.id,
    required this.folio,
    required this.name,
    this.typeId,
  });
  @JsonKey(
    name: 'valueId',
    required: true,
  )
  String id;
  @JsonKey(required: true)
  String folio;
  @JsonKey(required: true)
  String name;
  //Use this to filter another PiixFormFieldModel values by the typeId
  String? typeId;

  static String appId(Map<String, dynamic> json) {
    if (json['stateId'] != null) {
      return json['stateId'];
    } else if (json['genderId'] != null) {
      return json['genderId'];
    } else if (json['kinshipId'] != null) {
      return json['kinshipId'];
    } else if (json['prefixId'] != null) {
      return json['prefixId'];
    } else if (json['countryId'] != null) {
      return json['countryId'];
    } else if (json['packageId'] != null) {
      return json['packageId'];
    }
    return json['valueId'];
  }

  factory SelectorModel.fromJson(Map<String, dynamic> json) {
    json['valueId'] = appId(json);
    return _$SelectorModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SelectorModelToJson(this);

  SelectorModel copyWith({
    String? id,
    String? name,
    String? folio,
    String? typeId,
  }) {
    return SelectorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      folio: folio ?? this.folio,
      typeId: typeId ?? this.typeId,
    );
  }
}

///A class that stores the list of [SelectorModel]
@JsonSerializable()
class SelectorsModel {
  SelectorsModel({required this.selectors});

  List<SelectorModel> selectors;

  factory SelectorsModel.fromJson(Map<String, dynamic> json) {
    return _$SelectorsModelFromJson(json);
  }
}

@JsonSerializable()
class SelectorObjectModel {
  SelectorObjectModel({
    required this.characteristics,
    required this.name,
  });

  final List<String> characteristics;
  final String name;

  factory SelectorObjectModel.fromJson(Map<String, dynamic> json) =>
      _$SelectorObjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$SelectorObjectModelToJson(this);

  SelectorObjectModel copyWith({
    List<String>? characteristics,
    String? name,
  }) =>
      SelectorObjectModel(
          characteristics: characteristics ?? this.characteristics,
          name: name ?? this.name);
}
