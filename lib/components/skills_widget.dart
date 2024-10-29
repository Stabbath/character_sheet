import 'package:character_sheet/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/layout/data_bindings.dart';
import '../core/layout/component.dart';
import 'generic/proficiency_skill_field.dart';
import 'generic/section_header.dart';

class SkillsWidget extends ConsumerWidget {
  static const requiredFields = [
    'acrobatics',
    'animal_handling',
    'arcana',
    'athletics',
    'deception',
    'history',
    'insight',
    'intimidation',
    'investigation',
    'medicine',
    'nature',
    'perception',
    'performance',
    'persuasion',
    'religion',
    'sleight_of_hand',
    'stealth',
    'survival',
  ];
  static const List<String> requiredSubfields = [
    'bonus',
    'proficiency',
  ];

  final String id;
  final Map<String, Map<String, DataBinding>> dataBindings;

  const SkillsWidget({
    super.key,
    required this.id,
    required this.dataBindings,
  });

  factory SkillsWidget.fromComponent(Component component) {
    final missingKeys = getMissingInKeysFromDataBindings(component.dataBindings, buildInKeyPaths(requiredFields, requiredSubfields));
    if (missingKeys.isNotEmpty) {
      throw Exception('SkillsWidget requires but is missing a binding for the following fields: $missingKeys');
    }

    return SkillsWidget(
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
          const SectionHeader(title: 'Skills'),
          ...requiredFields.map((field) {
            return ProficiencySkillField(
              label: underscoreToNormal(field),
              dataBindings: dataBindings[field]!,
            );
          }),
        ],
      ),
    );
  }
}
