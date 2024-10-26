import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/component.dart';
import '../core/key_path_providers.dart';
import 'generic/dynamic_stat_input.dart';
import 'generic/static_stat_input.dart';

class StatsCoreWidget extends ConsumerWidget {
  final String id;
  final Map<String, Provider<dynamic>> statProviders;

  const StatsCoreWidget({
    super.key,
    required this.id,
    required this.statProviders,
  });

  StatsCoreWidget.fromKeyPaths({
    super.key,
    required this.id,
    required Map<String, String> statKeyPaths,
  }) : statProviders = Map<String, Provider<dynamic>>.fromEntries(statKeyPaths.entries.map(
    (entry) => MapEntry<String, Provider<dynamic>>(entry.key, getKeyPathProvider(entry.value)),
  ));

    
  factory StatsCoreWidget.fromComponent(Component component) {
    return StatsCoreWidget.fromKeyPaths(
      id: component.id,
      statKeyPaths: component.dataBindings,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
          child: Row(children: [
            Expanded(
              child: DynamicStatInput(
                label: 'Hit Points',
                currentValueProvider: statProviders['hp'] ?? Provider((ref) => null),
                maxValueProvider: statProviders['max_hp'] ?? Provider((ref) => null),
              ),
            ),
            Expanded(
              child: StaticStatInput(
                label: 'Temporary Hit Points',
                statProvider: statProviders['temp_hp'] ?? Provider((ref) => null),
              ),
            ),
            Expanded(
              child: DynamicStatInput(
                label: 'Exhaustion',
                currentValueProvider: statProviders['exhaustion'] ?? Provider((ref) => null),
                maxValueProvider: statProviders['max_exhaustion'] ?? Provider((ref) => null),
              ),
            ),
          ],),
        ),
        Expanded(
          child: Row(children: [
            Expanded(
              child: StaticStatInput(
                label: 'Armor Class',
                statProvider: statProviders['armor_class'] ?? Provider((ref) => null),
              ),
            ),
            Expanded(
              child: StaticStatInput(
                label: 'Initiative',
                statProvider: statProviders['initiative'] ?? Provider((ref) => null),
              ),
            ),
            Expanded(
              child: StaticStatInput(
                label: 'Speed',
                statProvider: statProviders['speed'] ?? Provider((ref) => null),
              ),
            ),
            Expanded(
              child: StaticStatInput(
                label: 'Proficiency Bonus',
                statProvider: statProviders['proficiency_bonus'] ?? Provider((ref) => null),
              ),
            ),
          ],),
        ),
      ],
    );
  }
}