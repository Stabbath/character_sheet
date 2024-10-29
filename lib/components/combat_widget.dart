import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/component.dart';
import '../core/providers.dart';
import 'generic/dynamic_stat_input.dart';
import 'generic/section_header.dart';
import 'generic/static_stat_input.dart';
import 'generic/text_block_input.dart';

class CombatWidget extends ConsumerWidget {
  final String id;
  final Map<String, StateNotifierProvider<KeyPathNotifier, dynamic>> statProviders;
  final StateNotifierProvider<KeyPathNotifier, dynamic> notesProvider;

  const CombatWidget({
    super.key,
    required this.id,
    required this.statProviders,
    required this.notesProvider,
  });

  CombatWidget.fromKeyPaths({
    super.key,
    required this.id,
    required Map<String, String> statKeyPaths,
    required String notesKeyPath,
  }) : statProviders = Map<String, StateNotifierProvider<KeyPathNotifier, dynamic>>.fromEntries(statKeyPaths.entries.map(
    (entry) => MapEntry<String, StateNotifierProvider<KeyPathNotifier, dynamic>>(entry.key, getKeyPathProvider(entry.value)),
  )),
    notesProvider = getKeyPathProvider(notesKeyPath);

  factory CombatWidget.fromComponent(Component component) {
    return CombatWidget.fromKeyPaths(
      id: component.id,
      statKeyPaths: component.dataBindings.map((key, value) => MapEntry<String, String>(key, value),),
      notesKeyPath: component.dataBindings['notes']!,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const requiredStats = ['hp', 'max_hp', 'temp_hp', 'exhaustion', 'max_exhaustion', 'armor_class', 'initiative', 'speed', 'notes'];
    for (var stat in requiredStats) {
      if (!statProviders.containsKey(stat)) {
        throw Exception('CombatWidget requires a binding for $stat');
      }
    }

    final notes = ref.watch(notesProvider);
    final notesNotifier = ref.read(notesProvider.notifier);

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
                  currentValueProvider: statProviders['hp']!,
                  maxValueProvider: statProviders['max_hp']!,
                ),
              ),
              Expanded(
                child: StaticStatInput(
                  label: 'Temporary Hit Points',
                  statProvider: statProviders['temp_hp']!,
                ),
              ),
              Expanded(
                child: DynamicStatInput(
                  label: 'Exhaustion',
                  currentValueProvider: statProviders['exhaustion']!,
                  maxValueProvider: statProviders['max_exhaustion']!,
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
                  statProvider: statProviders['armor_class']!,
                ),
              ),
              Expanded(
                child: StaticStatInput(
                  label: 'Initiative',
                  statProvider: statProviders['initiative']!,
                ),
              ),
              Expanded(
                child: StaticStatInput(
                  label: 'Speed',
                  statProvider: statProviders['speed']!,
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
                        initialValue: notes,
                        onChanged: (value) =>
                          notesNotifier.update(value),
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