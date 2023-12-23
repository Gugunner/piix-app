enum FormFieldId {
  names,
  lastNames,
  birthdate,
  kinshipId,
  prefixId,
  genderId,
  countryId,
  stateId,
  zipCode,
  phoneNumber,
  email,
  country,
  state,
  kinship,
  address,
  section,
  signedDate,
  signedGeolocalization,
  signedHour,
  signedIp,
  none
}

extension FormFieldIdExtends on FormFieldId {
  static FormFieldId fromStringValue(String value) => FormFieldId.values
      .firstWhere((v) => v.name == value, orElse: () => FormFieldId.none);
}

