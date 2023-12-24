import 'package:json_annotation/json_annotation.dart';

part 'social_entity_model.g.dart';

///This class contains information for all type of clients or intermediaries.
///
/// Optional values are filled based on the type whether a physical entity or
/// a corporation entity.
///
/// When creating a client use
///```
///ClientModel()
///```
/// When creating an intermediary use
/// ```
/// IntermediaryModel()
/// ```
abstract class SocialEntityModel {
  const SocialEntityModel({
    required this.folio,
    required this.personTypeId,
    required this.name,
    this.email,
    this.internationalLada,
    this.phoneNumber,
    this.shortName,
    this.middleName,
    this.firstLastName,
    this.secondLastName,
  });
  @JsonKey(required: true)
  final String folio;
  @JsonKey(required: true)
  final String personTypeId;
  @JsonKey(required: true)
  final String name;
  final String? email;
  final String? internationalLada;
  final String? phoneNumber;
  final String? shortName;
  final String? middleName;
  final String? firstLastName;
  final String? secondLastName;
}

@JsonSerializable()
class ClientModel extends SocialEntityModel {
  const ClientModel({
    required this.clientId,
    required String folio,
    required String personTypeId,
    required String name,
    String? email,
    String? internationalLada,
    String? phoneNumber,
    String? shortName,
    String? middleName,
    String? firstLastName,
    String? secondLastName,
  }) : super(
          folio: folio,
          personTypeId: personTypeId,
          name: name,
          email: email,
          internationalLada: internationalLada,
          phoneNumber: phoneNumber,
          shortName: shortName,
          middleName: middleName,
          firstLastName: firstLastName,
          secondLastName: secondLastName,
        );

  final String clientId;

  factory ClientModel.fromJson(Map<String, dynamic> json) =>
      _$ClientModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClientModelToJson(this);
}

@JsonSerializable()
class IntermediaryModel extends SocialEntityModel {
  const IntermediaryModel({
    required this.intermediaryId,
    required this.intermediaryTypes,
    required String folio,
    required String personTypeId,
    required String name,
    String? email,
    String? internationalLada,
    String? phoneNumber,
    String? shortName,
    String? middleName,
    String? firstLastName,
    String? secondLastName,
  }) : super(
          folio: folio,
          personTypeId: personTypeId,
          name: name,
          email: email,
          internationalLada: internationalLada,
          phoneNumber: phoneNumber,
          shortName: shortName,
          middleName: middleName,
          firstLastName: firstLastName,
          secondLastName: secondLastName,
        );

  final String intermediaryId;
  final List<dynamic> intermediaryTypes;

  factory IntermediaryModel.fromJson(Map<String, dynamic> json) =>
      _$IntermediaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$IntermediaryModelToJson(this);
}

@JsonSerializable()
class IntermediaryTypeModel {
  const IntermediaryTypeModel({
    required this.name,
    required this.intermediaryTypeId,
  });

  final String name;
  final String intermediaryTypeId;

  factory IntermediaryTypeModel.fromJson(Map<String, dynamic> json) =>
      _$IntermediaryTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$IntermediaryTypeModelToJson(this);
}

//Not used at the moment
@JsonSerializable()
class AddressModel {
  const AddressModel({
    required this.street,
    required this.externalNumber,
    this.interiorNumber,
    this.subThoroughFare,
    this.thoroughFare,
    required this.countryId,
    this.stateId,
    this.city,
    required this.zipCode,
  });

  final String street;
  final String externalNumber;
  final String? interiorNumber;
  final String? subThoroughFare;
  final String? thoroughFare;
  final String countryId;
  final String? stateId;
  final String? city;
  final String zipCode;

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);

  AddressModel copyWith({
    String? street,
    String? externalNumber,
    String? interiorNumber,
    String? subThoroughFare,
    String? thoroughFare,
    String? countryId,
    String? stateId,
    String? city,
    String? zipCode,
  }) {
    return AddressModel(
        street: street ?? this.street,
        externalNumber: externalNumber ?? this.externalNumber,
        interiorNumber: interiorNumber ?? this.interiorNumber,
        subThoroughFare: subThoroughFare ?? this.subThoroughFare,
        thoroughFare: thoroughFare ?? this.thoroughFare,
        countryId: countryId ?? this.countryId,
        stateId: stateId ?? this.stateId,
        city: city ?? this.city,
        zipCode: zipCode ?? this.zipCode);
  }
}
