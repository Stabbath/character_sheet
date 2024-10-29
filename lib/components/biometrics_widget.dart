import 'package:character_sheet/components/generic/consumer_stateful_text_input.dart';
import 'package:character_sheet/core/layout/data_bindings.dart';
import 'package:character_sheet/core/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/layout/components.dart';

class BiometricsWidget extends ConsumerWidget {
  static const List<String> requiredFields = [
    'age',
    'height',
    'weight',
    'eyes',
    'skin',
    'hair',
  ];

  final String id;
  final Map<String, DataBinding> dataBindings;

  const BiometricsWidget({
    super.key,
    required this.id,
    required this.dataBindings,
  });

  factory BiometricsWidget.fromComponent(ComponentData component) {
    final missingKeys = getMissingInKeysFromDataBindings(component.dataBindings, requiredFields);
    if (missingKeys.isNotEmpty) {
      throw Exception('BiometricsWidget requires but is missing a binding for the following fields: $missingKeys');
    }

    return BiometricsWidget(
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
    final Map<String, dynamic> values = ref.watch(sheetDataProvider.select((state) => state != null ? dataBindings.map((key, value) => MapEntry(key, value.getInSheet(state))) : null))!;
    final Map<String, Function(dynamic)> updaters = dataBindings.map((key, value) => MapEntry(key, value.createStateUpdater(ref.read(sheetDataProvider.notifier))));

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ConsumerStatefulTextInput(
                initialValue: values['age'].toString(),
                label: 'Age',
                textInputType: TextInputType.number,
                onChanged: (value) => updaters['age']!(int.tryParse(value) ?? 0),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ConsumerStatefulTextInput(
                initialValue: values['height'].toString(),
                label: 'Height',
                textInputType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) => updaters['height']!(double.tryParse(value) ?? 0),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ConsumerStatefulTextInput(
                initialValue: values['weight'].toString(),
                label: 'Weight',
                textInputType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) => updaters['weight']!(double.tryParse(value) ?? 0),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ConsumerStatefulTextInput(
                initialValue: values['eyes'].toString(),
                label: 'Eye Color',
                onChanged: (value) => updaters['eyes']!(value),
                textInputType: TextInputType.text,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ConsumerStatefulTextInput(
                initialValue: values['skin'].toString(),
                label: 'Skin Color',
                onChanged: (value) => updaters['skin']!(value),
                textInputType: TextInputType.text,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ConsumerStatefulTextInput(
                initialValue: values['hair'].toString(),
                label: 'Hair Color',
                onChanged: (value) => updaters['hair']!(value),
                textInputType: TextInputType.text,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
