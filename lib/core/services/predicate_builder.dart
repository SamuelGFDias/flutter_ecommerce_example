import '../../domain.models/filter_criteria.dart';
import 'filterable.dart';

class PredicateBuilder {
  static bool Function(T) buildPredicate<T>(List<FilterCriteria> filters) {
    return (T item) {
      final instanceMirror = filterable.reflect(item!);

      for (final filter in filters) {
        final value = instanceMirror.invokeGetter(filter.field);
        final result = _compare(
          value: value,
          filter: filter.value,
          comparator: filter.comparator,
          valueType: filter.valueType,
        );

        if (!result) return false;
      }
      return true;
    };
  }

  static bool _compare({
    required dynamic value,
    required dynamic filter,
    required String comparator,
    required Type valueType,
  }) {
    switch (comparator) {
      case '==':
        return value == filter;
      case '!=':
        return value != filter;
      case 'contains':
        return value.toString().contains(filter.toString());
      case 'startsWith':
        return value.toString().startsWith(filter.toString());
      case 'endsWith':
        return value.toString().endsWith(filter.toString());
      case '>':
        return (value as Comparable).compareTo(filter) > 0;
      case '<':
        return (value as Comparable).compareTo(filter) < 0;
      case '>=':
        return (value as Comparable).compareTo(filter) >= 0;
      case '<=':
        return (value as Comparable).compareTo(filter) <= 0;
      default:
        return false;
    }
  }
}