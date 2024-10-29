import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/component.dart';
import '../core/providers.dart';
import 'generic/dynamic_stat_input.dart';
import 'generic/static_stat_input.dart';

class StatsCoreWidget extends ConsumerWidget {
  final String id;
  final Map<String, StateNotifierProvider<KeyPathNotifier, dynamic>> statProviders;

  const StatsCoreWidget({
    super.key,
    required this.id,
    required this.statProviders,
  });

  StatsCoreWidget.fromKeyPaths({
    super.key,
    required this.id,
    required Map<String, String> statKeyPaths,
  }) : statProviders = Map<String, StateNotifierProvider<KeyPathNotifier, dynamic>>.fromEntries(statKeyPaths.entries.map(
    (entry) => MapEntry<String, StateNotifierProvider<KeyPathNotifier, dynamic>>(entry.key, getKeyPathProvider(entry.value)),
  ));

    
  factory StatsCoreWidget.fromComponent(Component component) {
    return StatsCoreWidget.fromKeyPaths(
      id: component.id,
      statKeyPaths: component.dataBindings as Map<String, String>,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const requiredStats = ['hp', 'max_hp', 'temp_hp', 'exhaustion', 'max_exhaustion', 'armor_class', 'initiative', 'speed', 'proficiency_bonus'];
    for (var stat in requiredStats) {
      if (!statProviders.containsKey(stat)) {
        throw Exception('StatsCoreWidget requires a binding for $stat');
      }
    }

    return Column(
      children: [
        Expanded(
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
        Expanded(
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
            Expanded(
              child: StaticStatInput(
                label: 'Proficiency Bonus',
                statProvider: statProviders['proficiency_bonus']!,
              ),
            ),
          ],),
        ),
      ],
    );
  }
}