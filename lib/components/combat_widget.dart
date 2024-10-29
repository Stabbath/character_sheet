import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/layout/data_bindings.dart';
import '../core/layout/components.dart';
import '../core/providers.dart';
import 'generic/dynamic_stat_input.dart';
import 'generic/section_header.dart';
import 'generic/static_stat_input.dart';
import 'generic/text_block_input.dart';

class CombatWidget extends ConsumerWidget {
  static const requiredFields = [
    'hp',
    'max_hp',
    'temp_hp',
    'exhaustion',
    'max_exhaustion',
    'armor_class',
    'initiative',
    'speed',
    'notes',
  ];

  final String id;
  final Map<String, DataBinding> dataBindings;

  const CombatWidget({
    super.key,
    required this.id,
    required this.dataBindings,
  });

  factory CombatWidget.fromComponent(ComponentData component) {
    final missingKeys = getMissingInKeysFromDataBindings(component.dataBindings, requiredFields);
    if (missingKeys.isNotEmpty) {
      throw Exception('CombatWidget requires but is missing a binding for the following fields: $missingKeys');
    }

    return CombatWidget(
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
    final notesValue = ref.watch(sheetDataProvider.select((state) => state != null ? dataBindings['notes']!.getInSheet(state) : null));
    final notesUpdater = dataBindings['notes']!.createStateUpdater(ref.read(sheetDataProvider.notifier));

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: 'Combat'),
          SizedBox(
            height: 80,
            child: Row(children: [
              Expanded(
                child: DynamicStatInput(
                  label: 'Hit Points',
                  currentValueDataBinding: dataBindings['hp']!,
                  maxValueDataBinding: dataBindings['max_hp']!,
                ),
              ),
              Expanded(
                child: StaticStatInput(
                  label: 'Temporary Hit Points',
                  statDataBinding: dataBindings['temp_hp']!,
                ),
              ),
              Expanded(
                child: DynamicStatInput(
                  label: 'Exhaustion',
                  currentValueDataBinding: dataBindings['exhaustion']!,
                  maxValueDataBinding: dataBindings['max_exhaustion']!,
                ),
              ),
            ],),
          ),
          SizedBox(
            height: 80,
            child: Row(children: [
              Expanded(
                child: StaticStatInput(
                  label: 'Armor Class',
                  statDataBinding: dataBindings['armor_class']!,
                ),
              ),
              Expanded(
                child: StaticStatInput(
                  label: 'Initiative',
                  statDataBinding: dataBindings['initiative']!,
                ),
              ),
              Expanded(
                child: StaticStatInput(
                  label: 'Speed',
                  statDataBinding: dataBindings['speed']!,
                ),
              ),
            ]),
          ),
          Expanded(
            child: Row(children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeader(title: "Notes"),
                    const SizedBox(height: 8),
                    Expanded(
                      child: TextBlockInput(
                        initialValue: notesValue,
                        onChanged: (value) =>
                          notesUpdater(value),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}