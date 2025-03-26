// This file has been generated by the reflectable package.
// https://github.com/dart-lang/reflectable.
import 'dart:core';
import 'package:flutter_ecommerce_example/core/services/filterable.dart'
    as prefix0;
import 'package:flutter_ecommerce_example/domain.models/product.dart'
    as prefix1;

// ignore_for_file: camel_case_types
// ignore_for_file: implementation_imports
// ignore_for_file: prefer_adjacent_string_concatenation
// ignore_for_file: prefer_collection_literals
// ignore_for_file: unnecessary_const
// ignore_for_file: unused_import

import 'package:reflectable/mirrors.dart' as m;
import 'package:reflectable/src/reflectable_builder_based.dart' as r;
import 'package:reflectable/reflectable.dart' as r show Reflectable;

final _data = <r.Reflectable, r.ReflectorData>{
  const prefix0.Filterable(): r.ReflectorData(
      <m.TypeMirror>[
        r.NonGenericClassMirrorImpl(
            r'Product',
            r'.Product',
            134217735,
            0,
            const prefix0.Filterable(),
            const <int>[0, 1, 2, 6],
            const <int>[7, 8, 9, 10, 11, 3, 4, 5],
            const <int>[],
            -1,
            {},
            {},
            {
              r'': (bool b) => ({id, description, price}) => b
                  ? prefix1.Product(
                      description: description, id: id, price: price)
                  : null
            },
            -1,
            -1,
            const <int>[-1],
            const <Object>[prefix0.filterable],
            null)
      ],
      <m.DeclarationMirror>[
        r.VariableMirrorImpl(r'id', 134349829, 0, const prefix0.Filterable(),
            -1, 1, 1, null, const <Object>[
          const prefix0.FilterableField(label: 'Id', comparatorsType: int)
        ]),
        r.VariableMirrorImpl(
            r'description',
            134349829,
            0,
            const prefix0.Filterable(),
            -1,
            2,
            2,
            null,
            const <Object>[const prefix0.FilterableField(label: 'Descrição')]),
        r.VariableMirrorImpl(r'price', 134349829, 0, const prefix0.Filterable(),
            -1, 3, 3, null, const <Object>[
          const prefix0.FilterableField(label: 'Preço', comparatorsType: double)
        ]),
        r.ImplicitGetterMirrorImpl(const prefix0.Filterable(), 0, 3),
        r.ImplicitGetterMirrorImpl(const prefix0.Filterable(), 1, 4),
        r.ImplicitGetterMirrorImpl(const prefix0.Filterable(), 2, 5),
        r.MethodMirrorImpl(r'', 0, 0, -1, 0, 0, null, const <int>[0, 1, 2],
            const prefix0.Filterable(), const []),
        r.MethodMirrorImpl(r'==', 2097154, -1, -1, 4, 4, null, const <int>[3],
            const prefix0.Filterable(), const []),
        r.MethodMirrorImpl(r'toString', 2097154, -1, -1, 2, 2, null,
            const <int>[], const prefix0.Filterable(), const []),
        r.MethodMirrorImpl(r'noSuchMethod', 524290, -1, -1, -1, -1, null,
            const <int>[4], const prefix0.Filterable(), const []),
        r.MethodMirrorImpl(r'hashCode', 2097155, -1, -1, 1, 1, null,
            const <int>[], const prefix0.Filterable(), const []),
        r.MethodMirrorImpl(r'runtimeType', 2097155, -1, -1, 5, 5, null,
            const <int>[], const prefix0.Filterable(), const [])
      ],
      <m.ParameterMirror>[
        r.ParameterMirrorImpl(r'id', 134358022, 6, const prefix0.Filterable(),
            -1, 1, 1, null, const [], null, #id),
        r.ParameterMirrorImpl(
            r'description',
            134358022,
            6,
            const prefix0.Filterable(),
            -1,
            2,
            2,
            null,
            const [],
            null,
            #description),
        r.ParameterMirrorImpl(r'price', 134358022, 6,
            const prefix0.Filterable(), -1, 3, 3, null, const [], null, #price),
        r.ParameterMirrorImpl(r'other', 134348806, 7,
            const prefix0.Filterable(), -1, 6, 6, null, const [], null, null),
        r.ParameterMirrorImpl(r'invocation', 134348806, 9,
            const prefix0.Filterable(), -1, 7, 7, null, const [], null, null)
      ],
      <Type>[
        prefix1.Product,
        int,
        String,
        double,
        bool,
        Type,
        Object,
        Invocation
      ],
      1,
      {
        r'==': (dynamic instance) => (x) => instance == x,
        r'toString': (dynamic instance) => instance.toString,
        r'noSuchMethod': (dynamic instance) => instance.noSuchMethod,
        r'hashCode': (dynamic instance) => instance.hashCode,
        r'runtimeType': (dynamic instance) => instance.runtimeType,
        r'id': (dynamic instance) => instance.id,
        r'description': (dynamic instance) => instance.description,
        r'price': (dynamic instance) => instance.price
      },
      {},
      null,
      [])
};

final _memberSymbolMap = null;

void initializeReflectable() {
  r.data = _data;
  r.memberSymbolMap = _memberSymbolMap;
}
