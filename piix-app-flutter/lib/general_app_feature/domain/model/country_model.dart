import 'package:json_annotation/json_annotation.dart';
part 'country_model.g.dart';

@JsonSerializable()
class CountryModel {

  CountryModel({required this.countryId});

  @JsonKey(required: true)
  final String countryId;

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
    _$CountryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryModelToJson(this);

  CountryModel copyWith({
    String? countryId,
  }) => CountryModel(countryId: countryId ?? this.countryId);
}


