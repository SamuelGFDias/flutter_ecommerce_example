import 'package:flutter_ecommerce_example/domain.models/sort_criteria.dart';

import 'filterable.dart';

class Sorter {
  static List<T> sort<T>(List<T> items, List<SortCriteria> sortsCriteria) {
    if (sortsCriteria.isEmpty) return items;

    items.sort((a, b) {
      final instanceMirrorA = filterable.reflect(a!);
      final instanceMirrorB = filterable.reflect(b!);

      for (final criteria in sortsCriteria) {
        try {
          final valueA = instanceMirrorA.invokeGetter(criteria.field);
          final valueB = instanceMirrorB.invokeGetter(criteria.field);

          if (valueA == null && valueB == null) continue;
          if (valueA == null) return criteria.ascending ? -1 : 1;
          if (valueB == null) return criteria.ascending ? 1 : -1;

          final comparison = (valueA as Comparable).compareTo(valueB);
          if (comparison != 0) {
            return criteria.ascending ? comparison : -comparison;
          }
        } catch (e) {
          continue;
        }
      }
      return 0;
    });
    return items;
  }
}
