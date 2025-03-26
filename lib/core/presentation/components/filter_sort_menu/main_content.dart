import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reflectable/mirrors.dart';

import '../../../providers/filter_criteria/filter_criteria.notifier.dart';
import '../../../../domain.models/filter_criteria.dart';
import '../../../services/filterable.dart';
import '../../../../domain.models/sort_criteria.dart';

class MainContent<T> extends ConsumerStatefulWidget {
  final Map<Type, List<String>> comparators;

  const MainContent({
    super.key,
    required this.comparators,
  });

  @override
  ConsumerState<MainContent<T>> createState() => MainContentState<T>();
}

class MainContentState<T> extends ConsumerState<MainContent<T>> {
  final List<FilterCriteria> filters = [];
  final List<SortCriteria> sorts = [];

  List<FilterCriteria> get currentFilters => filters;

  List<SortCriteria> get currentSorts => sorts;

  @override
  void initState() {
    final state = ref.read(filterCriteriaNotifierProvider);

    filters.addAll(state.filters);
    sorts.addAll(state.sorts);
    super.initState();
  }

  dynamic parseValue(String value, Type type) {
    if (type == int) return int.tryParse(value);
    if (type == double) return double.tryParse(value);
    if (type == DateTime) return DateTime.tryParse(value);
    return value;
  }

  Future<SortCriteria?> showAddSorterDialog(
      Iterable<VariableMirror> fields) async {
    VariableMirror? selectedField;
    bool ascending = true;

    return await showDialog(
      context: context,
      builder: (context) =>
          StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text('Novo Classificador'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButton<VariableMirror>(
                      hint: const Text('Selecione o campo'),
                      value: selectedField,
                      items: fields.map((field) {
                        final meta = field.metadata.first as FilterableField;
                        return DropdownMenuItem(
                          value: field,
                          child: Text(meta.label),
                        );
                      }).toList(),
                      onChanged: (field) {
                        setState(() {
                          if (field == null) return;
                          selectedField = field;
                        });
                      },
                    ),
                    if (selectedField != null)
                      DropdownButton<String>(
                        hint: const Text('Ordenar'),
                        value: ascending ? "Crescente" : "Decrescente",
                        items: [
                          DropdownMenuItem(
                            value: "Crescente",
                            child: Text("Crescente"),
                          ),
                          DropdownMenuItem(
                            value: "Decrescente",
                            child: Text("Decrescente"),
                          )
                        ],
                        onChanged: (value) =>
                            setState(() => ascending = value == "S"),
                      ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (selectedField != null) {
                        Navigator.pop(
                          context,
                          SortCriteria(
                            field: selectedField!.simpleName,
                            ascending: ascending,
                          ),
                        );
                      }
                    },
                    child: const Text('Aplicar'),
                  ),
                ],
              );
            },
          ),
    );
  }

  Future<FilterCriteria?> showAddFilterDialog(Iterable<VariableMirror> fields) async {
    VariableMirror? selectedField;
    String? selectedComparator;
    dynamic enteredValue;
    Type? fieldType;

    return await showDialog(
      context: context,
      builder: (context) =>
          StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text('Novo Filtro'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButton<VariableMirror>(
                      hint: const Text('Selecione o campo'),
                      value: selectedField,
                      items: fields.map((field) {
                        final meta = field.metadata.first as FilterableField;
                        return DropdownMenuItem(
                          value: field,
                          child: Text(meta.label),
                        );
                      }).toList(),
                      onChanged: (field) {
                        setState(() {
                          if (field == null) return;
                          selectedField = field;
                          fieldType = (field.metadata.first as FilterableField)
                              .comparatorsType;
                          selectedComparator = null;
                        });
                      },
                    ),
                    if (selectedField != null)
                      DropdownButton<String>(
                        hint: const Text('Operador'),
                        value: selectedComparator,
                        items: widget.comparators[fieldType]
                            ?.map((op) =>
                            DropdownMenuItem(
                              value: op,
                              child: Text(op),
                            ))
                            .toList(),
                        onChanged: (value) =>
                            setState(() => selectedComparator = value),
                      ),
                    if (selectedComparator != null)
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Valor para ${selectedField!.simpleName}',
                        ),
                        onChanged: (value) =>
                        enteredValue = parseValue(value, fieldType!),
                      ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (selectedField != null && selectedComparator != null) {
                        if (selectedField?.simpleName == null) return;

                        Navigator.pop(
                            context,
                            FilterCriteria(
                              field: selectedField!.simpleName,
                              comparator: selectedComparator!,
                              value: enteredValue,
                              valueType: fieldType!,
                            ));
                      }
                    },
                    child: const Text('Aplicar'),
                  ),
                ],
              );
            },
          ),
    );
  }

  Widget buildActiveFilters() {
    return Wrap(
      spacing: 8.0,
      children: filters
          .map(
            (filter) =>
            Chip(
              label:
              Text('${filter.field} ${filter.comparator} ${filter.value}'),
              onDeleted: () {
                setState(() {
                  filters.remove(filter);
                });
              },
            ),
      )
          .toList(),
    );
  }

  Widget buildActiveSorts() {
    return Wrap(
      spacing: 8.0,
      children: sorts
          .map((filter) =>
          Chip(
            label: Row(
              children: [
                Text(filter.field),
                Icon(filter.ascending
                    ? Icons.arrow_upward
                    : Icons.arrow_downward)
              ],
            ),
            onDeleted: () {
              setState(() {
                sorts.remove(filter);
              });
            },
          ))
          .toList(),
    );
  }

  Widget buildAddFilterButton(Iterable<VariableMirror> fields) {
    return ElevatedButton.icon(
        icon: const Icon(Icons.filter_alt),
        label: const Text('Adicionar Filtro'),
        onPressed: () async {
          final FilterCriteria? filter = await showAddFilterDialog(fields);

          if (filter != null) {
            setState(() {
              filters.add(filter);
            });
          }
        });
  }

  Widget buildAddSorterButton(Iterable<VariableMirror> fields) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.filter_list_sharp),
      label: const Text('Adicionar Classificador'),
      onPressed: () async {
        final SortCriteria? sort = await showAddSorterDialog(fields);

        if (sort != null) {
          setState(() {
            sorts.add(sort);
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final classMirror = filterable.reflectType(T) as ClassMirror;
    final fields = classMirror.declarations.values.whereType<VariableMirror>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildAddFilterButton(fields),
            buildAddSorterButton(fields),
            buildActiveFilters(),
            buildActiveSorts(),
          ],
        ),
      ),
    );
  }
}
