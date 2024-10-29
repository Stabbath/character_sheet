import 'package:character_sheet/core/layout/data_bindings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/layout/component.dart';
import '../core/providers.dart';
import 'generic/text_block_input.dart';

class PersonalityWidget extends ConsumerWidget {
  static const requiredFields = [
    'traits',
    'ideals',
    'bonds',
    'flaws',
  ];

  final String id;
  final Map<String, DataBinding> dataBindings;

  const PersonalityWidget({
    super.key,
    required this.id,
    required this.dataBindings,
  });

  factory PersonalityWidget.fromComponent(Component component) {
    final missingKeys = getMissingInKeysFromDataBindings(component.dataBindings, requiredFields);
    if (missingKeys.isNotEmpty) {
      throw Exception('PersonalityWidget requires but is missing a binding for the following fields: $missingKeys');
    }

    return PersonalityWidget(
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
    final values = ref.watch(sheetDataProvider.select((state) => state != null ? dataBindings.map((key, value) => MapEntry(key, value.getInSheet(state))) : null))!;
    final updaters = dataBindings.map((key, value) => MapEntry(key, value.createStateUpdater(ref.read(sheetDataProvider.notifier))));

    return Column(
      children: [
        Expanded(child: Row(
          children: [
            Expanded(
              child: TextBlockInput(
                title: 'Personality Traits',
                initialValue: values['traits'],
                onChanged: (newValue) {
                  updaters['traits']!(newValue);
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextBlockInput(
                title: 'Ideals',
                initialValue: values['ideals'],
                onChanged: (newValue) {
                  updaters['ideals']!(newValue);
                },
              ),
            ),
          ],
        )),
        const SizedBox(height: 16),
        Expanded(child: Row(
          children: [
            Expanded(
              child: TextBlockInput(
                title: 'Bonds',
                initialValue: values['bonds'],
                onChanged: (newValue) {
                  updaters['bonds']!(newValue);
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextBlockInput(
                title: 'Flaws',
                initialValue: values['flaws'],
                onChanged: (newValue) {
                  updaters['flaws']!(newValue);
                },
              ),
            ),
          ]
        )),
      ],
    );
  }
}
