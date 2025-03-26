import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_example/core/presentation/components/custom_navigation_bar.dart';
import 'package:flutter_ecommerce_example/core/presentation/components/filter_sort_menu/filter_sort_menu.dart';
import 'package:flutter_ecommerce_example/core/providers/filter_criteria/filter_criteria.notifier.dart';
import 'package:flutter_ecommerce_example/domain.models/product.dart';
import 'package:flutter_ecommerce_example/features/products_view/providers/product/filtered_products.state.dart';
import 'package:flutter_ecommerce_example/features/products_view/providers/product/product.notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductViewPage extends ConsumerStatefulWidget {
  const ProductViewPage({super.key});

  @override
  ConsumerState<ProductViewPage> createState() => _DataPageState();
}

class _DataPageState extends ConsumerState<ProductViewPage> {
  @override
  void initState() {
    super.initState();

    Future(_initialize);
  }

  _initialize() {
    ref.read(productNotifierProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(filteredProductsStateProvider);

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text("Produtos"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          FilterSortMenu<Product>(
              onUpdate: ref
                  .read(filterCriteriaNotifierProvider.notifier)
                  .updateFilters),
        ],
      ),
      body: RefreshIndicator(
        color: Colors.white,
        onRefresh: () async =>
            ref.read(productNotifierProvider.notifier).refresh(),
        child: ListView(
          children: [
            ...products.map((product) => ListTile(
                  title: Text(product.description),
                  subtitle:
                      Text('Preço: \$${product.price.toStringAsFixed(2)}'),
                )),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: 0,
      ),
    );
  }
}
