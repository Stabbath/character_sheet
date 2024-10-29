import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/layout/data_bindings.dart';
import '../core/layout/components.dart';
import 'generic/ability_score_field.dart';
import 'generic/section_header.dart';

class AbilityScoresWidget extends ConsumerWidget {
  static const List<String> requiredFields = [
    'strength',
    'dexterity',
    'constitution',
    'intelligence',
    'wisdom',
    'charisma',
  ];
  static const List<String> requiredSubfields = [
    'base',
    'bonus',
  ];

  final String id;
  final Map<String, Map<String, DataBinding>> dataBindings;

  const AbilityScoresWidget({
    super.key,
    required this.id,
    required this.dataBindings,
  });

  factory AbilityScoresWidget.fromComponent(ComponentData component) {
    final missingKeys = getMissingInKeysFromDataBindings(component.dataBindings, buildInKeyPaths(requiredFields, requiredSubfields));
    if (missingKeys.isNotEmpty) {
      throw Exception('AbilityScoresWidget requires but is missing a binding for the following fields: $missingKeys');
    }

    return AbilityScoresWidget(
      id: component.id,
      dataBindings: Map<String, Map<String, DataBinding>>.fromEntries(
        requiredFields.map((field) => MapEntry(
          field,
          Map<String, DataBinding>.fromEntries(
            requiredSubfields.map((subfield) => MapEntry(
              subfield,
              component.dataBindings[buildInKeyPath(field, subfield)]!,
            )),
          ),
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Ability Scores'),
          AbilityScoreField(
            label: 'Strength',
            dataBindings: dataBindings['strength']!,
          ),
          const SizedBox(height: 10),
          AbilityScoreField(
            label: 'Dexterity',
            dataBindings: dataBindings['dexterity']!,
          ),
          const SizedBox(height: 10),
          AbilityScoreField(
            label: 'Constitution',
            dataBindings: dataBindings['constitution']!,
          ),
          const SizedBox(height: 10),
          AbilityScoreField(
            label: 'Intelligence',
            dataBindings: dataBindings['intelligence']!,
          ),
          const SizedBox(height: 10),
          AbilityScoreField(
            label: 'Wisdom',
            dataBindings: dataBindings['wisdom']!,
          ),
          const SizedBox(height: 10),
          AbilityScoreField(
            label: 'Charisma',
            dataBindings: dataBindings['charisma']!,
          ),
        ],
      ),
    );
  }
}
