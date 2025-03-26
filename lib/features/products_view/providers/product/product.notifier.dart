import 'package:flutter_ecommerce_example/domain.models/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product.notifier.g.dart';

@Riverpod(keepAlive: true)
class ProductNotifier extends _$ProductNotifier {
  @override
  List<Product> build() {
    return [];
  }

  void _generateItems() {
    state = List.generate(100, (i) {
      final int id = i + 1;
      return Product(
        id: id,
        description: "Product_$id",
        price: id * 10.0,
      );
    });
  }

  void refresh() {
    _generateItems();
  }
}