@Deprecated('No longer in use in 4.0')
enum FieldIdDeprecated {
  uniqueId,
  unknown,
}

@Deprecated('No longer in use in 4.0')
class FormFieldUtilsDeprecated {
  static FieldIdDeprecated fromString(String formFieldId) =>
      FieldIdDeprecated.values.firstWhere((f) => f.name == formFieldId,
          orElse: () => FieldIdDeprecated.unknown);
}
