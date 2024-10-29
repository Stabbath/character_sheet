import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/component.dart';
import '../core/providers.dart';
import 'generic/proficiency_skill_field.dart';
import 'generic/section_header.dart';

class SkillsWidget extends ConsumerWidget {
  final String id;
  final Map<String, StateNotifierProvider<KeyPathNotifier, dynamic>> skillBonusProviders;
  final Map<String, StateNotifierProvider<KeyPathNotifier, dynamic>> skillProficiencyProviders;

  const SkillsWidget({
    super.key,
    required this.id,
    required this.skillBonusProviders,
    required this.skillProficiencyProviders,
  });

  SkillsWidget.fromKeyPaths({
    super.key,
    required this.id,
    required Map<String, String> skillBonusKeyPaths,
    required Map<String, String> skillProficiencyKeyPaths,
  }) : skillBonusProviders = skillBonusKeyPaths.map((label, keyPath) => MapEntry(label, getKeyPathProvider(keyPath))),
       skillProficiencyProviders = skillProficiencyKeyPaths.map((label, keyPath) => MapEntry(label, getKeyPathProvider(keyPath)));

  factory SkillsWidget.fromComponent(Component component) {
    Map<String, String> skillBonusKeyPaths = {};
    Map<String, String> skillProficiencyKeyPaths = {};

    for (var key in component.dataBindings.keys) {
      skillBonusKeyPaths[key] = component.dataBindings[key]['bonus'];
      skillProficiencyKeyPaths[key] = component.dataBindings[key]['proficiency'];
    }

    return SkillsWidget.fromKeyPaths(
      id: component.id,
      skillBonusKeyPaths: skillBonusKeyPaths,
      skillProficiencyKeyPaths: skillProficiencyKeyPaths,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const requiredStats = [
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
    for (var stat in requiredStats) {
      if (!skillBonusProviders.containsKey(stat) || !skillProficiencyProviders.containsKey(stat)) {
        throw Exception('SkillsWidget requires a binding for $stat');
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Skills'),
          ProficiencySkillField.fromProviders(
            label: 'Acrobatics',
            skillBonusProvider: skillBonusProviders['acrobatics']!,
            skillProficiencyProvider: skillProficiencyProviders['acrobatics']!,
          ),
          ProficiencySkillField.fromProviders(
            label: 'Animal Handling',
            skillBonusProvider: skillBonusProviders['animal_handling']!,
            skillProficiencyProvider: skillProficiencyProviders['animal_handling']!,
          ),
          ProficiencySkillField.fromProviders(
            label: 'Arcana',
            skillBonusProvider: skillBonusProviders['arcana']!,
            skillProficiencyProvider: skillProficiencyProviders['arcana']!,
          ),
          ProficiencySkillField.fromProviders(
            label: 'Athletics',
            skillBonusProvider: skillBonusProviders['athletics']!,
            skillProficiencyProvider: skillProficiencyProviders['athletics']!,
          ),
          ProficiencySkillField.fromProviders(
            label: 'Deception',
            skillBonusProvider: skillBonusProviders['deception']!,
            skillProficiencyProvider: skillProficiencyProviders['deception']!,
          ),
          ProficiencySkillField.fromProviders(
            label: 'History',
            skillBonusProvider: skillBonusProviders['history']!,
            skillProficiencyProvider: skillProficiencyProviders['history']!,
          ),
          ProficiencySkillField.fromProviders(
            label: 'Insight',
            skillBonusProvider: skillBonusProviders['insight']!,
            skillProficiencyProvider: skillProficiencyProviders['insight']!,
          ),
          ProficiencySkillField.fromProviders(
            label: 'Intimidation',
            skillBonusProvider: skillBonusProviders['intimidation']!,
            skillProficiencyProvider: skillProficiencyProviders['intimidation']!,
          ),
          ProficiencySkillField.fromProviders(
            label: 'Investigation',
            skillBonusProvider: skillBonusProviders['investigation']!,
            skillProficiencyProvider: skillProficiencyProviders['investigation']!,
          ),
          ProficiencySkillField.fromProviders(
            label: 'Medicine',
            skillBonusProvider: skillBonusProviders['medicine']!,
            skillProficiencyProvider: skillProficiencyProviders['medicine']!,
          ),
          ProficiencySkillField.fromProviders(
            label: 'Nature',
            skillBonusProvider: skillBonusProviders['nature']!,
            skillProficiencyProvider: skillProficiencyProviders['nature']!,
          ),
          ProficiencySkillField.fromProviders(
            label: 'Perception',
            skillBonusProvider: skillBonusProviders['perception']!,
            skillProficiencyProvider: skillProficiencyProviders['perception']!,
          ),
          ProficiencySkillField.fromProviders(
            label: 'Performance',
            skillBonusProvider: skillBonusProviders['performance']!,
            skillProficiencyProvider: skillProficiencyProviders['performance']!,
          ),
          ProficiencySkillField.fromProviders(
            label: 'Persuasion',
            skillBonusProvider: skillBonusProviders['persuasion']!,
            skillProficiencyProvider: skillProficiencyProviders['persuasion']!,
          ),
          ProficiencySkillField.fromProviders(
            label: 'Religion',
            skillBonusProvider: skillBonusProviders['religion']!,
            skillProficiencyProvider: skillProficiencyProviders['religion']!,
          ),
          ProficiencySkillField.fromProviders(
            label: 'Sleight of Hand',
            skillBonusProvider: skillBonusProviders['sleight_of_hand']!,
            skillProficiencyProvider: skillProficiencyProviders['sleight_of_hand']!,
          ),
          ProficiencySkillField.fromProviders(
            label: 'Stealth',
            skillBonusProvider: skillBonusProviders['stealth']!,
            skillProficiencyProvider: skillProficiencyProviders['stealth']!,
          ),
          ProficiencySkillField.fromProviders(
            label: 'Survival',
            skillBonusProvider: skillBonusProviders['survival']!,
            skillProficiencyProvider: skillProficiencyProviders['survival']!,
          ),
        ],
      ),
    );
  }
}
