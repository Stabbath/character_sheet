import 'package:character_sheet/core/sources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:yaml/yaml.dart';

import '../components/spellsheet_widget.dart';
import '../core/components.dart';
import '../core/providers/providers.dart';
import '../core/sheet_data.dart';

class MockSheetDataNotifier extends Mock {
  void getUpdater(String key) {}
}

final mockDefaultListsEntry = {
  'title': '',
  'slots': 0,  // Initialize with numeric value
  'max_slots': 0,  // Initialize with numeric value
  'list': <Map<String, dynamic>>[], 
};

void main() {
  late ProviderContainer container;
  late SpellSheetWidget widget;

  setUp(() {
    container = ProviderContainer();
    
    final mockDefinition = ComponentDefinition(
      type: ComponentType.spell_sheet,
      sourceKeys: {
        'title': 'spells.title',
        'spellcasting_ability': 'spells.spellcasting_ability',
        'spellcasting_ability_options': 'spells.ability_options',
        'spell_save_dc': 'spells.save_dc',
        'spell_attack': 'spells.attack',
        'lists': 'spells.lists',
        'default_lists_entry': 'spells.default_lists_entry',
        'default_list_entry': 'spells.default_list_entry',
      },
    );

    widget = SpellSheetWidget(definition: mockDefinition);

    // Set up initial state  SourceMap.fromDefinitions(SourceDefinitionMap definitions) : 
    container.read(sheetDataProvider.notifier).initialize(SheetData(SourceMap.fromDefinitions(SourceDefinitionMap.fromYaml(YamlMap.wrap({
      'spells.title': {
        'method': 'constant',
        'value': 'Spells',
      },
      'spells.spellcasting_ability': {
        'method': 'variable',
        'default': 'Intelligence', 
      },
      'spells.ability_options': {
        'method': 'constant',
        'value': ['Intelligence', 'Wisdom', 'Charisma'],
      },
      'spells.save_dc': {
        'method': 'variable',
        'default': 8,
      },
      'spells.attack': {
        'method': 'variable',
        'default': 0,
      },
      'spells.lists': {
        'method': 'variable',
        'default': [],
      },
      'spells.default_lists_entry': {
        'method': 'constant',
        'value': {
          'title': '',
          'slots': 0,
          'max_slots': 0,
          'list': [],
        },
      },
      'spells.default_list_entry': {
        'method': 'constant',
        'value': {'name': '', 'checked': false},
      }
    })))));
  });
  
  testWidgets('adds new spell block with proper numeric initialization', (tester) async {
    print('Initial lists: ${container.read(sheetDataProvider)?.get('spells.lists')}');
    print('Default entry: ${container.read(sheetDataProvider)?.get('spells.default_lists_entry')}');

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(home: Scaffold(body: widget)),
      ),
    );

    // Find and tap the "Add Spell Block" button
    final addButton = find.text('Add Spell Block');
    await tester.tap(addButton);
    await tester.pump();

    // Verify the new spell block was added with proper numeric values
    final listsAfter = container.read(sheetDataProvider)!.get('spells.lists');
    expect(listsAfter.length, 1);
    expect(listsAfter[0]['slots'], isA<int>());
    expect(listsAfter[0]['max_slots'], isA<int>());

    print('Final lists: $listsAfter');
  });

  testWidgets('updates spell slots with numeric values', (tester) async {
    print('Initial lists: ${container.read(sheetDataProvider)?.get('spells.lists')}');
    print('Default entry: ${container.read(sheetDataProvider)?.get('spells.default_lists_entry')}');

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(home: Scaffold(body: widget)),
      ),
    );

    // Add a spell block first
    await tester.tap(find.text('Add Spell Block'));
    await tester.pump();

    // Find the slot input fields
    final currentSlotField = find.widgetWithText(TextField, 'Current');
    final maxSlotField = find.widgetWithText(TextField, 'Max Slots');

    // Enter values
    await tester.enterText(currentSlotField, '3');
    await tester.enterText(maxSlotField, '4');
    await tester.pump();

    // Verify the values were properly converted to integers
    final listsAfter = container.read(sheetDataProvider)!.get('spells.lists');
    expect(listsAfter[0]['slots'], 3);
    expect(listsAfter[0]['max_slots'], 4);
    print('Final lists: $listsAfter');
  });
}