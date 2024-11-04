import 'package:character_sheet/components/generic/consumer_stateful_text_input.dart';
import 'package:character_sheet/components/generic/section_header.dart';
import 'package:character_sheet/components/generic/spell_block.dart';
import 'package:character_sheet/core/providers/providers.dart';
import 'package:character_sheet/utils/yaml_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/components.dart';

class SpellSheetWidget extends Component {
  const SpellSheetWidget({
    super.key,
    required super.definition,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(sheetDataProvider.select((state) => state?.get(definition.sourceKeys['title']!)));
    final spellcastingAbility = ref.watch(sheetDataProvider.select((state) => state?.get(definition.sourceKeys['spellcasting_ability']!)));
    final List<String> spellcastingAbilityOptions = List<String>.from(ref.watch(sheetDataProvider.select((state) => state?.get(definition.sourceKeys['spellcasting_ability_options']!))));
    final spellSaveDC = ref.watch(sheetDataProvider.select((state) => state?.get(definition.sourceKeys['spell_save_dc']!)));
    final spellAttack = ref.watch(sheetDataProvider.select((state) => state?.get(definition.sourceKeys['spell_attack']!)));
    final lists = ref.watch(sheetDataProvider.select((state) => state?.get(definition.sourceKeys['lists']!)));
    
    final Map<String, dynamic> defaultListsEntry = ref.watch(sheetDataProvider.select((state) => state?.get(definition.sourceKeys['default_lists_entry']!)));
    final Map<String, dynamic> defaultListEntry = ref.watch(sheetDataProvider.select((state) => state?.get(definition.sourceKeys['default_list_entry']!)));

    final spellcastingAbilityUpdater = ref.read(sheetDataProvider.notifier).getUpdater(definition.sourceKeys['spellcasting_ability']!);
    final spellSaveDCUpdater = ref.read(sheetDataProvider.notifier).getUpdater(definition.sourceKeys['spell_save_dc']!);
    final spellAttackUpdater = ref.read(sheetDataProvider.notifier).getUpdater(definition.sourceKeys['spell_attack']!);
    final listsUpdater = ref.read(sheetDataProvider.notifier).getUpdater(definition.sourceKeys['lists']!);

    final blocksPerRow = 4;

    return SizedBox(
      width: 1200,
      child: SizedBox(
        height: (200 + 400 * (lists.length ~/ blocksPerRow)).toDouble(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(title: title),
              const SizedBox(height: 16),
              // Spellcasting Ability Selection
              Row(
                children: [
                  const Text(
                    'Spellcasting Ability:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 120,
                    child: DropdownButton<String>(
                      value: spellcastingAbility,
                      items: spellcastingAbilityOptions.map((option) {
                        return DropdownMenuItem(value: option, child: Text(option));
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          spellcastingAbilityUpdater(value);
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ConsumerStatefulTextInput(
                      label: 'Spell Save DC',
                      textInputType: TextInputType.number,
                      initialValue: spellSaveDC.toString(),
                      onChanged: (value) {
                        spellSaveDCUpdater(int.tryParse(value) ?? 0);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ConsumerStatefulTextInput(
                      label: 'Spell Attack',
                      textInputType: TextInputType.number,
                      initialValue: spellAttack.toString(),
                      onChanged: (value) {
                        spellAttackUpdater(int.tryParse(value) ?? 0);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // List of Spell Blocks
              Expanded(
                child: Column(
                  children: [
                    // Complete rows
                    for (var rowIndex = 0; rowIndex < lists.length ~/ blocksPerRow; rowIndex++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var colIndex = 0; colIndex < blocksPerRow; colIndex++)
                              Expanded(
                                child: SpellBlockWidget(
                                  title: lists[rowIndex * blocksPerRow + colIndex]['title'],
                                  currentSlots: lists[rowIndex * blocksPerRow + colIndex]['slots'],
                                  maxSlots: lists[rowIndex * blocksPerRow + colIndex]['max_slots'],
                                  list: List<Map<String, dynamic>>.from(
                                    parseYamlValue(lists[rowIndex * blocksPerRow + colIndex]['list'])
                                  ),
                                  defaultListEntry: defaultListEntry,
                                  onChange: (newValue) {
                                    final newLists = [...lists];
                                    newLists[rowIndex * blocksPerRow + colIndex] = newValue;
                                    listsUpdater(newLists);
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    // Remaining items in last row
                    if (lists.length % blocksPerRow != 0)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var i = (lists.length ~/ blocksPerRow) * blocksPerRow; i < lists.length; i++)
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Expanded(
                                child: SpellBlockWidget(
                                  title: lists[i]['title'],
                                  currentSlots: lists[i]['slots'],
                                  maxSlots: lists[i]['max_slots'],
                                  list: List<Map<String, dynamic>>.from(
                                    parseYamlValue(lists[i]['list'])
                                  ),
                                  defaultListEntry: defaultListEntry,
                                  onChange: (newValue) {
                                    final newLists = [...lists];
                                    newLists[i] = newValue;
                                    listsUpdater(newLists);
                                  },
                                ),
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Button to add a new Spell Block
              ElevatedButton.icon(
                onPressed: () {
                  listsUpdater([...lists, {
                    'title': defaultListsEntry['title'],
                    'slots': defaultListsEntry['slots'],
                    'max_slots': defaultListsEntry['max_slots'],
                    'list': defaultListsEntry['list'],
                  }]);
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Spell Block'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
