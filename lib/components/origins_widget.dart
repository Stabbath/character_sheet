import 'package:character_sheet/core/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/layout/data_bindings.dart';
import '../core/layout/components.dart';
import 'generic/consumer_stateful_text_input.dart';

class OriginsWidget extends ConsumerWidget {
  static const requiredFields = [
    'race',
    'background',
  ];

  final String id;
  final Map<String, DataBinding> dataBindings;

  const OriginsWidget({
    super.key,
    required this.id,
    required this.dataBindings,
  });

  factory OriginsWidget.fromComponent(ComponentData component) {
    final missingKeys = getMissingInKeysFromDataBindings(component.dataBindings, requiredFields);
    if (missingKeys.isNotEmpty) {
      throw Exception('OriginsWidget requires but is missing a binding for the following fields: $missingKeys');
    }

    return OriginsWidget(
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
    final race = ref.watch(sheetDataProvider.select((state) => state != null ? dataBindings['race']!.getInSheet(state) : null));
    final background = ref.watch(sheetDataProvider.select((state) => state != null ? dataBindings['background']!.getInSheet(state) : null));
    final raceUpdater = dataBindings['race']!.createStateUpdater(ref.read(sheetDataProvider.notifier));
    final backgroundUpdater = dataBindings['background']!.createStateUpdater(ref.read(sheetDataProvider.notifier));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConsumerStatefulTextInput(
          initialValue: race,
          label: 'Race',
          onChanged: (value) => raceUpdater(value),
          textInputType: TextInputType.text,
        ),
        const SizedBox(height: 16),
        ConsumerStatefulTextInput(
          initialValue: background,
          label: 'Background',
          onChanged: (value) => backgroundUpdater(value),
          textInputType: TextInputType.text,
        ),
      ],
    );
  }
}
