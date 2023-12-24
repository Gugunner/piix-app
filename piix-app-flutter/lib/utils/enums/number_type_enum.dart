enum NumberType {
  UNDEFINED,
  WHOLE,
  DECIMAL,
  WHOLE_PERCENTAGE,
  DECIMAL_PERCENTAGE,
  WHOLE_CURRENCY,
  DECIMAL_CURRENCY;

  bool get isDouble => name.toLowerCase().contains('decimal');
  bool get isPercentage => name.toLowerCase().contains('percentage');
  bool get isCurrency => name.toLowerCase().contains('currency');
}
