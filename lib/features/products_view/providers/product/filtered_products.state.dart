import 'package:flutter_ecommerce_example/core/providers/filter_criteria/filter_criteria.notifier.dart';
import 'package:flutter_ecommerce_example/core/services/predicate_builder.dart';
import 'package:flutter_ecommerce_example/core/services/sorter.dart';
import 'package:flutter_ecommerce_example/domain.models/product.dart';
import 'package:flutter_ecommerce_example/features/products_view/providers/product/product.notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filtered_products.state.g.dart';

@Riverpod(keepAlive: true)
List<Product> filteredProductsState(Ref ref) {
  final products = ref.watch(productNotifierProvider);
  final filterState = ref.watch(filterCriteriaNotifierProvider);

  List<Product> filtered = products
      .where(PredicateBuilder.buildPredicate(filterState.filters))
      .toList();

  if (filterState.sorts.isNotEmpty) {
    filtered = Sorter.sort(filtered, filterState.sorts);
  }
  return filtered;
}
