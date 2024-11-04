import 'package:character_sheet/core/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/providers/providers.dart';
import 'generic/dynamic_stat_input.dart';
import 'generic/section_header.dart';
import 'generic/static_stat_input.dart';
import 'generic/text_block_input.dart';

class CombatWidget extends Component {
  const CombatWidget({
    super.key,
    required super.definition,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesValue = ref.watch(sheetDataProvider.select((state) => state?.get(definition.sourceKeys['notes']!)));

    final notesValueUpdater = ref.read(sheetDataProvider.notifier).getUpdater(definition.sourceKeys['notes']!);

    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: Padding(
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
                      currentValueKey: definition.sourceKeys['hp']!,
                      maxValueKey: definition.sourceKeys['max_hp']!,
                    ),
                  ),
                  Expanded(
                    child: StaticStatInput(
                      label: 'Temporary Hit Points',
                      statKey: definition.sourceKeys['temp_hp']!,
                    ),
                  ),
                  Expanded(
                    child: DynamicStatInput(
                      label: 'Exhaustion',
                      currentValueKey: definition.sourceKeys['exhaustion']!,
                      maxValueKey: definition.sourceKeys['max_exhaustion']!,
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
                      statKey: definition.sourceKeys['armor_class']!,
                    ),
                  ),
                  Expanded(
                    child: StaticStatInput(
                      label: 'Initiative',
                      statKey: definition.sourceKeys['initiative']!,
                    ),
                  ),
                  Expanded(
                    child: StaticStatInput(
                      label: 'Speed',
                      statKey: definition.sourceKeys['speed']!,
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
                            onChanged: (value) => notesValueUpdater(value),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
