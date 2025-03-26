class SortCriteria {
  final String field;
  final bool ascending;

  SortCriteria({required this.field, this.ascending = true});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SortCriteria &&
        other.field == field &&
        other.ascending == ascending;
  }

  @override
  int get hashCode {
    return Object.hash(field, ascending);
  }

}
