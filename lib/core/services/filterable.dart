import 'package:reflectable/reflectable.dart';

class Filterable extends Reflectable {
  const Filterable()
      : super(
          invokingCapability,
          typeCapability,
          metadataCapability,
          reflectedTypeCapability,
          instanceInvokeCapability,
          declarationsCapability,
        );
}

const filterable = Filterable();

class FilterableField {
  final String label;
  final Type comparatorsType;

  const FilterableField({required this.label, this.comparatorsType = String});
}
