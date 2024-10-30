import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/layout/data_bindings.dart';
import '../core/layout/components.dart';
import '../utils/string_utils.dart';
import 'generic/proficiency_skill_field.dart';
import 'generic/section_header.dart';

class AbilitySavesWidget extends ConsumerWidget {
  static const List<String> requiredFields = [
    'strength',
    'dexterity',
    'constitution',
    'intelligence',
    'wisdom',
    'charisma',
  ];
  static const List<String> requiredSubfields = [
    'bonus',
    'proficiency',
  ];

  final String id;
  final Map<String, Map<String, DataBinding>> dataBindings;
  final DataBinding proficiencyBinding;

  const AbilitySavesWidget({
    super.key,
    required this.id,
    required this.dataBindings,
    required this.proficiencyBinding,
  });
  
  factory AbilitySavesWidget.fromComponent(ComponentData component) {
    final missingKeys = getMissingInKeysFromDataBindings(component.dataBindings, buildInKeyPaths(requiredFields, requiredSubfields));
    if (missingKeys.isNotEmpty) {
      throw Exception('AbilitySavesWidget requires but is missing a binding for the following fields: $missingKeys');
    }

    return AbilitySavesWidget(
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
      proficiencyBinding: component.formulaBindings['proficiency_bonus']!,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Ability Saves'),
            ...requiredFields.map((field) {
            return ProficiencySkillField(
              label: underscoreToNormal(field),
              bonusDataBinding: dataBindings[field]!['bonus']!,
              proficiencyDataBinding: dataBindings[field]!['proficiency']!,
              proficiencyBonusFormulaBinding: proficiencyBinding,
            );
          }),
        ],
      ),
    );
  }
}
