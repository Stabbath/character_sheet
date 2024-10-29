import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/layout/data_bindings.dart';
import '../core/layout/component.dart';
import '../core/providers.dart';

class NamesWidget extends ConsumerWidget {
  static const requiredFields = [
    'names',
    'titles',
  ];

  final String id;
  final Map<String, DataBinding> dataBindings;

  const NamesWidget({
    super.key,
    required this.id,
    required this.dataBindings,
  });


  factory NamesWidget.fromComponent(Component component) {
    final missingKeys = getMissingInKeysFromDataBindings(component.dataBindings, requiredFields);

    if (missingKeys.isNotEmpty) {
      throw Exception('NamesWidget requires but is missing a binding for the following fields: $missingKeys');
    }

    return NamesWidget(
      id: component.id,
      dataBindings: Map<String, DataBinding>.fromEntries(
        requiredFields.map((field) => MapEntry(
          field,
          component.dataBindings[field]!,
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(sheetDataProvider.select((state) => state != null ? dataBindings['names']!.getInSheet(state) : null));
    final titles = ref.watch(sheetDataProvider.select((state) => state != null ? dataBindings['titles']!.getInSheet(state) : null));
    final namesUpdater = dataBindings['names']!.createStateUpdater(ref.read(sheetDataProvider.notifier));
    final titlesUpdater = dataBindings['titles']!.createStateUpdater(ref.read(sheetDataProvider.notifier));

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            textAlign: TextAlign.center,
            controller: TextEditingController(text: names),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            onChanged: (newValue) => namesUpdater(newValue),
            decoration: const InputDecoration(
              hintText: 'Character Name',
              border: InputBorder.none,
            ),
          ),
          TextFormField(
            textAlign: TextAlign.center,
            controller: TextEditingController(text: titles),
            style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            onChanged: (newValue) => titlesUpdater(newValue),
            decoration: const InputDecoration(
              hintText: 'Titles',
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
