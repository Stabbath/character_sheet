import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/data_bindings.dart';
import '../core/layout/component.dart';
import '../utils/map_utils.dart';
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
  final Map<String, DataBinding> dataBindings;

  const AbilityScoresWidget({
    super.key,
    required this.id,
    required this.dataBindings,
  });

  factory AbilityScoresWidget.fromComponent(Component component) {
    final missingKeys = getMissingKeyPaths(component.dataBindings, [requiredFields]);
    if (missingKeys.isNotEmpty) {
      throw Exception('AbilityScoresWidget requires but is missing a binding for the following fields: $missingKeys');
    }

    return AbilityScoresWidget(
      id: component.id,
      dataBindings: Map<String, DataBinding>.fromEntries(
        requiredFields.map((field) => MapEntry(
          field,
          component.dataBindings[field],
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
            dataBinding: dataBindings['strength']!,
          ),
          const SizedBox(height: 10),
          AbilityScoreField(
            label: 'Dexterity',
            dataBinding: dataBindings['dexterity']!,
          ),
          const SizedBox(height: 10),
          AbilityScoreField(
            label: 'Constitution',
            dataBinding: dataBindings['constitution']!,
          ),
          const SizedBox(height: 10),
          AbilityScoreField(
            label: 'Intelligence',
            dataBinding: dataBindings['intelligence']!,
          ),
          const SizedBox(height: 10),
          AbilityScoreField(
            label: 'Wisdom',
            dataBinding: dataBindings['wisdom']!,
          ),
          const SizedBox(height: 10),
          AbilityScoreField(
            label: 'Charisma',
            dataBinding: dataBindings['charisma']!,
          ),
        ],
      ),
    );
  }
}