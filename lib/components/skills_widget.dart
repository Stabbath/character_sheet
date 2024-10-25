import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/component.dart';
import '../core/key_path_providers.dart';
import 'generic/section_header.dart';
import 'generic/skill_field.dart';

class SkillsWidget extends ConsumerWidget {
  final String id;
  final Map<String, Provider<dynamic>> skillProviders;

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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Skills'),
          SkillField(
            label: 'Acrobatics',
            skillProvider: skillProviders['acrobatics'] ?? Provider((ref) => null),
          ),
          SkillField(
            label: 'Animal Handling',
            skillProvider: skillProviders['animal_handling'] ?? Provider((ref) => null),
          ),
          SkillField(
            label: 'Arcana',
            skillProvider: skillProviders['arcana'] ?? Provider((ref) => null),
          ),
          SkillField(
            label: 'Athletics',
            skillProvider: skillProviders['athletics'] ?? Provider((ref) => null),
          ),
          SkillField(
            label: 'Deception',
            skillProvider: skillProviders['deception'] ?? Provider((ref) => null),
          ),
          SkillField(
            label: 'History',
            skillProvider: skillProviders['history'] ?? Provider((ref) => null),
          ),
          SkillField(
            label: 'Insight',
            skillProvider: skillProviders['insight'] ?? Provider((ref) => null),
          ),
          SkillField(
            label: 'Intimidation',
            skillProvider: skillProviders['intimidation'] ?? Provider((ref) => null),
          ),
          SkillField(
            label: 'Investigation',
            skillProvider: skillProviders['investigation'] ?? Provider((ref) => null),
          ),
          SkillField(
            label: 'Medicine',
            skillProvider: skillProviders['medicine'] ?? Provider((ref) => null),
          ),
          SkillField(
            label: 'Nature',
            skillProvider: skillProviders['nature'] ?? Provider((ref) => null),
          ),
          SkillField(
            label: 'Perception',
            skillProvider: skillProviders['perception'] ?? Provider((ref) => null),
          ),
          SkillField(
            label: 'Performance',
            skillProvider: skillProviders['performance'] ?? Provider((ref) => null),
          ),
          SkillField(
            label: 'Persuasion',
            skillProvider: skillProviders['persuasion'] ?? Provider((ref) => null),
          ),
          SkillField(
            label: 'Religion',
            skillProvider: skillProviders['religion'] ?? Provider((ref) => null),
          ),
          SkillField(
            label: 'Sleight of Hand',
            skillProvider: skillProviders['sleight_of_hand'] ?? Provider((ref) => null),
          ),
          SkillField(
            label: 'Stealth',
            skillProvider: skillProviders['stealth'] ?? Provider((ref) => null),
          ),
          SkillField(
            label: 'Survival',
            skillProvider: skillProviders['survival'] ?? Provider((ref) => null),
          ),
        ],
      ),
    );
  }
}
