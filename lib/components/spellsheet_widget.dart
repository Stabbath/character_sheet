import 'package:character_sheet/components/generic/section_header.dart';
import 'package:character_sheet/components/generic/spell_block.dart';
import 'package:character_sheet/core/providers/providers.dart';
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

    return IntrinsicHeight(
      child: IntrinsicWidth(
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
                  DropdownButton<String>(
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
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(labelText: 'Spell Save DC'),
                      keyboardType: TextInputType.number,
                      controller: TextEditingController(text: spellSaveDC.toString()),
                      onChanged: (value) {
                        spellSaveDCUpdater(int.tryParse(value) ?? 0);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(labelText: 'Spell Attack'),
                      keyboardType: TextInputType.number,
                      controller: TextEditingController(text: spellAttack.toString()),
                      onChanged: (value) {
                        spellAttackUpdater(int.tryParse(value) ?? 0);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // List of Spell Blocks
              Wrap(
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                spacing: 16.0, // horizontal space between items
                runSpacing: 16.0, // vertical space between rows
                children: [
                  for (var index = 0; index < lists.length; index++)
                    SpellBlockWidget(
                      title: lists[index]['title'],
                      currentSlots: lists[index]['slots'],
                      maxSlots: lists[index]['max_slots'],
                      list: List<Map<String, dynamic>>.from(lists[index]['list']),
                      defaultListEntry: defaultListEntry,
                      onChange: (newValue) {
                        listsUpdater([...lists]..[index] = newValue);
                      },
                    ),
                ],
              ),
              const SizedBox(height: 16),
              // Button to add a new Spell Block
              ElevatedButton.icon(
                onPressed: () {
                  print('Current lists: $lists');
                  print('Default entry: $defaultListsEntry');
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
