
import '../core/services/filterable.dart';

@filterable
class Product {
  @FilterableField(label: 'Id', comparatorsType: int)
  final int id;
  @FilterableField(label: 'Descrição')
  final String description;
  @FilterableField(label: 'Preço', comparatorsType: double)
  final double price;

  Product({
    required this.id,
    required this.description,
    required this.price,
  });
}

