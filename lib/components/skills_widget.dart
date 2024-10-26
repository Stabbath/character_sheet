import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/component.dart';
import '../core/providers.dart';
import 'generic/section_header.dart';
import 'generic/skill_field.dart';

class SkillsWidget extends ConsumerWidget {
  final String id;
  final Map<String, StateNotifierProvider<KeyPathNotifier, dynamic>> skillProviders;

  const SkillsWidget({
    super.key,
    required this.id,
    required this.skillProviders,
  });

  SkillsWidget.fromKeyPaths({
    super.key,
    required this.id,
    required Map<String, String> skillKeyPaths,
  }) : skillProviders = skillKeyPaths.map((label, keyPath) => MapEntry(label, getKeyPathProvider(keyPath)));

  factory SkillsWidget.fromComponent(Component component) {
    return SkillsWidget.fromKeyPaths(
      id: component.id,
      skillKeyPaths: component.dataBindings,
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
      if (!skillProviders.containsKey(stat)) {
        throw Exception('SkillsWidget requires a binding for $stat');
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Skills'),
          SkillField(
            label: 'Acrobatics',
            skillProvider: skillProviders['acrobatics']!,
          ),
          SkillField(
            label: 'Animal Handling',
            skillProvider: skillProviders['animal_handling']!,
          ),
          SkillField(
            label: 'Arcana',
            skillProvider: skillProviders['arcana']!,
          ),
          SkillField(
            label: 'Athletics',
            skillProvider: skillProviders['athletics']!,
          ),
          SkillField(
            label: 'Deception',
            skillProvider: skillProviders['deception']!,
          ),
          SkillField(
            label: 'History',
            skillProvider: skillProviders['history']!,
          ),
          SkillField(
            label: 'Insight',
            skillProvider: skillProviders['insight']!,
          ),
          SkillField(
            label: 'Intimidation',
            skillProvider: skillProviders['intimidation']!,
          ),
          SkillField(
            label: 'Investigation',
            skillProvider: skillProviders['investigation']!,
          ),
          SkillField(
            label: 'Medicine',
            skillProvider: skillProviders['medicine']!,
          ),
          SkillField(
            label: 'Nature',
            skillProvider: skillProviders['nature']!,
          ),
          SkillField(
            label: 'Perception',
            skillProvider: skillProviders['perception']!,
          ),
          SkillField(
            label: 'Performance',
            skillProvider: skillProviders['performance']!,
          ),
          SkillField(
            label: 'Persuasion',
            skillProvider: skillProviders['persuasion']!,
          ),
          SkillField(
            label: 'Religion',
            skillProvider: skillProviders['religion']!,
          ),
          SkillField(
            label: 'Sleight of Hand',
            skillProvider: skillProviders['sleight_of_hand']!,
          ),
          SkillField(
            label: 'Stealth',
            skillProvider: skillProviders['stealth']!,
          ),
          SkillField(
            label: 'Survival',
            skillProvider: skillProviders['survival']!,
          ),
        ],
      ),
    );
  }
}
