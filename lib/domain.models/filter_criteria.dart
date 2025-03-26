class FilterCriteria {
  final String field;
  final dynamic value;
  final String comparator;
  final Type valueType;

  FilterCriteria({
    required this.field,
    required this.value,
    required this.comparator,
    required this.valueType,
  });
}
